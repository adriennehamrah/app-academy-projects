require 'sqlite3'
require 'singleton'
require_relative  'user.rb'
require_relative  'reply.rb'
require_relative  'question_follow.rb'
require_relative  'question_like.rb'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :title, :body, :author_id
  attr_reader :id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map{|datum| Question.new(datum)}
  end

  def find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    Question.new(question.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions(title, body, author_id)
      VALUES
        (?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM questions
      WHERE author_id = ?
    SQL

    questions.map{|question| Question.new(question)}
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(author.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

end
