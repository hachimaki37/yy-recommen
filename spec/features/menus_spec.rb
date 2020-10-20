require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.describe "メニュー投稿", js: true do
  describe 'アカウント登録ユーザがおすすめメニューを投稿できること' do
    before do
      visit signup_path
      fill_in 'user_name', with: 'test'
      fill_in 'user_email', with: 'yy-test@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'アカウント登録'
    end

    context 'メニュー投稿' do
      before do
        visit menus_path
        click_on 'オススメを投稿する'
      end

      scenario '投稿がsuccessし、一覧画面に表示されること' do
        expect(page).to have_content '投稿'
        fill_in 'menu_name', with: 'test'
        fill_in 'menu_recommend_title', with: 'ダイエット'
        fill_in 'menu_description', with: 'ヘルシーです'

        click_on 'オススメを投稿する'

        expect(page).to have_content '投稿が完了しました'
        expect(page).to have_content 'みんなのおすすめ！'
      end

      scenario '投稿がdangerし、エラー表示されること' do
        expect(page).to have_content '投稿'
        fill_in 'menu_name', with: 'test'
        fill_in 'menu_recommend_title', with: 'ダイエット'

        click_on 'オススメを投稿する'

        expect(page).to have_content '投稿が失敗しました'
      end
    end
  end
end
driver.quit
