require 'rails_helper'

RSpec.describe "RecruitingPositions", type: :system do
  describe 'ブロック機能' do
    let(:user) { create(:user, :fill_game_name) }
    let(:another_user) { create(:user, :fill_game_name) }

    it 'ブロッックできる' do
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
      click_on 'ブロックする'
      sleep 0.1
      visit edit_user_path(user)
      click_on 'ブロックリスト'
      expect(page).to have_content 'ブロックリスト'
      expect(page).to have_content another_user.name
    end

    it 'ブロック解除できる' do
      create(:blacklist, user_id: user.id, target_user_id: another_user.id)
      login(user)
      visit edit_user_path(user)
      click_on 'ブロック'
      expect(page).to have_content another_user.name
      click_on 'ブロック解除'
      expect(page).not_to have_content another_user.name
    end

    it 'ブロックされた人の募集が一覧に表示されない' do
      post = create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      create(:blacklist, user_id: user.id, target_user_id: another_user.id)
      login(another_user)
      visit root_path
      expect(page).not_to have_content post.quest_name
    end

    it 'ブロックされた人の募集ページに遷移できない' do
      post = create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      create(:blacklist, user_id: user.id, target_user_id: another_user.id)
      login(another_user)
      visit post_path(post)
      expect(page).to have_content '入室が許可されていません'
      expect(current_path).to eq root_path
    end
  end
end