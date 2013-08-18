class ComplexForm::Property < Struct.new(:name, :options, :data)
  def get
    @value
  end

  def set(value)
    @value = value
  end
end
