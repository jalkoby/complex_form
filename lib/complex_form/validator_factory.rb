require 'active_model/validator'
require 'active_model/validations'

module ComplexForm
  autoload :ValidatorNotFound, 'complex_form/errors'

  module ValidatorFactory
    module_function

    def find(_name)
      name = "#{ _name.to_s.classify }Validator"
      ['ComplexForm', '', 'ActiveModel::Validations'].each do |namespace|
        klass = "#{ namespace }::#{ name }".safe_constantize
        return klass if klass
      end
      raise ComplexForm::ValidatorNotFound, name
    end
  end
end
