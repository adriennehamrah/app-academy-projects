require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    param_names = params.keys
    where_line = param_names.map do |name|
      "#{name} = ?"
    end.join(' AND ')

    res = DBConnection.execute(<<-SQL, params.values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_line}
    SQL

    self.parse_all(res)
  end
end

class SQLObject
  extend Searchable
end
