module ComplexForm
  autoload :Property,         'complex_form/property'
  autoload :DelegateProperty, 'complex_form/delegate_property'

  module PropertyFactory
    module_function

    def build(name, options)
      if options.has_key?(:from)
        [ComplexForm::DelegateProperty, name, options]
      else
        [ComplexForm::Property, name, options]
      end
    end
  end
end
