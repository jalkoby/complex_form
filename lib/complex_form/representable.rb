class ComplexForm::Representable < Struct.new(:object)
  alias :to_model :object

  attr_reader :to_key, :to_param

  def persisted?
    false
  end
end
