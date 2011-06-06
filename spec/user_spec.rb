require 'spec_helper'

describe User do
  
  subject do
    User.new :provider => 'some provider',
             :uid      => 'some uid',
             :name     => 'Josh Cheek'
  end
  
  it 'should not be a new record after saving' do
    subject.save
    should_not be_new_record
  end
  
  its(:provider) { should == 'some provider' }
  its(:uid)      { should == 'some uid'      }
  its(:name)     { should == 'Josh Cheek'    }
  
end