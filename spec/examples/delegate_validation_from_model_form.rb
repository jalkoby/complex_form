require 'active_model'

class DelegateValidationFromModelForm < ComplexForm::Base
  class User
    include ActiveModel::Model

    attr_accessor :name

    validates :name, :presence => true
  end

  validate_model :user

  def user
    @user ||= DelegateValidationFromModelForm::User.new
  end
end
