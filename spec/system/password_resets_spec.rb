require 'rails_helper'

RSpec.describe "PasswordResets", type: :system do
  let(:user) { create(:user) }
  describe "リセットメール" do
    it "リセットメール送信" do
      visit new_password_reset_path
      fill_in "メールアドレス", with: user.email
      click_on "送信"
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("メールを送信しました")
    end
  end
end
