use lesson4;

create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

--b first
select * from letters
order by case when letter = 'b' then 0 else 1 end, letter;

--b last
select * from letters 
order by case when letter = 'b' then 1 else 0 end, letter;

--b 3rd
select letter 
from letters
order by 
    case 
        when letter = 'b' then 2  
        when letter < 'b' then 1  
        else 3                    
    end, letter;