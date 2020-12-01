require 'rails_helper'

RSpec.describe RecruitingPosition, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user, :fill_game_name) }
    let(:post) { create(:post, user_id: user.id) }

    it '正常な内容で登録できる' do
      recruiting_position = RecruitingPosition.new(character: 'test-character', description: 'test-description', post_id: post.id)
      expect(recruiting_position).to be_valid
    end

    it 'characterが255文字以内で登録できる' do
      #characterが255文字
      recruiting_position = RecruitingPosition.new(character: '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234', description: 'test-description', post_id: post.id)
      expect(recruiting_position).to be_valid
    end

    it 'characterが256文字以上で登録できない' do
      #characterが256文字
      recruiting_position = RecruitingPosition.new(character: '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345', description: 'test-description', post_id: post.id)
      recruiting_position.valid?
      expect(recruiting_position.errors[:character]).to include 'は255文字以内で入力してください'
    end

    it 'descriptionが255文字以内で登録できる' do
      #descriptionが255文字
      recruiting_position = RecruitingPosition.new(character: 'test-character', description: '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234', post_id: post.id)
      expect(recruiting_position).to be_valid
    end

    it 'descriptionが256文字以上で登録できない' do
      #descriptionが256文字
      recruiting_position = RecruitingPosition.new(character: 'test-character', description: '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345', post_id: post.id)
      recruiting_position.valid?
      expect(recruiting_position.errors[:description]).to include 'は255文字以内で入力してください'
    end
  end
end
