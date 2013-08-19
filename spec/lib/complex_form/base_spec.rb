require 'spec_helper'

describe ComplexForm::Base do
  context 'defined property methods' do
    it 'define setter and getter' do
      form = SignlePropertyForm.new
      form.should be_respond_to(:name)
      form.should be_respond_to(:name=)
    end

    it 'allow define properties by scope' do
      form = FewPropertiesForm.new
      form.should be_respond_to(:name)
      form.should be_respond_to(:age)
      form.should be_respond_to(:name=)
      form.should be_respond_to(:age=)
    end
  end

  it 'assign values' do
    form = SignlePropertyForm.new
    name = "Alise Woo"
    form.name = name
    form.name.should == name
  end

  it 'behaves like open struct' do
    phone = double('Phone')
    form = SignlePropertyForm.new(:phone => phone)
    form.phone.should == phone
    SignlePropertyForm.new.should_not be_respond_to(:phone)
  end

  context 'validation' do
    context 'active model validation of properties' do
      subject(:form) { ActiveModelValidationForm.new }

      it 'valid name' do
        form.name = Faker::Name.name
        form.valid?
        form.errors[:name].should be_blank
      end

      it 'invalid name' do
        form.name = ""
        form.valid?
        form.errors[:name].should be_present
      end

      it 'valid age' do
        form.age = 34
        form.valid?
        form.errors[:age].should be_blank
      end

      context 'invalid age' do
        specify { form.age = -1 }
        specify { form.age = " " }
        specify { form.age = 3.4 }

        after do
          form.valid?
          form.errors[:age].should be_present
        end
      end
    end

    context 'custom validation' do
      subject(:form) { CustomValidationForm.new }

      it 'day is even' do
        form.day = 2
        form.valid?
        form.errors[:day].should be_blank
      end

      it 'day is odd' do
        form.day = 1
        form.valid?
        form.errors[:day].should be_present
      end

      it 'month is even' do
        form.month = 2
        form.valid?
        form.errors[:month].should be_present
      end

      it 'month is odd' do
        form.month = 1
        form.valid?
        form.errors[:month].should be_blank
      end
    end
  end

  context 'mass assign properties' do
    let(:attrs) { { :name => Faker::Name.name, :age => rand(100) } }
    subject(:form) { FewPropertiesForm.new }

    it '#assign_properties' do
      form.assign_properties(attrs)
    end

    context '#apply' do
      specify { form.apply(attrs).should be_true }

      it 'doesnt pass validation' do
        form.should_receive(:valid?).and_return(false)
        form.apply(attrs).should be_false
      end
    end

    after do
      form.name.should == attrs[:name]
      form.age.should == attrs[:age]
    end
  end
end
