require 'spec_helper'

describe StandAloneForm do
  context 'defined property methods' do
    it 'define setter and getter' do
      should be_respond_to(:email)
      should be_respond_to(:email=)
    end

    it 'allow define properties by scope' do
      should be_respond_to(:first_name)
      should be_respond_to(:age)
      should be_respond_to(:first_name=)
      should be_respond_to(:age=)
    end
  end

  it 'assign values' do
    email = "joe.doe@mail.com"
    subject.email = email
    subject.email.should == email
  end

  it 'behaves like open struct' do
    phone = double('Phone')
    subject = described_class.new(:phone => phone)
    subject.phone.should == phone
    described_class.new.should_not be_respond_to(:phone)
  end
end
