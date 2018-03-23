require 'rails_helper'

RSpec.feature 'Tasks', type: :feature, js: true do
  describe '#index' do
    before do
      1.upto 3 do |n|
        Task.create(name: "aa")
      end
      visit tasks_path
    end

    subject { page }

    it "should display three tasks" do
      expect(all('tbody tr').size).to eq 3
    end
  end
end

