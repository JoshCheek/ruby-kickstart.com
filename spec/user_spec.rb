require 'spec_helper'

describe User do
  
  before :each do
    clean_db
  end
  
  subject do
    User.new :provider => 'some provider',
             :uid      => 'some uid',
             :name     => 'Josh Cheek'
  end
  
  it 'should not be a new record after saving' do
    subject.save
    should_not be_new_record
    subject.id.should == 1
  end
  
  its(:provider) { should == 'some provider' }
  its(:uid)      { should == 'some uid'      }
  its(:name)     { should == 'Josh Cheek'    }
  
  specify '.count should be 1 after saving' do
    User.count.should == 0
    subject.save
    User.count.should == 1
  end
  
  
end