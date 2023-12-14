require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let(:user) { create(:user) }
  let(:notification_day) { create(:notification, rank: 1, period: :day, check: false, start_date: Date.today, end_date: Date.today, user: user)}
  let(:notification_week) { create(:notification, rank: 2, period: :week, check: false, start_date: Date.today.beginning_of_week, end_date: Date.today.end_of_week, user: user)}
  let(:notification_month) { create(:notification, rank: 3, period: :month, check: false, start_date: Date.today.beginning_of_month, end_date: Date.today.end_of_month, user: user) }
  let(:notification_true) { create(:notification, rank: 1, period: :day, check: true, start_date: Date.today, end_date: Date.today, user: user)}


  describe "通知機能" do
    before do
      login(user)
    end
    context "通知の表示" do
      it "日間の順位が表示される" do
        notification_day
        find('.fa-regular.fa-bell').click
        expect(page).to have_content(Date.today.strftime("%m月%d日"))
        expect(page).to have_content("1位")
      end
      it "週間の順位が表示される" do
        notification_week
        find('.fa-regular.fa-bell').click
        expect(page).to have_content(Date.today.beginning_of_week.strftime("%m月%d日"))
        expect(page).to have_content(Date.today.end_of_week.strftime("%m月%d日"))
        expect(page).to have_content("2位")
      end
      it "月間の順位が表示される" do
        notification_month
        find('.fa-regular.fa-bell').click
        expect(page).to have_content(Date.today.beginning_of_month.strftime("%m月"))
        expect(page).to have_content("3位")
      end
    end
    context "未読の通知" do
      it "アイコンが表示される" do
        notification_day
        expect(page).to have_css(".fa-regular.fa-bell")
      end
    end
    context "既読の通知" do
      it "アイコンが表示される" do
        notification_true
        expect(page).to have_css(".fa-regular.fa-bell-slash")
      end
    end
  end
end
