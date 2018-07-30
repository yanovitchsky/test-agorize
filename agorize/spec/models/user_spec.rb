require 'rails_helper'

RSpec.describe User do
  describe '#name' do
    it 'fails presence validation' do
      user = build(:user, name: '')
      user.valid?
      expect(user.errors[:name].size).to eq(1)
    end

    it 'fails uniqueness validation' do
      create(:user)
      user = build(:user)
      user.valid?
      expect(user.errors[:name].size).to eq(1)
    end
  end

  describe 'skill' do
    it 'fails with multiple skills' do
      user = build(:user)
      2.times.collect{ |t| user.skills << create(:skill, name: "skill_#{t}")}
      user.valid?
      expect(user.errors[:skills].size).to eq(1)
    end
    
    it 'adds skill' do
      user = create(:user)
      skill = create(:skill, name: "swimming")

      user.skill = skill.id
      user.save
      expect(user.skill.id).to eq(skill.id)
    end
  end
end