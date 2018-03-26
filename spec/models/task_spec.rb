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
end
