require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  before do
    login(user)
    find(".nav-item.dropdown").click
    click_on "アカウント設定"
  end
  context "プロフィール編集" do
    it "編集が成功する" do
      fill_in "ユーザーネーム", with: "ユーザー2"
      fill_in "メールアドレス", with: "example@example.com"
      click_on "更新"
      expect(page).to have_current_path(edit_profile_path)
      expect(page).to have_content("更新しました")
    end

    it "編集が失敗する" do
      fill_in "ユーザーネーム", with: ""
      fill_in "メールアドレス", with: "example@example.com"
      click_on "更新"
      expect(page).to have_current_path(edit_profile_path)
      expect(page).to have_content("更新に失敗しました")
      expect(page).to have_content("ユーザーネームを入力してください")
    end
  end

  context "アバター設定" do
    it "アバターを設定する" do
      attach_file 'アバターアイコン', "#{Rails.root}/spec/images/avatar.png"
      click_on "更新"
      expect(page).to have_selector("img[src$='avatar.png']")
    end
  end
end
