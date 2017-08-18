require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    col = DBConnection.execute2(<<-SQL).first
      SELECT *
      FROM "#{self.table_name}"
      LIMIT 0
    SQL

    @columns = col.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |arg|
        self.attributes[col] = arg
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    arr_hash = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL

    self.parse_all(arr_hash)
  end

  def self.parse_all(results)
    res = []
    results.each do |params|
      res << self.new(params)
    end

    res
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE #{self.table_name}.id = ?
    SQL

    parse_all(results).first
  end

  def initialize(params = {})
    params.each do |name, val|
      attr_name = name.to_sym

      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=", val)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # @attributes.values

    self.class.columns.map { |col_name| self.send(col_name) }
  end

  def insert
    columns = self.class.columns
    col_names = columns.map(&:to_s).join(', ')
    q_marks = (['?'] * columns.size).join(', ')

    col_val = attribute_values

    DBConnection.execute(<<-SQL, *col_val)
      INSERT INTO #{self.class.table_name} (#{col_names})
      VALUES (#{q_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns
    set_col_line = columns.map do |col_name|
      "#{col_name} = ?"
    end.join(', ')

    col_val = attribute_values

    DBConnection.execute(<<-SQL, *col_val, self.id)
      UPDATE #{self.class.table_name}
      SET #{set_col_line}
      WHERE id = ?
    SQL

  end

  def save
    id ? update : insert
  end
end
