class Widget < ActiveRecord::Base
	has_many :widget_owners
	has_many :owners, :through => :widget_owners
end
