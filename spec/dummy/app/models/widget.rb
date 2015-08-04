class Widget < ActiveRecord::Base
	has_many :widget_owners
	has_many :owners, :through => :widget_owners

	sort_fields :owner_name => ->(query, direction) { query.joins(:owners).order("owners.name #{direction}") }
end
