require 'rails_helper'

RSpec.describe Skill do
  describe '#name' do
    it 'fails presence validation' do
      skill = build(:skill, name: '')
      skill.valid?
      expect(skill.errors[:name].size).to eq(1)
    end

    it 'fails uniqueness validation' do
      create(:skill)
      skill = build(:skill)
      skill.valid?
      expect(skill.errors[:name].size).to eq(1)
    end
  end

  describe '#parent' do
    it 'has parent' do
      parent = create(:skill)
      skill = create(:skill, name: "soccer", parent_id: parent.id)
      expect(skill.parent.id).to eq(parent.id)
    end
  end

  describe '#children' do
    it 'has children' do
      skill = create(:skill)
      children_id = 2.times.collect { |t| create(:skill, name: "skill_#{t}", parent_id: skill.id)}.map(&:id)
      expect(skill.children.map(&:id)).to eq(children_id)
    end
  end
end