require 'rails_helper'

RSpec.describe "Dates", type: :system do
let(:user) { create(:user) }
  let(:category_beer) { create(:category, name: "ビール") }
  let(:category_wine) { create(:category, name: "ワイン") }
  let(:drink_beer) { create(:drink, name: "中瓶", volume: 500, degree: 5, user: user, category: category_beer) }
  let(:drink_wine) { create(:drink, name: "グラスワイン", volume: 300, degree: 8, user: user, category: category_wine) }
  let(:record_today) { create(:record, date: Date.today, quantity: 5, user: user, drink: drink_beer) }
  let(:record_yesterday) { create(:record, date: Date.yesterday, quantity: 3, user: user, drink: drink_wine) }

  before do
    @before_snapshot = Record.all.map(&:attributes)
    login(user)
  end

  after(:each) do
    # テスト後のデータベーススナップショット取得
    @after_snapshot = Record.all.map(&:attributes)

    # スナップショットを比較するか、変更があるかを確認するロジックを追加
    expect(@after_snapshot).to eq(@before_snapshot)
  end

  
  describe "データ画面" do
    it "月の純アルコール量が表示される" do
      category_beer
      category_wine
      drink_beer
      drink_wine
      record_today
      record_yesterday

      click_on 'データ'
      expect(page).to have_content("ビール")
      expect(page).to have_content("ワイン")
      expect(page).to have_content(100)
      expect(page).to have_content(58)
      expect(page).to have_content(158)
    end
  end
end
