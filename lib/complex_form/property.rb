class ComplexForm::Property
  attr_reader :name, :options, :form

  def initialize(name, options, form)
    @name, @options, @form = name, options, form

    @validators = []
    if validations = options[:validate]
      validations.each do |validator_name, _options|
        options = _options.is_a?(Hash) ? _options : {}
        @validators << ComplexForm::ValidatorFactory.find(validator_name).new(options.merge(:attributes => [name]))
      end
    end
  end

  def get
    @value
  end

  def set(value)
    @value = value
  end

  def errors
    form.errors
  end

  def validate
    validators.each { |validator| validator.validate(self) }
  end

  def read_attribute_for_validation(key)
    (key == name) ? get : send(key)
  end

  private

  def validators
    @validators
  end
end
