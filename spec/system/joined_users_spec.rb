require 'rails_helper'

RSpec.describe "RecruitingPositions", type: :system do
  describe '募集に参加' do
    let(:user) { create(:user, :fill_game_name) }
    let(:another_user) { create(:user, :fill_game_name) }

    it '新規募集に参加できる' do
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
      expect(page).to have_link 'ゲームスタート(モンスト起動)'
      expect(page).to have_content another_user.name
    end

    it '募集者に参加ボタンが表示されない' do
      login(user)
      post = create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      visit post_path(post)
      expect(page).not_to have_link '参加する'
    end

    it '参加者にスタートボタンが表示されない' do
      login(user)
      post = create(:post, user_id: user.id) do |p|
        p.recruiting_positions.create(FactoryBot.attributes_for(:recruiting_position))
      end
      logout(user)
      login(another_user)
      visit post_path(post)
      expect(page).not_to have_link 'start-button'
    end
  end
end