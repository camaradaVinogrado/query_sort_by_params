require 'spec_helper'

describe QuerySortByParams::ParamSortable do
	let(:bob) { create(:owner, :name => 'Bob') }
	let(:pete) { create(:owner, :name => 'Pete') }
	let(:sue) { create(:owner, :name => 'Sue') }

	let(:acme_widget) { create(:widget, :name => 'ACME') }
	let(:cool_widget) { create(:widget, :name => 'Cool Widget') }
	let(:fun_widget) { create(:widget, :name => 'Fun Widget') }

	subject { Widget.all.sort_by_params({:sort_by => @sort_by}) }

	context "when a model has a sortable field" do

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
end
