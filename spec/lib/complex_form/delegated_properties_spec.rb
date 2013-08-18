require 'spec_helper'
require 'ostruct'

describe ComplexForm::Base, 'Delegated properties' do
  let(:name)     { Faker::Name.name }
  let(:age)      { 22 }
  let(:email)    { Faker::Internet.email }
  let(:user)     { OpenStruct.new(:name => name, :age => age, :email => email) }
  subject(:form) { DelegatePropertyForm.new(:user => user) }

  it 'form instantly assign value' do
    new_name = Faker::Name.name
    form.name = new_name
    user.name.should == new_name
  end

  it 'allow apply validations' do
    user.age = 16
    form.should_not be_valid
    form.errors[:age].should be_present
  end

  it 'may have another name than in source object' do
    form.user_email.should == email
  end
end
