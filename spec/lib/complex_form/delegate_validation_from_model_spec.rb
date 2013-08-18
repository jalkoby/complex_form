require 'spec_helper'

describe DelegateValidationFromModelForm do
  subject(:form) { described_class.new }
  let(:user)     { form.user }

  it 'invalid if user invalid' do
    user.name = "  "
    form.should_not be_valid
    form.errors[:user_name].should be_present
  end

  it 'valid is user valid' do
    user.name = Faker::Name.name
    form.should be_valid
  end
end
