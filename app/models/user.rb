class User < ActiveRecord::Base
	self.primary_key = 'id'
	has_many :timelines
end