module QuerySortByParams
	module ParamSortable
		extend ActiveSupport::Concern

		included do
		end

		module ClassMethods
			def sort_by_params(params = {})
				the_params = params.dup.with_indifferent_access
				if the_params[:sort_by].present? && (match = the_params[:sort_by].to_s.match(/([a-zA-Z_]*)-([a-zA-Z]*)/)) && (2 < match.size)
					matches = match.to_a
					matched_direction = matches.pop.downcase
					matched_field_name = matches.pop.downcase
					field_name = self.columns_hash.keys.select { |key| key == matched_field_name }.first
					if matched_direction == 'desc'
						direction = 'desc'
					else
						direction = 'asc'
					end
					if field_name.present?
						order(field_name => direction)
					end
				else
					self
				end
			end

			def sort_fields(options = {})
				@@fields_to_sort ||= {}
				unless @@fields_to_sort.try(:[], self.to_s).present?
					@@fields_to_sort[self.to_s] = {}.with_indifferent_access
				end
				options.each do |key, value|
					@@fields_to_sort[self.to_s][key.to_sym] = value
				end
			end
		end
	end
end
ActiveRecord::Base.send :include, QuerySortByParams::ParamSortable
