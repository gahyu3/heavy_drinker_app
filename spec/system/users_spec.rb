require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  describe "ログイン前" do
    describe "新規登録" do
      before do
        visit new_user_path
      end
      context "入力値が正常" do
        it "登録が成功する" do
          fill_in "ユーザーネーム", with: "name"
          fill_in "メールアドレス", with: "name@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード確認", with: "password"
          click_button "登録"
          expect(page).to have_current_path(login_path)
          expect(page).to have_content "登録に成功しました"
        end
      end

      context "入力値が異常" do
        it "登録が失敗する" do
          fill_in "ユーザーネーム", with: ""
          fill_in "メールアドレス", with: "name@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード確認", with: "password"
          click_button "登録"
          expect(page).to have_current_path(new_user_path)
          expect(page).to have_content "ユーザーネームを入力してください"
        end
      end
    end
  end

end
