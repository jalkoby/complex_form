require 'active_model/validator'

class ComplexForm::OddValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    object.errors.add(attribute, :not_odd) unless value && value.odd?
  end
end
