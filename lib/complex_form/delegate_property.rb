class ComplexForm::DelegateProperty < ComplexForm::Property
  def get
    source.send(source_method)
  end

  def set(value)
    source.send("#{ source_method }=", value)
  end

  private

  def source
    @source ||= form.send(options[:from])
  end

  def source_method
    @source_method ||= options[:source] || name
  end
end
