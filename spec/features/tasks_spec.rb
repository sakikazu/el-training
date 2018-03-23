require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  describe '#index' do
    before do
      created_at = Time.parse('2018-03-26 17:50:00')
      1.upto 5 do |n|
        Task.create(name: "taskname#{n}", created_at: created_at + n.hour)
      end
      visit tasks_path
    end

    subject { page }

    it "should display five tasks" do
      expect(all('tbody tr').size).to eq 5
    end

    describe 'sort' do
      describe 'click created_at column' do
        before do
          task3 = Task.where(name: "taskname3").first
          task3.update_attributes(created_at: task3.created_at + 10.hour)
        end

        context 'click once' do
          before do
            click_on('作成日時')
          end

          it 'sort by created_at ASC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[4].text).to eq '2018/03/26 18:50:00'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[4].text).to eq '2018/03/26 19:50:00'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[4].text).to eq '2018/03/27 06:50:00'
          end
        end

        context 'click double' do
          before do
            click_on('作成日時')
            click_on('作成日時')
          end

          it 'sort by created_at DESC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[4].text).to eq '2018/03/27 06:50:00'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[4].text).to eq '2018/03/26 22:50:00'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[4].text).to eq '2018/03/26 18:50:00'
          end
        end
      end
    end
  end
end

