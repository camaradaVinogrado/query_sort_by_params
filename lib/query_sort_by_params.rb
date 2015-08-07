module QuerySortByParams
	module ParamSortable
		extend ActiveSupport::Concern

		included do
		end

		module ClassMethods
			def sort_by_params(params = {}, options = {})
				the_params = params.dup.with_indifferent_access
				if options.key? :default
					default_sort = options[:default]
				else
					default_sort = the_params.key?(:default) ? the_params[:default] : nil
				end
				if the_params[:sort_by].present? && (match = the_params[:sort_by].to_s.match(/([a-zA-Z_]*)-([a-zA-Z]*)/)) && (2 < match.size)
					@@fields_to_sort ||= {}
					unless @@fields_to_sort.try(:[], self.to_s).present?
						@@fields_to_sort[self.to_s] = {}.with_indifferent_access
					end
					matches = match.to_a
					matched_direction = matches.pop.downcase
					matched_field_name = matches.pop.downcase
					if matched_direction == 'desc'
						direction = 'desc'
					else
						direction = 'asc'
					end

					if @@fields_to_sort[self.to_s].key? matched_field_name
						if @@fields_to_sort[self.to_s][matched_field_name].is_a? Proc
							@@fields_to_sort[self.to_s][matched_field_name].call(self, direction)
						else
							if the_params.key? :default
							else
								default_sort.present? ? default_sort.call(self) : self.all
							end
						end
					else
						field_name = self.columns_hash.keys.select { |key| key == matched_field_name }.first
						if field_name.present?
							order(field_name => direction)
						else
							default_sort.present? ? default_sort.call(self) : self.all
						end
					end
				else
					default_sort.present? ? default_sort.call(self) : self.all
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
