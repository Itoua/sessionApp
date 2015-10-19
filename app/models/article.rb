class Article < ActiveRecord::Base

	validates_presence_of :title, :content 
	belongs_to :user
	has_many :comments, :dependent => :destroy
 
end
