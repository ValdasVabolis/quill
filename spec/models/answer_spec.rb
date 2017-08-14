# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#  question_id :integer
#

require 'rails_helper'

describe Answer do
  it "saves when valid" do
    c = build(:answer)
    expect(c.save).to be true
  end



  describe '#user' do
    it 'is required' do
      c = build(:answer, user: nil)
      expect(c.save).to be false
    end

    it 'must have confirmed account' do
      u = build(:user, confirmed_at: nil)
      c = build(:answer, user: u)
      expect(c.save).to be false
    end
  end



  describe '#question' do
    it 'is required' do
      p = build(:answer, question: nil)
      expect(p.save).to be false
    end
  end



  describe '#body' do
    it 'is required' do
      c = build(:answer, body: nil)
      expect(c.save).to be false
    end
  end



  describe '#soft_delete!' do
    it 'sets the deleted flag to true' do
      c = create(:answer)
      expect { c.soft_delete! }.to change { c.deleted? }.from(false).to(true)
    end
  end
end
