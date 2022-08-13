Select *,
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
dbo.Cross_tab_age_table 
from 
dbo.Event_table
where age in 
(select age from  dbo.BD_Events where age not in ('NA') 
order by medal
select age_group, medal
into
Cross_tab_age_table_2
 from Cross_tab_age_table
where medal not in ('NA')

select * from dbo.Cross_tab_age_table_2 
--____________________________________________________________________________________________________________________________________________________________________
-- Analysis for the Scattered chart


Select 
Sum(case  when medal not in ('NA') then 1 else 0 end ) as Number_medal,
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
dbo.Cross_table_age_medal
from 
dbo.Event_table
where age in 
(select age from  dbo.BD_Events where age not in ('NA') )
group by age 
order by Number_medal

Select * from  dbo.Cross_table_age_medal


Select N.region as country ,
count (distinct E.ID) as Number_participant,
Sum(case  when medal not in ('NA') then 1 else 0 end ) as Number_medal
into N_participant_medals2
from BD_Events as E left join BD_Noc as N on E.NOC = N.NOC
where N.region not in ('')
group by N.region 
order by Number_medal


select * from  N_participant_medals2

--_____________________________________________________________________________________________________________________________________________

Select E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal, 
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
dbo.Cross_tab_female_age
from 
dbo.BD_Events as E left join BD_Athlete_info as A on E.ID = A.ID
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA') and A.Sex = 'F')

select *from dbo.Cross_tab_female_age
where age_group = 'Group_20_25'
--___________________________________________________________________________________________________________________________________

Select E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal, A.sex,
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
dbo.Cross_tab_Male_age
from 
dbo.BD_Events as E left join BD_Athlete_info as A on E.ID = A.ID
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA') and A.Sex = 'M')

select * from Cross_tab_Male_age




--_______________________________________________________________________________________________________


Select N.region as Country,
count(distinct E.ID) as N_participants,
case  
       when E.Medal not in ('NA') then '1' 
	   else '0' 
	   end as N_medals 
into
N_participants_medals 
from BD_Events as E  left join dbo.BD_Noc as N on E.NOC = N.Noc 
where N.region not in ('')
group by E.Medal, N.region
order by N_participants desc
 select * from N_participants_medals

Select *,
sum ( cast( N_medals as int)) as Sum_medals 
 into sum_participants_medals
from N_participants_medals
group by Country, N_participants ,N_medals
order by Sum_medals  desc


select * from sum_participants_medals

select sum(N_participants) as Count_participant ,
N_medals,
count(Sum_medals) as Num_sum_medals
from sum_participants_medals
group by N_medals
order by Count_participant
----------------------------------------------------
Select N.region as country ,
count (distinct E.ID) as Number_participant,
Sum(case  when medal not in ('NA') then 1 else 0 end ) as Number_medal
into N_participant_medals2
from BD_Events as E left join BD_Noc as N on E.NOC = N.NOC
where N.region not in ('')
group by N.region 
order by Number_medal

select * from N_participant_medals2

_____________________________________________________________________________________________

Select 
A.year,
A.season,
count(distinct A.ID) as Atheletes_Count, 
Count (distinct A.NOC) as Countries,
Count (distinct A.Event) as Events
into 
 dbo.Over_time
from dbo.athlete_events as A  
group by 
A.year, 
A.Season

Select * from dbo.Over_time


--_____________________________________________________________________________________________________________________
--_________________________________________________________________________________________________________________________

Select * ,
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
dbo.Age_group_2
from 
dbo.Event_table
where age in 
(select age from  dbo.BD_Events where age not in ('NA'))

Select * from dbo.Age_group_2
--_____________________________________________________________________________________________________________________
 --Counting the number of participant in each age group
Select  
Age_group,
Count(age) as count_age
into 
group_age_count
from 
dbo.Age_group_2
group by Age_group
order by Age_group asc 

select * from group_age_count

--_____________________________________________________________________________________________________


Select E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.sex, 
CASE  
          when age between 10 and 15 then 'group_10_15'
		  when age between 15 and 20 then 'group_15_20'
		  when age between 20 and 25 then 'group_20_25'
		  when age between 25 and 30 then 'group_25_30' 
		  when age between 30 and 35 then 'group_30_35'
		  when age between 35 and 40 then 'group_35_40'
		  when age between 40 and 50 then 'group_40_50'
		  when age between 50 and 60 then 'group_50_60'
		  when age between 60 and 70 then 'group_60_65'
		  when age between 70 and 75 then 'group_60_70'
		  when age between 70 and 80 then 'group_70_80'
		  when age between 80 and 90 then 'group_80_90'
		  when age between 90 and 100 then 'group_90_100'
          else 'No_age_group'
end		as Age_group 
into 
dbo.Age_group_Sex
from 
dbo.Event_table as E left join BD_Athlete_info as A on E.ID = A.ID
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA'))
group by E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.Sex


 select * from  dbo.Age_group_Sex
--____________________________________________________________________________________________________
 --seperated age by gender 

Select 
sex,
Age_group,
count (age) as Count_age_sex
into
dbo.group_age_count_sex
from 
dbo.Age_group_Sex
group by sex, Age_group
order by count_age_sex, sex desc


select * from dbo.group_age_count_sex
--___________________________________________________________________________________________________________________



select A.ID, A.Games,A.Age, A.team, A.NOC, A.Event, A.Sport ,A.medal,A.sex, A.Age_group , C.Count_Age_sex
into 
Sex_age_count
from dbo.Age_group_sex as A left join  dbo.group_age_count_sex as C on A.sex = C.sex

select * from Sex_age_count
where age_group = 'group_20_25'

select 
medal,               
sex,
age_group,                    
count(Count_age_sex) as Sum_count_age_sex    
from Sex_age_count
where sex = 'F' and Age_group = 'Group_20_25'
group by medal,          
sex,
age_group
order by age_group desc

--_______________________________________________________________________________________________________________


Select 
sex,
Age_group,
count_age_sex,
sum ( cast( count_age_sex as bigint)) as Sum_sex,
sum ( cast( count_age_sex as bigint)) * 100  / count_age_sex as Percent_sex
into
Percent_group_age_count_sex
from
Sex_age_count
group by Sex, Age_group, Count_age_sex

select * from Percent_group_age_count_sex

--______________________________________________________________________________________________________

select sex,
sum ( cast( count_age_sex as bigint)) * 100 as Percent_sex
into 
dbo.Percent_sex
from Sex_age_count
group by sex

select * from Percent_sex


--_____________________________________________________________________________________________________________________
--Age group by medals

Select 
 E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, cast (E.medal as nvarchar (10)) as medal,A.sex, 
CASE  
          when age between 10 and 15 then 'group_10_15'
		  when age between 15 and 20 then 'group_15_20'
		  when age between 20 and 25 then 'group_20_25'
		  when age between 25 and 30 then 'group_25_30' 
		  when age between 30 and 35 then 'group_30_35'
		  when age between 35 and 40 then 'group_35_40'
		  when age between 40 and 50 then 'group_40_50'
		  when age between 50 and 60 then 'group_50_60'
		  when age between 60 and 70 then 'group_60_65'
		  when age between 70 and 75 then 'group_60_70'
		  when age between 70 and 80 then 'group_70_80'
		  when age between 80 and 90 then 'group_80_90'
		  when age between 90 and 100 then 'group_90_100'
          else 'No_age_group'
end		as Age_group_medal 
into 
Age_group_Sex_medal
from 
dbo.Event_table as E left join BD_Athlete_info as A on E.ID = A.ID
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA'))
group by E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.Sex

select * from dbo.Age_group_Sex_medal


--___________________________________________________________________________________________________
--counting the number of medal won by each age group 
Select 
sex,
Age_group_medal,
Count ( Medal) Total_medal,
sum( case when medal ='Gold' then 1 else 0 end ) as Sum_Gold,
sum ( case when medal = 'Silver' then 1 else 0 end ) as Sum_Silver,
Sum(case when medal = 'Bronze' then 1 else 0 end ) as Sum_Bronze,
Sum ( case when medal = 'NA' then 1 else 0  end ) as Sum_NA
 into 
 dbo.Medal_age_group

from 
dbo.Age_group_Sex_medal
where Age_group_medal not in ('')
group by 
sex,
Age_group_medal,
medal

Select  * from Medal_age_group



select 
Age_group,
sum (medal ) as sum_medal 
from BD_Events
where medal = ('Gold')
--_____________________________________________________________________________________________
--The percentage of each meals that has been won b y each of the age group.
Select 
* ,
((Sum_Gold +  Sum_Silver + Sum_Bronze + Sum_NA) / Total_medal) * 100 as Percent_medals,
(Sum_Gold / Total_medal) * 100 as Percent_gold ,
(Sum_Silver / Total_Medal) * 100 as Percent_Silver ,
(Sum_Bronze / Total_medal) * 100 as Percent_Bronze
 into 
 dbo.Percent_medal_age_group
from Medal_age_group

select * from dbo.Percent_medal_age_group
--___________________________________________________________________________________________

--- Age group by medal and by which year.


Select 
 E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, cast (E.medal as nvarchar (10)) as medal,A.sex, 
 G.Year,G.season,
CASE  
          when age between 10 and 15 then 'group_10_15'
		  when age between 15 and 20 then 'group_15_20'
		  when age between 20 and 25 then 'group_20_25'
		  when age between 25 and 30 then 'group_25_30' 
		  when age between 30 and 35 then 'group_30_35'
		  when age between 35 and 40 then 'group_35_40'
		  when age between 40 and 50 then 'group_40_50'
		  when age between 50 and 60 then 'group_50_60'
		  when age between 60 and 70 then 'group_60_65'
		  when age between 70 and 75 then 'group_60_70'
		  when age between 70 and 80 then 'group_70_80'
		  when age between 80 and 90 then 'group_80_90'
		  when age between 90 and 100 then 'group_90_100'
          else 'No_age_group'
end		as Age_group_medal
into 
Age_group_Sex_medal_Year
from 
dbo.Event_table as E left join BD_Athlete_info as A on E.ID = A.ID
left join BD_Games_info as G on G.Games = E.Games
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA'))
group by E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.Sex, G.Year,G.season

select * from Age_group_Sex_medal_Year
--_______________________________________________________________________________________

--Calculating the age group and medal and the year and season they won the medals
Select 
 sex,
 year,
 Season,
Age_group_medal,
Count ( Medal) Total_medal,
sum( case when medal ='Gold' then 1 else 0 end ) as Sum_Gold,
sum ( case when medal = 'Silver' then 1 else 0 end ) as Sum_Silver,
Sum(case when medal = 'Bronze' then 1 else 0 end ) as Sum_Bronze,
Sum ( case when medal = 'NA' then 1 else 0  end ) as Sum_NA
 into 
 dbo.Medal_age_group_year
from 
dbo.Age_group_Sex_medal_Year
where Age_group_medal not in ('')
group by 
sex,
Age_group_medal,
medal,
Season,
Year

Select * from dbo.Medal_age_group_year
--_________________________________________________________________________________________________
--Percentage of Medals Won by both Feemale and Male athelete and what year and Season 
select *,
(Sum_Gold + Sum_Bronze + Sum_Silver )  / Total_medal * 100 as Percent_Medal_Year
into 
Percent_Medal_age_group_year
From 
Medal_age_group_year

Select * from dbo.Percent_Medal_age_group_year

--_______________________________________________________________________________________________________________________________________________


select 
Sex,
Season,
Year,
(case  percent_medal_year when max(Percent_medal_year) then 'group_age' else '' end ) as group_age,
max(percent_medal_year) as Max_Percent_medal_year
into 
 dbo.Percent_Medal_age_group_year2
from 
dbo.Percent_Medal_age_group_year
where year >= 1998
group by 
sex,
Age_group_medal,
Season,
Year,
Percent_Medal_year

select * from 
 dbo.Percent_Medal_age_group_year2

 --_______________________________________________________________________________________________________
--which country has the most regular in olympics , who has been winning the most medal 
 --Number of medals won by each country 
 select 
 N.region as country,
 E.medal,
 Count (E.ID) as Num_medals 
 into 
 dbo.medal_country2
 From BD_Events as E left join BD_Noc as N on E.NOC = N.NOC
 where  medal not in ('NA')
 group by N.region , E.Medal
 order by Num_medals desc

 select * from dbo.medal_country2
--____________________________________________________________________________________________________________
--The number of medals won by each country  without the the type of medal involved 
 select 
 N.region as country,
 Count (E.ID) as Num_medals 
 into 
 dbo.medal_country3
 From BD_Events as E left join BD_Noc as N on E.NOC = N.NOC
 where  medal not in ('NA')
 group by N.region 
 order by Num_medals desc

 select * from  dbo.medal_country3

 --____________________________________________________________________________________________________________________________
  -- calculating the year, season , and country of how many medals that has been won 

 Select  
 G.Year,
 G.Season,
 N.region as Country,
 Count(distinct E.ID) as NUM_medals
 into 
 dbo.Medals_country_Year_season
 from BD_Events as E left join BD_Noc as N on E.NOC= N.NOC 
 left join  BD_Games_info as G  on E.Games = G.Games
 where Medal not in ('NA')
 group by  
 G.Year,
 G.Season,
 N.region
 order by year desc

 select * from dbo.Medals_country_Year_season
--________________________________________________________________________________________________

Select 
year,
season ,
(case Num_medals when Max(Num_medals) then 'Country' else '' end ) as Country ,
Max(Num_medals) as Total_medals
into 
dbo.Medals_country_year_max
from 
dbo.Medals_country_Year_season
group by year, season, NUM_medals

select * from dbo.Medals_country_year_max
order by  Total_medals  desc
--_________________________________________________________________________________________
--The number of medals won in each season Summer and Winter 

Select 
Country, Season,count(country) as Medals_Season
into 
dbo.Medals_Season
from 
dbo.Medals_country_year_max
group by country, Season 
order by Season

Select * from  dbo.Medals_Season
--__________________________________________________________________________________________________

--Total number of medals won in the olympics 
Select  
country ,
count(country) as Medals_country
from Medals_country_year_max 
group by  Country

--___________________________________________________________________________________________________________________

-- which  sports aND IN WHICH SEASON OLYMPICS IS popular amongst countries 
--Metrics ( number of participants and number of medals )


Select 
 E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.sex, 
 G.Year,G.season,
CASE  
          when age between 10 and 15 then 'group_10_15'
		  when age between 15 and 20 then 'group_15_20'
		  when age between 20 and 25 then 'group_20_25'
		  when age between 25 and 30 then 'group_25_30' 
		  when age between 30 and 35 then 'group_30_35'
		  when age between 35 and 40 then 'group_35_40'
		  when age between 40 and 50 then 'group_40_50'
		  when age between 50 and 60 then 'group_50_60'
		  when age between 60 and 70 then 'group_60_65'
		  when age between 70 and 75 then 'group_60_70'
		  when age between 70 and 80 then 'group_70_80'
		  when age between 80 and 90 then 'group_80_90'
		  when age between 90 and 100 then 'group_90_100'
          else 'No_age_group'
end		as Age_group
into 
Age_group_Sport
from 
dbo.Event_table as E left join BD_Athlete_info as A on E.ID = A.ID
left join BD_Games_info as G on G.Games = E.Games
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA'))
group by E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.Sex, G.Year,G.season

select * from Age_group_Sport
---_________________________________________________________________________________________________________________

-- counting the nubmber of age group that performed in each sports.
select 
sport,
Age_group,
Count(age) as Count_age
into
dbo.Age_group_sport_count
from dbo.Age_group_Sport
where Age_group not in ('')
group by  Sport, Age_group
order by Age_group

select * from dbo.Age_group_sport_count

where sport = 'Gymnastics '
--________________________________________________________________________________________________________

--The maximum number of participnts in each sports
select 
sport,
(case  Count_age  when  max(Count_age) then 'group_age' else '' end ) as Group_age, 
max( Count_age) as Count_participants
into 
dbo.Age_group_sport_count_max
from 
dbo.Age_group_sport_count
group by Sport , Count_age


select * from dbo.Age_group_sport_count_max
--______________________________________________________________________________________________________________

select 
sport,
count(age) as Count_age,
avg (cast ( age as decimal( 16)))as Avg_age,
min(age) as Min_age,
Max(age) as Max_age
into 
dbo.Age_sport_stats
from 
BD_Events 
where age not in ('NA')
group by sport
order by Avg_age 

select * from dbo.Age_sport_stats
order by Max_age desc

--___________________________________________________________________________________________________

--getting each sport, country and the number of medals won                                                                              
Select 
E.sport,
N.region as country ,
Count( distinct E.ID) as N_participants_sport,
sum (case  when E.Medal not in  ('NA') then 1 else 0 end) as N_medals
into 
dbo.Sport_country_medals
from  BD_Events as E left join BD_Noc as N on E.NOC = N.NOC
group by E.Sport, N.region 

select * from  dbo.Sport_country_medals
--______________________________________________________________________________________________________________

Select 
country ,
(case when N_participants_sport = max(N_participants_sport) then 'Sport' else '' end ) as  Participants_sport,
max(N_participants_sport) as Max_Participant
into 
dbo.Countries_sport_Participant
from dbo.Sport_country_medals
where sport not in ('') and country not in ('') 
group by country, N_participants_sport
order by Max_Participant desc

drop table dbo.Countries_sport_Participant
select * from dbo.Countries_sport_Participant
--_______________________________________________________________________________________________________________

--counting the number of medals won by each perticipants and eache country and which sports 
Select country ,
(case when N_medals = max(N_medals) then 'Sport' else  '' end) as Country_sport,
max(N_medals) as Max_medals
into 
dbo. country_sport_medal
from 
dbo.Sport_country_medals
where sport not in ('') and country not in ('')
group by country, N_medals
order by Max_medals desc

select * from dbo.country_sport_medal

--_______________________________________________________________________________________________


