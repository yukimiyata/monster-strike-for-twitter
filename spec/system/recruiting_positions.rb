require 'rails_helper'

RSpec.describe "RecruitingPositions", type: :system do
  describe 'キャラクターとステータスの指定' do
    let(:user) { create(:user, :fill_game_name) }

    before do
      login(user)
    end

    it 'キャラクターとステータスを指定せず募集すると誰でもOKと指定無しと表示される' do
      recruit_page_and_put_template
      uncheck 'quest_form[tweet_post]'
      click_button '募集開始'
      expect(page).to have_content '誰でもOK'
      expect(page).to have_content '指定無し'
    end

    it 'キャラクターとステータスを指定して募集ができる' do
      recruit_page_and_put_template
      fill_in 'character-number-4', with: 'input-test-character'
      fill_in 'description-number-4', with: 'input-test-status'
      uncheck 'quest_form[tweet_post]'
      click_button '募集開始'
      expect(page).to have_content 'input-test-character'
      expect(page).to have_content 'input-test-status'
    end

    it 'キャラクターとステータスのテンプレートボタンが利用できる' do
      recruit_page_and_put_template
      (all('.recruit-info-customize')[1]).click
      (all('.recruit-info-customize')[5]).click
      uncheck 'quest_form[tweet_post]'
      click_button '募集開始'
      expect(page).to have_content '適性'
      expect(page).to have_content '運極'
    end
  end
end