require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'ユーザー情報のカスタムバリデーション' do
    it 'game_nameが存在しないユーザーの場合に投稿できない' do
      user = create(:user)
      post = Post.new(quest_name: 'test-quest', invite_url: 'test-url',user_id: user.id)
      expect(post).not_to be_valid
    end

    it 'game_nameが存在するユーザーの場合に投稿できる(兼用：正常なデータで登録できる)' do
      user = create(:user, :fill_game_name)
      post = Post.new(quest_name: 'test-quest', invite_url: 'test-url',user_id: user.id)
      expect(post).to be_valid
    end
  end

  describe 'バリデーション' do
    let(:user) { create(:user, :fill_game_name) }

    it 'quest_nameが30文字以下で登録できる' do
      # a✖️３０
      post = Post.new(quest_name: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', invite_url: 'test-url',user_id: user.id)
      expect(post).to be_valid
    end

    it 'quest_nameが31文字以上で登録できない' do
      # a✖️３１
      post = Post.new(quest_name: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', invite_url: 'test-url',user_id: user.id)
      post.valid?
      expect(post.errors[:quest_name]).to include 'は30文字以内で入力してください'
    end

    it 'invite_urlが50文字以下で登録できる' do
      # a✖️５０
      post = Post.new(quest_name: 'test-name', invite_url: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',user_id: user.id)
      expect(post).to be_valid
    end

    it 'invite_urlが51文字以上で登録できない' do
      # a✖️５１
      post = Post.new(quest_name: 'test-name', invite_url: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',user_id: user.id)
      post.valid?
      expect(post.errors[:invite_url]).to include 'は50文字以内で入力してください'
    end
  end
end
