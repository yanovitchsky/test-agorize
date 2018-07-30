select tmp.name, sum(tmp.points) as points
    from 
    (select s2.name as name, sum(u.points) as points
      from users as u join skills_users as sk on sk.user_id=u.id
      join skills as s on s.id=sk.skill_id
      join (select * from skills) as s2 on s2.id=s.parent_id
      where s.parent_id in (select id from skills)
      group by s.parent_id, s2.name
      union
      select s.name as name, sum(u.points) as points
      from users as u join skills_users as sk on sk.user_id=u.id 
      join skills as s on s.id=sk.skill_id
      where parent_id is null group by s.id) as tmp
    group by tmp.name;