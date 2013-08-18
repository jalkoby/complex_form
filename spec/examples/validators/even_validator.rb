require 'active_model/validator'

class EvenValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    object.errors.add(attribute, :not_even) unless value && value.even?
  end
end
