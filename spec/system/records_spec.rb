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
    before do
      login(user)
    end

    let(:category) { create(:category, name: "ビール") }
    let(:drink) { create(:drink, name: "アサヒ", degree: 5, volume: 500, user: user, category: category) }
    
    describe "飲酒記録登録" do
      context "記録の登録" do
        before do
          find(".day_#{Date.today}").click
        end
        it "登録が成功する" do
          category
          drink
          fill_in "アサヒ", with: 1
          click_on "保存"
          expect(page).to have_current_path(records_path)
          expect(page).to have_content("記録しました")
          expect(page).to have_css(".fa-solid.fa-champagne-glasses")
        end

        it "登録が失敗する" do
          category
          drink
          fill_in "アサヒ", with: 0
          click_on "保存"
          expect(current_path).to eq new_record_path
        end

      end
    end
    
    it "カレンダーが表示されている" do
      login(user)
      expect(page).to have_current_path(records_path)
      expect(page).to have_css(".simple-calendar")
    end
  end

end
