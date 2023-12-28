require 'rails_helper'

RSpec.describe "Drinks", type: :system do
  let(:user) { create(:user) }

  before do
    login(user)
  end

  let(:category) { create(:category, name: "ビール") }

  describe "飲み物登録" do
    it "登録が成功する" do
      category
      find(".day_#{Date.today}").click
      click_on "お酒を追加する"
      fill_in "品名", with: "飲み物"
      fill_in "量", with: 500
      fill_in "アルコール度数", with: 5
      click_on "追加"
      expect(page).to have_content("追加しました")
    end

    it "登録が失敗する" do
      category
      find(".day_#{Date.today}").click
      click_on "お酒を追加する"
      fill_in "品名", with: ""
      fill_in "量", with: 500
      fill_in "アルコール度数", with: 5
      click_on "追加"
      expect(current_path).to eq new_drink_path
      expect(page).to have_content("値が間違っています")
    end

  end

end
