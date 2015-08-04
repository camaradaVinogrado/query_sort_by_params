class WidgetOwner < ActiveRecord::Base
	belongs_to :owner
	belongs_to :widget
end
