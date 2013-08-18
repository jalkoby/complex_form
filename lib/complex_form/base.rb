require 'active_support/core_ext'
require 'active_model/naming'
require 'active_model/translation'
require 'active_model/errors'

class ComplexForm::Base
  extend ActiveModel::Translation

  class << self
    def properties(*args)
      if args.last.is_a?(Hash)
        options = args.pop
      else
        options = {}
      end

      @schema ||= []
      args.each do |name|
        @schema << ComplexForm::PropertyFactory.build(name, options)

        define_method(name)         { schema[name].get }
        define_method("#{ name }=") { |value| schema[name].set(value) }
      end
    end

    alias :property :properties

    def schema
      @schema ||= []
    end

    def i18n_scope
      :complexform
    end
  end

  def initialize(data = {})
    data.each do |key, value|
      define_singleton_method(key, lambda { value })
    end
    @schema = {}
    self.class.schema.each do |(klass, name, options)|
      schema[name] = klass.new(name, options, self)
    end
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  def valid?
    errors.clear
    schema.each { |_, property| property.validate }
    errors.empty?
  end

  alias_method :read_attribute_for_validation, :send

  private

  def schema
    @schema
  end
end
