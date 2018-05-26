require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  describe '#index' do
    let(:expired_on_base) { Date.new(2018, 3, 25) }

    before do
      # NOTE: expired_onのバリデーションを通すためにDate.todayをスタブ
      allow(Date).to receive(:today).and_return(expired_on_base)
      created_at = Time.parse('2018-03-26 17:50:00')
      expired_on_base = Date.today
      1.upto 5 do |n|
        Task.create(
            name: "taskname#{n}",
            created_at: created_at + n.hour,
            expired_on: expired_on_base + n.day
        )
      end
      visit tasks_path
    end

    subject { page }

    it "should display five tasks" do
      expect(all('tbody tr').size).to eq 5
    end

    describe 'delete', js: true do
      it 'is deleted task' do
        expect {
          all('table.tasks_list tbody tr')[0].find_link('削除').click
          page.accept_confirm
          expect(page).to have_content 'タスクを削除しました。'
        }.to change(Task, :count).by(-1)
      end
    end

    describe 'sort' do
      describe 'by created_at' do
        before do
          task3 = Task.where(name: "taskname3").first
          task3.update_attributes(created_at: task3.created_at + 10.hour)
        end

        context 'click column once' do
          before do
            click_on('作成日時')
          end

          it 'sort by created_at ASC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[5].text).to eq '2018/03/26 18:50'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[5].text).to eq '2018/03/26 19:50'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[5].text).to eq '2018/03/27 06:50'
          end
        end

        context 'click column double' do
          before do
            click_on('作成日時')
            click_on('作成日時')
          end

          it 'sort by created_at DESC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[5].text).to eq '2018/03/27 06:50'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[5].text).to eq '2018/03/26 22:50'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[5].text).to eq '2018/03/26 18:50'
          end
        end
      end

      describe 'by expired_on' do
        before do
          task3 = Task.where(name: "taskname3").first
          task3.update_attributes(expired_on: expired_on_base + 10.day)
        end

        context 'click column once' do
          before do
            click_on('終了期限')
          end

          it 'sort by expired_on ASC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[3].text).to eq '2018/03/26'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[3].text).to eq '2018/03/27'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[3].text).to eq '2018/04/04'
          end
        end

        context 'click column double' do
          before do
            click_on('終了期限')
            click_on('終了期限')
          end

          it 'sort by expired_on DESC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[3].text).to eq '2018/04/04'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[3].text).to eq '2018/03/30'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[3].text).to eq '2018/03/26'
          end
        end
      end

      describe 'by expired_on' do
        before do
          task3 = Task.where(name: "taskname3").first
          task3.update_attributes(expired_on: Date.today + 10.day)
        end

        context 'click column once' do
          before do
            click_on('終了期限')
          end

          it 'sort by expired_on ASC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[2].text).to eq I18n.l(Date.today + 1.day)
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[2].text).to eq '2018/03/26 19:50:00'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[2].text).to eq '2018/03/27 06:50:00'
          end
        end

        context 'click column double' do
          before do
            click_on('終了期限')
            click_on('終了期限')
          end

          it 'sort by expired_on DESC' do
            expect(all('table.tasks_list > tbody > tr')[0].all('td')[2].text).to eq '2018/03/27 06:50:00'
            expect(all('table.tasks_list > tbody > tr')[1].all('td')[2].text).to eq '2018/03/26 22:50:00'
            expect(all('table.tasks_list > tbody > tr')[4].all('td')[2].text).to eq '2018/03/26 18:50:00'
          end
        end
      end
    end
  end
end

