require 'sqlite3'
require_relative 'user.rb'
require_relative 'question.rb'

class QuestionFollow
  attr_accessor :user_id, :question_id
  attr_reader :id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.map{|datum| QuestionFollow.new(datum)}
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE id = ?
    SQL

    followers.map {|follower| User.new(follower)}
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE user_id = ?
    SQL

    questions.map {|q| Question.new(q)}
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE question_id = ?
    SQL

    followers.map {|follower| User.new(follower)}
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    -- var = #{n}
      SELECT questions.*
      FROM questions
      JOIN question_follows ON question_follows.question_id = questions.id
      GROUP BY questions.id
      ORDER BY COUNT(*) DESC
      LIMIT ?
    SQL
    questions.map {|q| Question.new(q)}
  end

  def find_by_id(id)
    question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_follows
      WHERE id = ?
    SQL

    QuestionFollow.new(question_follows.first)
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
      INSERT INTO
        question_follows(user_id, question_id)
      VALUES
        (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
  end

end
