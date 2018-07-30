class Skill < ApplicationRecord

  belongs_to :parent, class_name: "Skill", optional: true
  has_many :children, class_name: "Skill", foreign_key: :parent_id
  has_many :skill_users
  has_many :users, through: :skill_users

  validates :name, presence: true, uniqueness: true

  def self.count_points_for_users
    sql = <<-HERE
    select tmp.name, sum(tmp.points) as points, sum(tmp.user_count) as users_count
    from 
    (select s2.name as name, sum(u.points) as points, count(u.id) as user_count
      from users as u join skills_users as sk on sk.user_id=u.id
      join skills as s on s.id=sk.skill_id
      join (select * from skills) as s2 on s2.id=s.parent_id
      where s.parent_id in (select id from skills)
      group by s.parent_id, s2.name
      union
      select s.name as name, sum(u.points) as points, count(u.id) as user_count
      from users as u join skills_users as sk on sk.user_id=u.id 
      join skills as s on s.id=sk.skill_id
      where parent_id is null group by s.id) as tmp
    group by tmp.name;
HERE
  ActiveRecord::Base.connection.exec_query(sql).to_hash
  end

end
