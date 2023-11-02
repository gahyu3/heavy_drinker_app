require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }
  describe "ログイン前" do
    describe "ログイン" do
      before do
        visit login_path
      end
      context "入力値が正常" do
        it "ログインが成功する" do
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: "password"
          click_button "ログイン"
          expect(page).to have_current_path(root_path)
          expect(page).to have_content "ログイン成功です"
          expect(page).to have_link("ログアウト")
        end
      end

      context "入力値が異常" do
        it "ログインが失敗する" do
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: "password"
          click_button "ログイン"
          expect(page).to have_current_path(login_path)
        end
      end
    end
  end
  describe "ログイン後" do
    context "ログアウトボタンクリック" do
      it "ログアウト成功" do
        login(user)
        click_on "ログアウト"
        expect(page).to have_current_path(root_path)
        expect(page).to have_content("ログアウトしました")
        expect(page).to have_link("新規登録")
        expect(page).to have_link("ログイン")
      end
    end
  end
end
