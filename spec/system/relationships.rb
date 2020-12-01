require 'rails_helper'

RSpec.describe "RecruitingPositions", type: :system do
  describe 'お気に入り機能' do
    let(:user) { create(:user, :fill_game_name) }
    let(:another_user) { create(:user, :fill_game_name) }

    it 'お気に入りできる' do
      login(user)
      post = create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      logout(user)
      login(another_user)
      visit post_path(post)
      click_on '参加する'
      logout(another_user)
      login(user)
      visit post_path(post)
      click_on 'start-button'
      click_on 'お気に入りする'
      sleep 0.1
      visit edit_user_path(user)
      click_on 'フォローリスト'
      expect(page).to have_content 'フォローリスト'
      expect(page).to have_content another_user.name
    end

    it 'お気に入り解除できる' do
      create(:relationship, follower_id: user.id, followed_id: another_user.id)
      login(user)
      visit edit_user_path(user)
      click_on 'フォローリスト'
      expect(page).to have_content another_user.name
      click_on 'お気に入り解除'
      expect(page).not_to have_content another_user.name
    end

    it '参加リクエストからお気に入りされた人の募集が確認できる' do
      post = create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      create(:relationship, follower_id: user.id, followed_id: another_user.id)
      login(another_user)
      click_on 'request-image-link'
      expect(page).to have_content '自分をお気に入りした人の募集一覧'
      expect(page).to have_content post.quest_name
    end
  end
end