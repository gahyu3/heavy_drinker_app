require 'rails_helper'

RSpec.describe "Records", type: :system do
  let(:user) { create(:user) }
  describe "ログイン前" do
    it "飲酒量記録ページにアクセスが失敗する" do
      visit records_path
      expect(page).to have_current_path(login_path)
      expect(page).to have_content "ログインしてください"
    end 
  end

  describe "ログイン後" do
    
    it "カレンダーが表示されている" do
      login(user)
      expect(page).to have_current_path(records_path)
      expect(page).to have_css(".simple-calendar")
    end
  end

end
