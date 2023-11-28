require 'rails_helper'

RSpec.describe "Ranks", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:category_beer) { create(:category, name: "ビール") }
  let(:drink_beer) { create(:drink, name: "中瓶", volume: 500, degree: 5, user: user, category: category_beer) }
  let(:other_drink_beer) { create(:drink, name: "中瓶", volume: 500, degree: 5, user: other_user, category: category_beer ) }
  let(:record_today) { create(:record, date: Date.today, quantity: 5, user: user, drink: drink_beer) }
  let(:record_yesterday) { create(:record, date: Date.yesterday, quantity: 5, user: user, drink: drink_beer) }
  let(:record_last_week) { create(:record, date: Date.today - 7, quantity: 5, user: user, drink: drink_beer) }
  let(:otehr_record) { create(:record, date: Date.today, quantity: 3, user: other_user, drink: other_drink_beer) }

  describe "ランキングページ" do

    before do
      login(user)
    end

    it "ランキングが表示される" do
      category_beer
      drink_beer
      record_today
      otehr_record

      click_on 'ランキング'
      expect(page).to have_content(user.name)
      expect(page).to have_content(other_user.name)

    end

    it "月間ランキングが表示される" do
      category_beer
      drink_beer
      record_today
      record_yesterday
      record_last_week

      click_on 'ランキング'
      expect(page).to have_content(user.name)
      expect(page).to have_content("300")
    end

    it "週間ランキングが表示される" do
      category_beer
      drink_beer
      record_today
      record_yesterday

      click_on 'ランキング'
      choose '週間'
      click_button '表示'
      expect(page).to have_content(user.name)
      expect(page).to have_content("200")

    end

    it "日間ランキングが表示される" do
      category_beer
      drink_beer
      record_today
      click_on 'ランキング'
      choose '日間'
      click_button '表示'
      expect(page).to have_content(user.name)
      expect(page).to have_content("100")

    end

  end
end
