require 'rails_helper'

RSpec.describe "NotificationSettings", type: :system do
  let(:user) { create(:user) }
  let(:notification_setting){ create(:notification_setting, user: user) }
  let(:notification_setting_false){ create(:notification_setting, day: false, week: false, month: false, user: user) }


  describe "通知設定" do
    before do
      login(user)
    end

    context "通知変更" do
      it "通知の切り替えが成功する" do
        notification_setting
        find(".nav-item.dropdown").click
        click_on '通知設定'
        uncheck '日間ランキング'
        click_on '更新'
        expect(page).to have_content('更新しました')
      end
    end

    context "通知が有効" do
      it "日間ランキングの通知が有効" do
        notification_setting
        find(".nav-item.dropdown").click
        click_on '通知設定'
        expect(page).to have_checked_field('日間ランキング')
      end
      it "週間ランキングの通知が有効" do
        notification_setting
        find(".nav-item.dropdown").click
        click_on '通知設定'
        expect(page).to have_checked_field('週間ランキング')
      end
      it "月間ランキングの通知が有効" do
        notification_setting
        find(".nav-item.dropdown").click
        click_on '通知設定'
        expect(page).to have_checked_field('月間ランキング')
      end
    end

    context "通知が無効" do
      it "日間ランキングの通知が無効" do
        notification_setting_false
        find(".nav-item.dropdown").click
        click_on '通知設定'
        expect(page).to have_unchecked_field('日間ランキング')
      end
      it "週間ランキングの通知が無効" do
        notification_setting_false
        find(".nav-item.dropdown").click
        click_on '通知設定'
        expect(page).to have_unchecked_field('週間ランキング')
      end
      it "月間ランキングの通知が無効" do
        notification_setting_false
        find(".nav-item.dropdown").click
        click_on '通知設定'
        expect(page).to have_unchecked_field('月間ランキング')
      end
    end
  end

end
