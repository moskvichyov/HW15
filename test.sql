Создание и заполнение таблицы имен питомцев
create table animal_name(
            id integer primary key autoincrement,
            name varchar(40)

insert into animal_name (name) select * from
(select distinct rtrim(`name`) from animals
where name is not null)
++++++++++++++++++++++++++++++++++++++++++++

Создание и заполнение таблицы типов питомцев
create table animal_type (
            id integer primary key autoincrement,
            name varchar(40)

insert into animal_type (`type`) select * from
(select distinct rtrim(`animal_type`) from animals
where animal_type is not null)
++++++++++++++++++++++++++++++++++++++++++++

Создание и заполнение таблицы цветов питомцев
create table animal_colors(
    id integer primary key autoincrement,
    name varchar(40)
)

insert into animal_colors(name)
select * from(
select distinct rtrim(`color1`) from animals
where color1 is not null
union
select distinct rtrim(`color2`) from animals
where color2 is not null)
+++++++++++++++++++++++++++++++++++++++++++

Создание и заполнение таблицы соответствия имен и цветов
create table an_name_colors(
    animal_id integer,
    color_id integer,
    primary key (animal_id, color_id)
)

insert into an_name_colors(animal_id, color_id)
select animals.'index', animal_colors.name
from animals
join animal_colors on rtrim(animals.color1=rtrim(animal_colors.name))

insert into an_name_colors(animal_id, color_id)
select animals.'index', animal_colors.name
from animals
join animal_colors on rtrim(animals.color2=rtrim(animal_colors.name))
+++++++++++++++++++++++++++++++++++++++++++++

Создание и заполнение таблицы дат приема и возраста питомца
create table outcomes(
    id integer primary key autoincrement,
    animal_id varchar(50),
    age_upon_outcome varchar(50),
    outcome_subtype varchar(50),
    outcome_type varchar(50),
    outcome_month integer,
    outcome_year integer
)
);



insert into outcomes (animal_id, age_upon_outcome, outcome_subtype, outcome_type, outcome_month, outcome_year)
select distinct animal_id, age_upon_outcome, outcome_subtype, outcome_type, outcome_month, outcome_year
from animals;


+++++++++++++++++++++++++++++++++++++++++++++

Создание и заполнение таблицы породы питомца
create table animal_breed(
    id integer primary key autoincrement,
    name varchar(100)
)

insert into animal_breed(name)
select distinct breed from animals
++++++++++++++++++++++++++++++++++++++++++++
drop table animal_norm

create table animal_norm(
    id integer primary key autoincrement,
    animal_id varchar(20),
    type_id integer,
    name_id integer,
    breed_id integer,
    date_of_birth date

);

insert into animal_norm(animal_id, type_id, name_id, breed_id, date_of_birth )
select distinct animal_id, animal_type.id, animal_name.id, animal_breed.id, date_of_birth
from animals
left join animal_type on animals.animal_type=animal_type.type
left join animal_breed on animals.breed=animal_breed.name
left join animal_name on animals.name=animal_name.name

-- select animal_name.name as "Имя Питомца", animal_breed.name as "Порода", outcomes.age_upon_outcome as "Возраст"
-- from animal_norm
-- left join animal_breed on animal_norm.breed_id=animal_breed.id
-- left join outcomes on animal_norm.animal_id=outcomes.animal_id
-- left join animal_name on animal_norm.name_id=animal_name.id

