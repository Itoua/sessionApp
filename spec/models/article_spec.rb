require 'rails_helper'

RSpec.describe Article, :type => :model do

	describe "validation" do
	   it { should validate_presence_of :title }
       it { should validate_presence_of :content }
    end

    describe "association" do
    	it { should belong_to :user }
    	it { should have_many :comments}
    end

end