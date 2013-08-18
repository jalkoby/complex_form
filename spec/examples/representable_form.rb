class RepresentableForm < ComplexForm::Base
  represent :user
end

class RepresentableWithCustomNameForm < ComplexForm::Base
  represent :actor, :source => :user
end
