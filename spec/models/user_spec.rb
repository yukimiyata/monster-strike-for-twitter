require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'game_nameが12文字以内で登録できる' do
      user = User.new(name: 'test-name', password: 'password', password_confirmation: 'password', game_name: 'aaaaaaaaaaaa')
      expect(user).to be_valid
    end

    it 'game_nameが13文字以上で登録できない' do
      user = User.new(name: 'test-name', password: 'password', password_confirmation: 'password', game_name: 'aaaaaaaaaaaaa')
      user.valid?
      expect(user.errors[:game_name]).to include 'は12文字以内で入力してください'
    end
  end
end
