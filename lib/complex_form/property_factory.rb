module ComplexForm
  autoload :Property, 'complex_form/property'

  module PropertyFactory
    module_function

    def build(name, options)
      [ComplexForm::Property, name, options]
    end
  end
end
