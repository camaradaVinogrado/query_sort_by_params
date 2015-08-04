require 'spec_helper'

describe QuerySortByParams::ParamSortable do
	let(:bob) { create(:owner, :name => 'Bob') }
	let(:pete) { create(:owner, :name => 'Pete') }
	let(:sue) { create(:owner, :name => 'Sue') }

	let(:acme_widget) { create(:widget, :name => 'ACME') }
	let(:cool_widget) { create(:widget, :name => 'Cool Widget') }
	let(:fun_widget) { create(:widget, :name => 'Fun Widget') }

	context "when a model has a sortable field" do
		subject { Widget.sort_by_params({:sort_by => @sort_by}) }

		before do
			fun_widget
			cool_widget
			acme_widget
		end

		it "allows the sorting of the model's name ascending" do
			@sort_by = 'name-asc'
			expect(subject.first).to eq acme_widget
		end

		it "allows the sorting of the model's name descending" do
			@sort_by = 'name-desc'
			expect(subject.first).to eq fun_widget
		end
	end

	context "when a model has arbitrary sorting criteria" do
		subject { Widget.sort_by_params({:sort_by => @sort_by}) }

		before do
			fun_widget.owners << bob
			cool_widget.owners << sue
			acme_widget.owners << pete
		end

		it "allows the sorting of the model's association ascending" do
			@sort_by = 'owner_name-asc'
			expect(subject.first).to eq fun_widget
		end

		it "allows the sorting of the model's association descending" do
			@sort_by = 'owner_name-desc'
			expect(subject.first).to eq cool_widget
		end
	end

	context "when there's a default sort order" do
		subject { Widget.sort_by_params({:sort_by => @sort_by, :default => @default}) }

		before do
			fun_widget.owners << bob
			cool_widget.owners << sue
			acme_widget.owners << pete
		end

		context "when the default is a lambda" do
			before do
				@default = ->(query) { query.joins(:owners).order("owners.name desc") }
			end

			context "when the specified sort order exists" do
				before do
					@sort_by = 'id-asc'
				end

				it "uses the specified sort order" do
					expect(subject.first).to eq fun_widget
				end
			end

			context "when the specified sort order doesn't exist" do
				before do
					@sort_by = 'whatever-asc'
				end

				it "uses the default sort order" do
					expect(subject.first).to eq cool_widget
				end
			end
		end
	end
end
