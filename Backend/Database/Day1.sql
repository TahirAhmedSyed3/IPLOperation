-- Day 1 implementation
--step 1

create database league 

use league

create table teams
(
 team_id smallint identity(1,1) primary key,
 official_name varchar(63) not null,
 short_name varchar(10) not null unique,
 city varchar(63) not null,
 franchise varchar(15) not null,
 home_stadium varchar(63) not null,
 status varchar(20) not null
    constraint chk_team_status check (status in ('ACTIVE','DISCONTINUED','BANNED')),
 created_at datetime2 not null default SYSDATETIME()
)

//2

INSERT INTO teams
(
    official_name,
    short_name,
    city,
    franchise,
    home_stadium,
    status
)
VALUES
('Chennai Super Kings', 'CSK', 'Chennai', 'IPL', 'M. A. Chidambaram Stadium', 'ACTIVE'),

('Mumbai Indians', 'MI', 'Mumbai', 'IPL', 'Wankhede Stadium', 'ACTIVE'),

('Royal Challengers Bangalore', 'RCB', 'Bangalore', 'IPL', 'M. Chinnaswamy Stadium', 'ACTIVE'),

('Kolkata Knight Riders', 'KKR', 'Kolkata', 'IPL', 'Eden Gardens', 'ACTIVE'),

('Sunrisers Hyderabad', 'SRH', 'Hyderabad', 'IPL', 'Rajiv Gandhi International Cricket Stadium', 'ACTIVE');

INSERT INTO teams
(
    official_name,
    short_name,
    city,
    franchise,
    home_stadium,
    status
)
VALUES
('Deccan Chargers', 'DEC', 'Hyderabad', 'IPL', 'Rajiv Gandhi International Stadium', 'DISCONTINUED'),

('Kochi Tuskers Kerala', 'KTK', 'Kochi', 'IPL', 'Jawaharlal Nehru Stadium', 'DISCONTINUED'),

('Pune Warriors India', 'PWI', 'Pune', 'IPL', 'MCA Stadium Pune', 'DISCONTINUED'),

('Gujarat Lions', 'GL', 'Rajkot', 'IPL', 'Saurashtra Cricket Association Stadium', 'DISCONTINUED'),

('Rising Pune Supergiant', 'RPS', 'Pune', 'IPL', 'MCA Stadium Pune', 'DISCONTINUED');

--3
-- as per internationational standards short name should be used with unique constraint,
-- they are used heavily in read operations

--4
select city, count(*) as total_teams_per_city from teams group by city having count(*) > 1