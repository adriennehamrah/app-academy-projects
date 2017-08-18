require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      foreign_key: "#{name.to_s}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase
    }

    defaults.keys.each do |attr|
      self.send("#{attr}=", options[attr] || defaults[attr])
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: "#{self_class_name.to_s}_id".downcase.to_sym,
      primary_key: :id,
      class_name: name.to_s.singularize.camelcase
    }

    defaults.keys.each do |attr|
      self.send("#{attr}=", options[attr] || defaults[attr])
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    define_method(name) do
      new_options = BelongsToOptions.new(name, options)
      val = self.send(new_options.foreign_key)
      new_options.model_class
        .where(new_options.primary_key => val).first
    end
  end

  def has_many(name, options = {})
    define_method(name) do
      new_options = HasManyOptions.new(name, self.class, options)
      val = self.send(new_options.primary_key)
      new_options.model_class
        .where(new_options.foreign_key => val)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
