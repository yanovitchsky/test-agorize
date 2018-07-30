class SkillUser < ApplicationRecord
  self.table_name = 'skills_users'
  belongs_to :user
  belongs_to :skill
end