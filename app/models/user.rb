class User < ActiveRecord::Base
	has_many :timelines
end