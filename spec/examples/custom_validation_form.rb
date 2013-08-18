class CustomValidationForm < ComplexForm::Base
  property :day,   :validate => { :even => true }
  property :month, :validate => { :odd => true }
end
