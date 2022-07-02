SELECT	*  from  dbo.Fourth_athlete

select * 
into BD_Athlete_info
from dbo.fourth_athlete


select count(ID) as count from BD_Athlete_info

--135571
--________________________________________________________________________________________________________________________________________________________________________________________________________________________________
--calculating the height and counting the number of athlete that has no information about their height 
--And the total number of ID that does not have information about their height is 33916
Select * from BD_Athlete_info 
Where Height ='NA'

Select * 
into dbo.Height_NA
from BD_Athlete_info
where Height = 'NA'

Select * from  dbo.Height_NA

Select count(ID) as NUm_Height_NA 
from dbo.Height_NA


Select height,4. as height from BD_Athlete_info
where height not in ('NA')

--_____________________________________________________________________________________

--Calculating Height Descriptive stat

select count (height) as count,
avg (cast(Height as decimal(16,0))) as AVG,
min (height) as MIN,
max (height) as MAX
into 
dbo.height_Stats 
from BD_Athlete_info
where height in 
 (select height from BD_Athlete_info
where height not in ('NA') )

Select * from dbo.height_Stats

--_______________________________________________________________________________

--The height by sex Descriptive Stat
select sex, count (height) as count,
avg (cast(Height as decimal(16,0))) as AVG,
min (height) as MIN,
max (height) as MAX
into 
dbo.Stats_height 
from BD_Athlete_info
where height in 
 (select height from BD_Athlete_info
where height not in ('NA') )
group by Sex 

select * from dbo.Stats_height

Select 
sex,
height 
into 
dbo.male_stats
from 
BD_Athlete_info
where sex in 
(select sex from BD_Athlete_info where sex = ('M') and Height not in ('NA'))


select * from male_stats
where height = '180'



Select 
sex,
height 
into 
dbo.Female_stats
from 
BD_Athlete_info
where sex in 
(select sex from BD_Athlete_info where sex = ('F') and Height not in ('NA'))

select * from dbo.Female_stats


--_______________________________________________________________________________

Select  count(*) from BD_Athlete_info 
where  weight = 'NA'

Select * 
into dbo.Weight_NA
from BD_Athlete_info
where weight = 'NA'

select count (* )from dbo.Weight_NA

select Count(*) as NUM_Weight_NA from dbo.Weight_NA
--Number of Athlete that does not have any value for weight = 34885 or NUMber of NA = 34885

select Weight from BD_Athlete_info
where weight not in ('NA')

select Count (*) as NUM_Weight from BD_Athlete_info
--Number of Athlete that has provided information about there weight= 135571

--________________________________________________________________________________________
--Descriptive stats

Select Count (Weight) as COUNT,
avg (cast(weight as decimal (16,0))) as AVG, 
min (Weight) as MIN,
Max (Weight) as MAX
into 
dbo.Weight_Stats
from  BD_Athlete_info
where weight in 
(select weight from BD_Athlete_info 
WHERE Weight not in ('NA'))


select * from dbo.Weight_Stats
--Count = 100686 , avg = 71.963 , min = 100 , max 99

--_______________________________________________________________________________________________

--Weight by sex
Select sex, Count (Weight) as COUNT,
avg (cast(weight as decimal (16,0))) as AVG, 
min (Weight) as MIN,
MAX (weight) as MAX
into 
dbo.Stats_Weight
from 
BD_Athlete_info
where  weight in 
(select  Weight from BD_Athlete_info where weight not in ('NA'))
group by sex 


select * from dbo.Stats_Weight

--____________________________________________________________________________________________

--Athlete by gender 
Select sex, 
count (ID) as NUM_Gender
into 
dbo.Gender
from  BD_Athlete_info
group by Sex


select * from dbo.Gender



--____________________________________________________________________________________________________
--Creating a table that comprises of all the events that happened 
--and analyzing this column by column

Select * from dbo.BD_Events

Select count (*) from dbo.BD_Events

--_________________________________________________________________
--First Column to be analyzed is the Games column 

Select games , Count (Games) as Count 
Into dbo.Count_Games
from dbo.BD_Events
Group by Games 
Order by Count desc

Select * from dbo.Count_Games
--This calculates the number of games played in each olympic year and 
-- year 2000 Summer played the  highest games = 13821.
select count(games)  from dbo.Count_Games
--There are about total of 51 olympic seasons played in the olympics

--_________________________________________________________________________________________________________

--Age Column 
--Creating a table of athlete with no availble age (NA)

Select *
into 
dbo.Age_NA
from 
dbo.BD_Events
where age = 'NA'

select * from dbo.Age_NA

Select count(*) from dbo.Age_NA
--The number of Athlete without an AGE = 9315

--_______________________________________________________________________________
Select 
Count (AGE) as Count,
AVG (cast (AGE as numeric(16,4))) as AVG,
min (AGE) as MIN,
Max (AGE) as max
into 
dbo.Age_stats 
from 
dbo.BD_Events
where age in 
(select age from dbo.BD_Events where age not in ('NA'))

select * from dbo.Age_stats


--This calculates the statistics of the age without NA count =260416, avg = 25.454 , min = 10 , max =97
--__________________________________________________________________________________
-- grouping the age in their respective group age 

select count (age) as count_age, 
CASE  
          when age between 10 and 15 then 'group_10_15'
		  when age between 15 and 20 then 'group_15_20'
		  when age between 20 and 25 then 'group_20_25'
		  when age between 25 and 30 then 'group_25_30' 
		  when age between 30 and 35 then 'group_30_35'
		  when age between 35 and 40 then 'group_35_40'
		  when age between 40 and  50 then 'group_40_50'
		  when age between 50 and 60 then 'group_50_60'
		  when age between 60 and 70 then 'group_60_65'
		  when age between 70 and 75 then 'group_60_70'
		  when age between 70 and 80 then 'group_70_80'
		  when age between 80 and 90 then 'group_80_90'
		  when age between 90 and 1000 then 'group_90_100'
          else 'No_age_group'
end		as Age_group  
into 
dbo.Age_group
from dbo.BD_Events
where age in 
(select age from dbo.BD_Events where age not in ('NA'))
 group by age 
 order by count_age desc


select * from  dbo.Age_group
---_____________________________________________________________________________

select 
Age_group, 
count(Age) as count_age
into 
dbo.Age_group_count
from dbo.Age_group
where age_group not in ('') 
group by age_group 
order by count_age asc

select * from dbo.Age_group_count
--group 20-25 are the most represnted age in the olympics.

--_______________________________________________________________________________________

--Athlete by country column
--To find the number of athlete from each country that has represnted a particular country since the inception of the olympics 
select 
count (distinct ID) as Num_athlete,
N.region
into 
dbo.Athlete_Nocs 
from dbo.BD_Events as E left join dbo.noc_regions as N 
on E.NOC = N.NOC
group by region
order by Num_athlete  desc

select top 10  *    from dbo.Athlete_Nocs 
order by  num_athlete desc

--________________________________________________________________________________________
 --The sports and event table 
 select 
 sport , 
 count(sport) as count_sport 
 into 
 dbo.Sport_count
 from dbo.BD_Events
 where sport in (select distinct sport from dbo.BD_Events)
 group by  sport 
 order by count_sport desc

 select * from dbo.Sport_count
 --The total number of each sports played in the olympics 
 --_____________________________________________________________________
 --Combining the sport and each events 
 --count (sport)
  select 
 Sport, 
 count(event) as count_event 
 into 
 dbo.Sport_Event_count
 from dbo.BD_Events
  where event in (select distinct event from dbo.BD_Events)
 group by  Sport 
 order by count_event desc

 select * from dbo.Sport_Event_count

 select count(distinct sport) from  dbo.BD_Events

 --_____________________________________________________________________________
 --The number of events in  SHOOTING and ATHLETICS sports

 Select 
 sport, 
 count(Event) as count_event 
 into 
 dbo.Event_count2
 from dbo.BD_Events
  where ID  in (select distinct ID from dbo.BD_Events) and 
   sport in ('Shooting' ,'athletics')
 group by  Sport 
 order by count_event desc

 select *   from dbo.Event_count2
 --_______________________________________________________________________________
 --MEDALS
 Select distinct(medal) as Medal ,
 count (medal) as Count_medal
 into 
 dbo.Count_medal
 from dbo.BD_Events
 group by medal 
 order by Count_medal desc

 select * from dbo.Count_medal 

  --_________________________________________________________________________________________
  --Medals by NOC
 Select
 count(ID) as Num_medal,
 medal,
 region 
 into 
 dbo.medals_country
 from dbo.BD_Events as E left join dbo.noc_regions as N 
 on E.NOC = N.NOC
 where medal not in ('NA')
 group by medal , region
 order by Num_medal
 
 select top 10 * from dbo.medals_country 
 order by num_medal desc
--This gives the number of gold , silver and bronze won by each country

--___________________________________________________________________________
--The athete that has won the  heighest  medal 

 Select
 distinct (E.ID), 
 A.Name,
 count (E.medal) as Num_medal,
 N.region 
 into 
 dbo.Medals_athlete
 from dbo.BD_Events as E 
 left join dbo.noc_regions as N 
 on E.NOC = N.NOC 
 left join dbo.BD_Athlete_info as A 
 on E.ID = A.ID
 where medal not in ('NA')
 group by E.ID,A.Name,N.region
 order by Num_medal desc


 select top 10  * from  dbo.Medals_athlete








 --______________________________________________________________________________________________