class User < ApplicationRecord
  
  has_many :skill_users
  has_many :skills, through: :skill_users
  validates :name, presence: true, uniqueness: true
  validates :skills, length: { maximum: 1}

  # Get user skill
  def skill
    skills.first
  end

  # Set user skill
  def skill= skill_id
    found_skill = Skill.find(skill_id)
    skills << found_skill unless found_skill.nil?
  end
end