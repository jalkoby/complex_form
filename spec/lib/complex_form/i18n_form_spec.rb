require 'spec_helper'

describe I18nForm do
  subject(:klass) { described_class }

  specify { subject.model_name.should == 'I18n' }

  context 'en locale' do
    before do
      I18n.locale = :en
    end

    specify { t_attribute(:l).should == 'Locale' }
    specify { t_attribute(:k).should == 'Key' }
    specify { t_attribute(:v).should == 'Value' }
  end

  context 'ne locale' do
    before do
      I18n.locale = :ne
    end

    specify { t_attribute(:l).should == 'Elacol' }
    specify { t_attribute(:k).should == 'Yek' }
    specify { t_attribute(:v).should == 'Eulav' }
  end

  def t_attribute(key)
    klass.human_attribute_name(key)
  end
end
