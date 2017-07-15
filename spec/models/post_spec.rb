require 'rails_helper'

describe Post do
  it 'saves when user logged in' do
    p = build(:post)
    expect(p.save).to be true
  end

  describe '#user' do
    it 'can not be blank' do
      post = build(:post, user: nil)
      expect(post.save).to be false
    end

  end
end