require 'sqlite3'
require_relative 'user.rb'
require_relative 'question.rb'

class Reply
  attr_accessor :question_id, :parent_id, :user_id, :body
  attr_reader :id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map{|datum| Reply.new(datum)}
  end

  def find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL

    Reply.new(reply.first)
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_id, @user_id, @body)
      INSERT INTO
        replies(question_id, parent_id, user_id, body)
      VALUES
        (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies
      WHERE user_id = ?
    SQL

    replies.map{|reply| Reply.new(reply)}
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies
      WHERE question_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM users
      WHERE id = ?
    SQL

    User.new(author.first)
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    Question.new(question.first)
  end

  def parent_reply
    parent = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT *
      FROM replies
      WHERE parent_id = ?
    SQL

    Reply.new(parent.first)
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE parent_id = ?
    SQL

    children.map { |child| Reply.new(child) }
  end

end
