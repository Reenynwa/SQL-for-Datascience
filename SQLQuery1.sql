select *  from dbo.athlete_events 

--create table duplicates


--AS 
--(select sex  from  dbo.athlete_events)

select sex,
Age
into 
dbo.duplicating
from
dbo.athlete_events
select * from dbo.duplicating


select age ,count (age) as NUm_age, sex  from dbo.duplicating
group by  age,sex
order by  age 

drop table dbo.duplicating
--_________________________________________________________________________________________________________

--Cleaning Data from all duplicates 
SELECT  distinct
ID,
Name, 
Sex,
Age,
Height,
Weight,
Team,
Noc,
Games,
Year,
Season,
City,
Sport,
Event,
Medal
INTO 
dbo.duplicates_athlete_events
FROM 
dbo.athlete_events

select * from dbo.duplicates_athlete_events
 where Team = 'Jamaica' and year = '2008'

--Counting the non duplicated ID present in the table 
SELECT  Count(*) from dbo.duplicates_athlete_events

--___________________________________________________________________________________________________________




--creating a table that has the information about the athlete without the athlete achievements
SELECT Distinct 
ID,
Name,
Sex,
Age,
Height,
Weight,
Team,
year,
Noc
INTO dbo.athlete 
FROM dbo.athlete_events

drop table  dbo.athlete
 
 Select * from dbo.athlete

--To find the individual ID'S and also know how many times they were duplicated in the table 
SELECT ID, Count(ID) as Count_dup  FROM dbo.athlete
where Count_dup >= 2
group by ID


--To find the IDs that are duplicated more than once , we use the above query as a subquery and create
--a table that has a duplicate and number of times they appeared.

SELECT ID , COUNT (ID) as DUP_NUMBER
INTO dbo.duplictes_ID
FROM  dbo.athlete
group by ID


select * from 
dbo.duplictes_ID
where dup_number >=2
--______________________________________________________________________________________________________________________________________________________________________________________________________
--Analyzing the number of times  an athelete was duplicated and what year and  age where they duplicated also in what olumpics did they perform.

SELECT ID,
Name,
Sex,
Age,
Height,
Weight,
Team,
year,
Noc 
INTO 
dbo.Duplicate_infos
from 
dbo.athlete
where ID in (select  ID from 
dbo.duplictes_ID
where dup_number >=2)

drop  table  dbo.Duplicate_infos

Select * from 
dbo.Duplicate_infos
where ID = 42483 
--from the above query i found out there are differnces in the age and the time of the year an athelete  performed 
--example  athelete_ID 42483 first olympics according to this data was in 1996 and age 25 and the second was in 2000 age 29 both in Russia.

--________________________________________________________________________________________________________________________________________________________________________________________________

-- Calculating the birthdate of each athelete , 

select 
ID,
Name,
Sex,
Height,
Weight,
Team,
Age,
year,
Noc
INTO 
dbo.athlete_birth_info
FROM 
dbo.Duplicate_infos
WHERE YEAR  IN ( SELECT DATEADD ("YEAR", -25  , '1996-01-01' ) as birthdate from 
dbo.Duplicate_infos )
--__________________________________________________________________________________________

--calculating the birthdates in each athletes using the year and age 
SELECT id, name, age, year,  DATEADD ("YEAR", -25  , '1996-01-01' ) as birthdate from dbo.Duplicate_infos
where id = 42483 and AGE = 25


SELECT id, name, age, year,  DATEADD ("YEAR", -29  , '2000-01-01' ) as birthdate from dbo.Duplicate_infos
where id = 42483

--________________________________________________________________________________________________
  --but in the query below,it shows there is no consistency in the  birthdate example 
  --using ID = 100046 , when age = 24  and year = 2008 , birthdate = 1984
SELECT id, name, age, year,  DATEADD ("YEAR", -24  , '2008-01-01' ) as birthdate from dbo.Duplicate_infos
where id = 100046 and  age = 24


-- but using the samme ID = 100046 , age = 27 , year = 2012 , birthdate = 1985
SELECT id, name, age, year,  DATEADD ("YEAR", -27  , '2012-01-01' ) as birthdate from dbo.Duplicate_infos
where id = 100046 and  age = 27


--in order to have a solution to the above changes you have to eliminate the variables age from the table 
--because most of them does not give the accurate changes 

ALTER TABLE  
dbo.Duplicate_infos
add DATEADD date    ("YEAR", -29  , '2000-01-01' )  as birthdate 


select id,
year,
age,
dateadd ("YEAR", -23, '1976-01-01' ) as birthdate from dbo.Duplicate_infos
where ID = 42502 


Declare @age int
select id,
year,
age,
dateadd ("YEAR", @age '@year' ) as birthdate from dbo.Duplicate_infos

_________________________________________________________________________________________


--Creating a table that has only distinct Id called Second_athlete in order to use it for more Analysis
SELECT distinct 
ID, 
Name,
Sex,
Height,
Weight,
Team,
Noc
INTO dbo.Second_athlethe
from dbo.athlete_events

Select * from dbo.Second_athlethe

___________________________________________________________________________________________________________
-- Analyzing the number of times  a duplicated ID appeared 


SELECT ID , COUNT (ID) as DUP_NUMBER
INTO dbo.Second_duplicates_ID
FROM  dbo.Second_athlethe
group by ID

 
select * from dbo.Second_duplictes_ID
where DUP_NUMBER >= 2


--___________________________________________________________________________________________________________
SELECT
ID,
Name,
Sex,
Height,
Weight,
Team,
Noc 
INTO 
dbo.Second_Duplicate_infos
from 
dbo.Second_athlethe 
where ID in (select ID from dbo.Second_duplictes_ID
where DUP_NUMBER >= 2)

Select * from dbo.Second_Duplicate_infos
 

 Select * from dbo.Second_Duplicate_infos
 where ID = 813
 --From the above Table created , I figured out there are changes in an athletes team  this mean an athelet may not play on the 
 --same team after playing for a previous team in the last olympics
 --For example using the ID = 813 , the team New York athletic club #24 is differnt from the united states but 
 --they do have the same NOC which is USA
--_______________________________________________________________________________________________________________________________________________________________________________________

--Creating the 3rd Athlete Table and because we have analyzes the column TEAM it wont be added in the new table we are about creating
Select Distinct 
ID,
Name, 
Sex,
Height,
Weight,
year,
NOC
INTO 
dbo.Third_athlete
From dbo.athlete_events

SELECT * FROM dbo.Third_athlete

--_____________________________________________________________________________________________________________

--Identifying the duplicate values 

SELECT ID, Count(ID) as DUP_Number
INTO 
dbo.Third_duplicate_ID
from 
dbo.Third_athlete
group by ID

select * from dbo.Third_duplicate_ID
where DUP_Number > = 2
--________________________________________________________________________________________________

--Analyzing the duplicate info 

SELECT  
ID,
Name,
Sex,
Height,
Weight,
year,
Noc 
INTO 
dbo.Third_Duplicate_infos
FROM 
dbo.Third_athlete
Where ID in (
select ID from dbo.Third_duplicate_ID
where DUP_Number > = 2)


 drop table dbo.Third_Duplicate_infos
SELECT * from dbo.Third_Duplicate_infos
--From the above QUery i figured out that same athlete apparently have differnet  NOC , 
--this means an athlete has the capacity to to represent a different country in each olympic year.
-- Example ID = 87787  represented Nigeria for  2 olympics season in the year = 1996 and 2000 byt in the year 
--2004 and 2008 he represnted Portugal

____________________________________________________________________________________________________________________________________
--Analyzing Duplicates 

SELECT Distinct
ID,
Name,
Sex,
Height,
Weight
INTO 
dbo.Fourth_athlete
FROM 
dbo.athlete_events

drop table dbo.Fourth_athlete
SELECT	*  from  dbo.Fourth_athlete

--_________________________________________________________________________
--Identifying the duplicate values

SELECT ID,
Count(ID) as DUP_Number4
INTO
dbo.Fourth_Duplicate_ID
FROM
dbo.Fourth_athlete
Group by ID


Select * from dbo.Fourth_Duplicate_ID
where DUP_Number4 >= 2

--___________________________________________________________________________________________________-
--Analyzing duplicate infos

SELECT 
ID,
Name,
Sex,
Height,
Weight,
Sport
INTO
dbo.Fourth_duplicate_info
FROM 
dbo.Fourth_athlete
where ID In (Select ID from dbo.Fourth_Duplicate_ID
where DUP_Number4 >= 2)

Drop table dbo.Fourth_duplicate_info

SELECT * from dbo.Fourth_duplicate_info
--For the above  Query you will figure out that some athlete get to perform differnct sport in differnt seasons of the olympics 
--this means that some athlete does not play the same sport they did in pervious olympic years eg 
--athlete 14607 sport was Rowing  and in the next olympis season it changed to Water polo.
--same Id can play different sport eg 1407 changed from Rowing   to Water polo
--___________________________________________________________________________________________________________________________________________________________________________


--Create a table  that has information about the Games

Select  distinct
ID,
Games,
Year,
Season,
City 
INTO 
dbo.Games
from 
dbo.athlete_events

drop table dbo.Games
select * from dbo.Games
--Finding the number of times a game was played more than once 

Select games ,
Count (games) as Num_games
into dbo.Dup_games
from dbo.Games
Group by Games

drop table dbo.Dup_games

Select *  from dbo.Dup_games
where Num_games>= 2



select
ID,
Games,
Year,
Season
into dbo.Games_num_info
from dbo.Games
where Games in (Select games  from dbo.Dup_games
where Num_games>= 2)

drop table dbo.Games_num_info

Select * from dbo.Games_num_info
--From the above query i figured out that Games is a concatenation betwee year and season

select Games,
year,
Season,
City
into dbo.Games_dup_num_info
from dbo.Games
where Games in (select games from dbo.Games_num_info)

drop table dbo.Games_dup_num_info
select * from 
 dbo.Games_dup_num_info


 Select * 
 into 
 dbo.BD_Games_info
 from dbo.Games

 select * from dbo.BD_Games_info
--___________________________________________________________________________________________________________________________-

--Creating an events_table 

SELECT  distinct 
ID,
Games,
Age,
Team,
NOC,
Event,
Sport,
Medal
INTO 
dbo.Event_table 
from dbo.athlete_events

select *
into dbo.BD_Events
from dbo.Event_table

drop table dbo.Event_table 
drop table dbo.BD_Events
select * from dbo.BD_Events
--______________________________________________________________________________________________________________________________________________________________________

select * from dbo.noc_regions

Select Noc, count(NOC) 
as Noc_numb
into dbo.Noc_count
from dbo.noc_regions
Group by Noc


select Noc , noc_numb from dbo.Noc_count

select * into dbo.BD_Noc
from dbo.noc_regions

Select * from dbo.BD_Noc  
--You dont have to start listing all the tables yet but just put all tghe clumns in one table and Useit for joins

--________________________________________________________________________________________________________________________________

--Exploring the data 

--1) Athelete by Region, using the Event table and Noc_regions Table
-- this means the region has only 3 atheletes that has participated in the olympic 
--and the USA participated about 9653 times in the olympics 

Select  count (distinct ID) as athlete_ID , region 
from dbo.BD_Events as E left join dbo.BD_Noc as N 
on E.Noc = N.Noc 
group by region 
order by athlete_ID

Select  count (distinct ID) as num_athlete , region,N.NOC 
into dbo.athlete_region
from dbo.BD_Events as E left join dbo.BD_Noc as N 
on E.Noc = N.Noc 
group by region , N.NOC
order by num_athlete desc
drop table dbo.athlete_region
select * from dbo.athlete_region
___________________________________________________________________________________________________________


--in this particular query we are trying to know the number of times a particular country got their silver , Gold 
--and bronxe and the number of times  aparticular country got nothing.
select count(distinct ID) Medals_ID , E.medal, N.region 
from dbo.BD_Events as E left join dbo.BD_Noc as N 
on e.Noc = N.Noc 
group by E.medal, N.region 
order by Medals_ID desc



Select count(distinct ID) Medals_ID , E.medal, N.region 
into dbo.Medals_region
from dbo.BD_Events as E left join dbo.BD_Noc as N 
on e.Noc = N.Noc 
group by E.medal, N.region 
order by Medals_ID desc


select * from dbo.Medals_region
where medal  = 'Gold'
--_________________________________________________________________________________________________________________


--Analyzing the athletes and their medals  and also the athletes with more than one medals .
select
(E.ID),
F.Name,
N.Region,
Count(E.Medal) as Num_Medals
from dbo.BD_Events as E left join dbo.BD_Noc as N 
on E.Noc = N.Noc left join dbo.Fourth_athlete as F 
on E.ID = F.ID
where Medal not in ('NA')
group by E.ID,F.Name,N.Region
order by Num_medals 

Select 
(E.ID),
F.Name,
N.Region,
Count(E.Medal) as Num_Medals
Into dbo.athlete_medals
from dbo.BD_Events as E left join dbo.BD_Noc as N 
on E.Noc = N.Noc left join dbo.Fourth_athlete as F 
on E.ID = F.ID
where Medal not in ('NA')
group by E.ID,F.Name,N.Region
order by Num_medals desc

drop table dbo.athlete_medals

select * from dbo.athlete_medals
where region = 'USA'
--____________________________________________________________________________________________________________
--Analyzing the the number of games observed by each city durng each Olympic year 

Select * from dbo.BD_Events
select * from dbo.BD_Games_info

select E.Games, G.City,
count (E.ID) as Num_games_obs
from dbo.BD_Events as E left join dbo.BD_Games_info as G 
on E.ID = G.ID
group by E.Games, G.city
order by Num_games_obs

Select E.Games, G.City,
count (E.ID) as Num_games_obs
into dbo.Num_games_obs
from dbo.BD_Events as E left join dbo.BD_Games_info as G 
on E.ID = G.ID
group by E.Games, G.city
order by Num_games_obs desc



drop table dbo.Num_games_obs
drop table dbo.Num_games_obs

select * from dbo.Num_games_obs
--______________________________________________________________________________________________________

--Analyzing by Gender , this gives the number of gender that participated in the Olympics 

select Sex ,Count(ID) as Num_athlete
into  dbo.Gender
from dbo.Fourth_athlete
group by sex 

drop table  dbo.Gender

select * from   dbo.Gender
---____________________________________________________________________________________________

--Analysing the sex and number of region

select sex, count (region) Num_region, region
from dbo.duplicates_athlete_events as D left join dbo.noc_regions as N
on D.Noc = N.NOC
where sex = 'F'
group by sex, region
order by Num_region desc

select sex, count (region) Num_region, region
from dbo.duplicates_athlete_events as D left join dbo.noc_regions as N
on D.Noc = N.NOC
where sex = 'M'
group by sex, region
order by Num_region asc

--________________________________________________________________________________________
--analyzing the ages tha are most represnted in the olympics 

select age, count (age ) as NUM_age 
from dbo.duplicates_athlete_events as D left join dbo.noc_regions as N
on D.Noc = N.NOC
group by  age 
order by NUM_age desc

--__________________________________________________________________________________________________________

--analyzing the sport with the heighest Gold and the country tha won the heighest Gold medal in the sport.

select  Sport, count (Sport ) as NUM_sport, region, Medal
from dbo.duplicates_athlete_events as D left join dbo.noc_regions as N
on D.Noc = N.NOC
where sport = 'swimming' and Medal = 'Gold'
group by  Sport, region,Medal
order by NUM_sport  desc



select 
sport, NOC, 
count (medal) as count_medal 
from dbo.duplicates_athlete_events
where medal not in ('NA') 
group by 
sport, Noc
order by Count_medal desc 
 select * from noc_regions
 where noc = 'urs'