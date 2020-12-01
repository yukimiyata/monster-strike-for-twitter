require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'Userデータ' do
    let(:user) { create(:user) }

    before do
      login(user)
    end

    it 'ユーザーのgame_nameがセットされていない時にユーザーページにリダイレクトされる' do
      visit new_post_path
      expect(page).to have_content 'モンスト内のネームを登録してください'
    end

    it 'ユーザーページからgame_nameが変更できる' do
      visit edit_user_path(user)
      fill_in 'user[game_name]', with: 't-game-name'
      click_button '更新する'
      expect(find('#current_user_game_name')).to have_content 't-game-name'
    end

    it 'ユーザーページからgame_nameを13文字以上で登録できない' do
      visit edit_user_path(user)
      fill_in 'user[game_name]', with: '0123456789012'
      click_button '更新する'
      expect(page).to have_content '12文字以内で入力してください'
    end
  end
end