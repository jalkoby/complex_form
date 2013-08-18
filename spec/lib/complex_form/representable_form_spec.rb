require 'spec_helper'

describe ComplexForm::Base, 'representable functionality' do
  let(:user) { double("User", :persisted? => true, :to_key => "22", :to_param => ["22"], :to_model => "ToModel") }

  context 'default case' do
    subject(:form) { SignlePropertyForm.new }

    specify { SignlePropertyForm.model_name.should == "SignleProperty" }
    specify { form.to_model.should == form }
    specify { form.should_not be_persisted }
    specify { form.to_key.should be_nil }
    specify { form.to_param.should be_nil }
  end

  context 'simple representable' do
    subject(:form) { RepresentableForm.new(:user => user) }

    specify { RepresentableForm.model_name.should == "User" }
    specify { form.to_model.should == "ToModel" }
    specify { form.should be_persisted }
    specify { form.to_key.should == "22" }
    specify { form.to_param.should == ["22"] }
  end

  context 'configured representable' do
    subject(:form) { RepresentableWithCustomNameForm.new(:user => user) }

    specify { RepresentableWithCustomNameForm.model_name.should == "Actor" }
    specify { form.to_model.should == "ToModel" }
    specify { form.should be_persisted }
    specify { form.to_key.should == "22" }
    specify { form.to_param.should == ["22"] }
  end
end
