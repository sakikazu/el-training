require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'validation' do
    let(:task) { build(:task) }
    subject { task }

    describe 'valid' do
      before do
        task.expired_on = Date.today + 1.day
      end

      it { is_expected.to be_valid }
    end

    describe 'invalid' do
      before do
        task.name = nil
        task.expired_on = Date.today - 1.day
      end

      it 'occurs error' do
        is_expected.not_to be_valid
        expect(task.errors.size).to eq 2
        expect(task.errors.has_key?(:name)).to be_truthy
        expect(task.errors.has_key?(:expired_on)).to be_truthy
      end
    end
  end

  describe '.search' do
    subject { described_class.search(searh_params) }

    before do
      create(:task, name: "task1", status: 1)
      create(:task, name: "task2", status: 1)
      create(:task, name: "task22", status: 2)
      create(:task, name: "task222", status: 1)
      create(:task, name: "task3", status: 1)
      create(:task, name: "task334", status: 1)
      create(:task, name: "task33", status: 0)
      create(:task, name: "task4", status: 1)
      create(:task, name: "task4", status: 2)
    end

    context 'by name only' do
      let(:searh_params) { { name: "task2", status_for_search: nil } }
      it "should found 3 records" do
        expect(subject.size).to eq 3
      end
    end

    context 'by status only' do
      let(:searh_params) { { name: nil, status_for_search: 2 } }
      it "should found 2 records" do
        expect(subject.size).to eq 2
      end
    end

    context 'by name and status' do
      let(:searh_params) { { name: "task2", status_for_search: 1 } }
      it "should found 2 records" do
        expect(subject.size).to eq 2
      end
    end
  end
end
