class DelegatePropertyForm < ComplexForm::Base
  property :name,       :from => :user
  property :age,        :from => :user, :validate => { :numericality => { :greater_than => 18 } }
  property :user_email, :from => :user, :source => :email
end
