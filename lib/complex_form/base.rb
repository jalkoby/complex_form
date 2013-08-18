require 'active_support/core_ext'
require 'active_model/naming'
require 'active_model/translation'
require 'active_model/errors'

class ComplexForm::Base
  extend ActiveModel::Translation

  class << self
    def i18n_scope
      :complexform
    end

    def schema
      @schema ||= []
    end

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

    def validate_model(*list)
      @validate_model_names ||= []
      @validate_model_names |= list
    end
    alias :validate_models :validate_model

    def validate_model_names
      @validate_model_names ||= []
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
    self.class.validate_model_names.each do |model_name|
      model = send(model_name)
      next if model.valid?
      model.errors.each { |attribute, error| errors.add(:"#{ model_name }_#{ attribute }", error) }
    end
    errors.empty?
  end

  alias_method :read_attribute_for_validation, :send

  private

  def schema
    @schema
  end
end
