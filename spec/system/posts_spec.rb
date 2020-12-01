require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe '一覧画面' do
    it '一覧画面(トップページが確認できる)' do
      visit root_path
      expect(page).to have_content '採用担当者様へ：'
    end
  end

  describe '募集の投稿' do
    let(:user) { create(:user, :fill_game_name) }

    before do
      login(user)
    end

    it '正常なテンプレートで募集が投稿できる' do
      recruit_page_and_put_template
      uncheck 'quest_form[tweet_post]'
      click_button '募集開始'
      expect(page).to have_content '募集詳細'
    end

    it '不正なテンプレートで募集ができない' do
      click_on 'recruit-image-link'
      fill_in 'input-quest-body', with: 'hogehoge'
      expect(page).to have_content 'ラインの募集文をそのまま貼り付けてください'
    end

    it '投稿した募集が一覧から確認できる' do
      user
      create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      visit root_path
      expect(page).to have_content 'テストクエスト'
    end

    it '「募集中　参加中」ボタンから自分の募集が確認できる' do
      recruit_page_and_put_template
      uncheck 'quest_form[tweet_post]'
      click_button '募集開始'
    end
  end
end


















