class ActiveModelValidationForm < ComplexForm::Base
  property :name, :validate => { :presence => true }
  properties :age, :validate => {
                      :presence => true,
                      :numericality => { :greater_than_or_equal_to => 0 , :only_integer => true }
                    }
end
