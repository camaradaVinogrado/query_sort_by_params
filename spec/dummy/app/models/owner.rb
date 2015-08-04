class Owner < ActiveRecord::Base
	has_many :widget_owners
	has_many :widgets, :through => :widget_owners
end
