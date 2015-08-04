require 'spec_helper'

describe QuerySortByParams::ParamSortable do
	context "when a model has a sortable field" do
		let(:bob) { create(:widget, :name => 'Bob') }
		let(:pete) { create(:widget, :name => 'Pete') }
		let(:sue) { create(:widget, :name => 'Sue') }

		before do
			sue
			pete
			bob
		end

		it "allows the sorting of the model's name ascending" do
			expect(Widget.all.sort_by_params({:sort_by => 'name-asc'}).first).to eq bob
		end

		it "allows the sorting of the model's name descending" do
			expect(Widget.all.sort_by_params({:sort_by => 'name-desc'}).first).to eq sue
		end
	end
end
