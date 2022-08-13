--_________________________________________________________________________________________
--Using Variable AGE
select age, medal, 
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

from dbo.BD_Events as E 
where age in 
(select age from dbo.BD_Events where age not in ('NA'))
 group by age,medal

 --_____________________________________________________________________________________________
 --The demographics of olympics , the agegroup, sex(gender) and countriies that has more 
 --participants


select 
Age_group, 
count(Age) as count_age
into 
dbo.Age_group_count
from dbo.Age_group
where age_group not in ('') 
group by age_group 
order by count_age asc

 Select * from Age_group_count
 --________________________________________________________________________________
 --Descriptive stat of AGE 
 --Age Column 
--Creating a table of athlete with no agae or NO availble age (NA)

Select *
into 
dbo.Age_NA
from 
dbo.BD_Events
where age = 'NA'

select * from dbo.Age_NA

--__________________________________________________________________________________________
--The descriptive Stat of Age
--This calculates the statistics of the age without NA count =260416,
--avg = 25.454 , min = 10 , max =97
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

--____________________________________________________________________________________
--Analyzing the game, sport , event ,coutry and name of both the minimum and 
--maximum age represented
--Age 10 :
--ID = 71691 
--Name = Dimitrios Loundras
--Country = Greece
--Sport = Gymnastics
--Event = Gymnastics Men's Parallel Bars, Teams
--Team = Ethnikos Gymnastikos Syllogos
--Sex  = Male
--Medal = Bronze
--Games = 1896 summer

Select *
from BD_Events as E left join BD_Athlete_info as A on E.ID = A.ID
where age = '10'
--_________________________________________________________________________________

--For Age 97 

--Age 97 
--ID = 128719
--Name = John Quincy Adams Ward
--Country =USA
--Sport = Art Competitions
--Event = Art Competitions Mixed Sculpturing, Statues
--Team = United States
--Sex  = Male
--Medal = NA
--Games 1928 Summer

Select *
from BD_Events as E left join BD_Athlete_info as A on E.ID = A.ID
where age = '97'

--_____________________________________________________________________________________

-- The highest age participants was in 1928 summer
--with an average age of 33.5 and for winter the highest age rerendeted has
--an average of 27.6 in year 1896 winter 1896.
-- in the year 1968 both the winter and summer 1968 has relative the same average age of 24 
--Using the T test the P value is give as 0.01834 this means that the p value < 0.05 
--and this means the both the summer games and the winter games are statistically significant .
Select 
year , 
season ,
AVG (try_cast (Age as numeric (16,0 ))) as AVG
into 
dbo.AVG_year_summer
from dbo.athlete_events
where age in 
(select age from dbo.BD_Events where age not in ('NA') and Season = 'Summer')
group by 
year,
Season
order by year

select * from dbo.AVG_year_summer
--_______________________________________________________________________________


Select 
year , 
season ,
AVG (try_cast (Age as numeric (16,0 ))) as AVG
into 
dbo.AVG_year_winter
from dbo.athlete_events
where age in 
(select age from dbo.BD_Events where age not in ('NA') and Season = 'winter')
group by 
year,
Season
order by year

select * from dbo.AVG_year_winter
--_____________________________________________________________________________________________________

--Calculating the age group, sex and trhe number of medals won 

Select 
  cast (E.medal as nvarchar (10)) as medal,A.sex, 
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
Age_group_Sex_medal2
from 
dbo.Event_table as E left join BD_Athlete_info as A on E.ID = A.ID
where E.Age in 
(select E.Age from dbo.BD_Events where E.Age not in ('NA'))
group by E.ID , E.Games, E.Age, E.Team,E.NOC, E.Event, E.Sport, E.Medal,A.Sex

select *  from Age_group_Sex_medal2

 --______________________________________________________________________________________________

 --Calculating the number of medals and the total , sum of each medals won
 Select
sex,
Age_group_medal,
Count ( Medal) Total_medal,
sum( case when medal ='Gold' then 1 else 0 end ) as Sum_Gold,
sum ( case when medal = 'Silver' then 1 else 0 end ) as Sum_Silver,
Sum(case when medal = 'Bronze' then 1 else 0 end ) as Sum_Bronze,
Sum ( case when medal = 'NA' then 1 else 0  end ) as Sum_NA
 into 
 dbo.Medal_age_group2
from 
dbo.Age_group_Sex_medal2
where Age_group_medal not in ('')
group by 
sex,
Age_group_medal,
medal

Select * from  dbo.Medal_age_group2
--_____________________________________________________________________
Select Age_group_medal,
count (ID)  as Gold_medal
from 
Age_group_Sex_medal2
where medal = 'Gold'

--__________________________________________________________________________
 --The age group between 20 -25 won more medals (gold =5348, Silver = 5.005,
 --Bronze = 5.247 )
 --the second age group that won more medal is group 25 - 30 ( gold = 3817,Silver = 3806 and Bronze = 3865)
select 
Age_group_medal,
count (ID) as Gold_medal
into
dbo.age_group_gold
from Age_group_Sex_medal_Year
where medal = 'Gold'
group by Age_group_medal
order by Gold_medal desc

select 
Age_group_medal,
count (ID) as Silver_medal
into
dbo.age_group_Silver
from Age_group_Sex_medal_Year
where medal = 'silver'
group by Age_group_medal
order by Silver_medal desc

select 
Age_group_medal,
count (ID) as Bronze_medal
into
dbo.age_group_Bronze
from Age_group_Sex_medal_Year
where medal = 'Bronze'
group by Age_group_medal
order by Bronze_medal desc

--___________________________________________________________________________________________________________________
 --Calculating the persentage of the medals.

Select 
* ,
((Sum_Gold +  Sum_Silver + Sum_Bronze + Sum_NA) / Total_medal) * 100 as Percent_medals,
(Sum_Gold / Total_medal) * 100 as Percent_gold ,
(Sum_Silver / Total_Medal) * 100 as Percent_Silver ,
(Sum_Bronze / Total_medal) * 100 as Percent_Bronze
 into 
 dbo.Percent_medal_age_group2
from Medal_age_group2

select * from dbo.Percent_medal_age_group2
--_________________________________________________________________________________________________________________

--count height for males 

select sex, count (height) as count,
avg (cast(Height as decimal(16,0))) as AVG,
min (height) as MIN,
max (height) as MAX,
STDEV( cast ( height as  decimal(16,0))) as Stdev
 
from BD_Athlete_info
where height in 
 (select height from BD_Athlete_info
where height not in ('NA') )
group by Sex


select sex, count (height) as count,
avg (cast(Height as decimal(16,0))) as AVG,
min (height) as MIN,
max (height) as MAX,
STDEV( cast ( height as  decimal(16,0))) as Stdev
from BD_Athlete_info
where height not in  ('NA') and sex = 'M' 
group by Sex

select sex,
Height
into 
dbo.Sex_Height
from BD_Athlete_info
where height  in  
 (select height  from BD_Athlete_info
where height not in ('NA') )

select * from Sex_Height
select  * 
into 
dbo.Sex_Height_M
from
dbo.Sex_Height
where sex = 'M'

select * from  dbo.Sex_Height_M

select  sex,
cast(height as decimal (16,0)) as Height,
count (cast ( height as decimal (16,0))) as count_height
into 
dbo.sex_cast_Height_male
from dbo.Sex_Height_M
group by height,sex
order by count_height desc

select * from dbo.sex_cast_Height_Male
histogram 



-- Count heights for female 

select sex, count (height) as count,
avg (cast(Height as decimal(16,0))) as AVG,
min (height) as MIN,
max (height) as MAX,
STDEV( cast ( height as  decimal(16,0))) as Stdev
into 
dbo.Sex_Height_stat_female
from BD_Athlete_info
where height not in  ('NA') and sex = 'F' 
group by Sex

--Select just the female height 
select  * 
into 
dbo.Sex_Height_F
from
dbo.Sex_Height
where sex = 'F'

select * from  dbo.Sex_Height_F


select  sex,
cast(height as decimal (16,0)) as Height,
count (cast ( height as decimal (16,0))) as count_height
into 
dbo.sex_cast_Height_Female
from dbo.Sex_Height_F
group by height,sex
order by count_height desc

select * from sex_cast_Height_Female
_______________________________________________________________________________________________________________________________________________________________________________________

--Selecting weight by count by weight 
select sex,
weight
into 
dbo.Sex_Weight
from BD_Athlete_info
where weight  in  
 (select weight  from BD_Athlete_info
where weight not in ('NA') )


select  * 
into 
dbo.Sex_Weight_M
from
dbo.Sex_Weight
where sex = 'M'

select  * 
into 
dbo.Sex_Weight_F
from
dbo.Sex_Weight
where sex = 'F'

select * from  Sex_Weight_F

select  sex,
cast(Weight as decimal (16,0)) as Weights,
count (cast ( Weight as decimal (16,0))) as count_Weight
into 
dbo.sex_cast_Weight_Male
from dbo.Sex_Weight_M
group by Weight,sex
order by count_Weight desc

select  sex,
cast(Weight as decimal (16,0)) as Weight,
count (cast ( Weight as decimal (16,0))) as count_Weight
into 
dbo.sex_cast_Weight_Female
from dbo.Sex_Weight_F
group by Weight,sex
order by count_Weight desc

--__________________________________________________________________________________________________________________________________________

--Gender by year  and seperated by season.

select 
 distinct (G.year),
G.season,
A.sex,
count(distinct A.ID) as Number
into 
dbo.Season_year_sex
from BD_Events as E left join BD_Games_info as G on E.Games = G.Games 
left Join  BD_Athlete_info as A on E.ID = A.ID
group by 
G.year,
G.season,
A.sex

select * from dbo.Season_year_sex
--_______________________________________________________________________
select year,season, sex, number
into
dbo.Season_year_sex_male
from dbo.Season_year_sex 
where season = 'summer' and sex = 'M'

select * from dbo.Season_year_sex_male
--______________________________________________________________
--The number of male participants in the olympics has always been greater than than the female
--As in the year 1904 only 6 female participated  in the the olypics compared to 644 Male who participated in that same year
--In the year 1976 the number of female participant greatly increased upto 1260 but cant be compared to he number of 
--male which was 4 times the female participants.


select year,season, sex, number
into
dbo.Season_year_sex_Female
from dbo.Season_year_sex 
where season = 'Summer' and sex = 'F'

Select * from dbo.Season_year_sex_Female

 

--______________________________________________________________________________
--The number of female partipants are relatively low compared to the male participats ,
--the year 2014 recorded the highest number of participants which is 1102 while the male 1643 particpants
--generally the winter has lesser partiipants compared to the summer
select year,season, sex, number
into
dbo.Season_year_sex_Winter
from dbo.Season_year_sex 
where season = 'Winter' 
select * from dbo.Season_year_sex_summer

select year,season, sex, number
into
dbo.Season_year_sex_Male_winter
from dbo.Season_year_sex 
where season = 'Winter' and sex = 'F'

select year,season, sex, number
into
dbo.Season_year_sex_Female_winter
from dbo.Season_year_sex 
where season = 'Winter' and sex = 'M'

select * from dbo.Season_year_sex_Male_winter

--_____________________________________________________________________________________________                      
--Medal by Sex
--The number of medal won by the male is higher than the number of female beacuse there is greater number 
--of male participinats than the female.

select *
into 
dbo.medal_sex
from dbo.athlete_events
--sum of medals in male and female
Select 
sex,
Count ( Medal) Total_medal,
sum( case when medal ='Gold' then 1 else 0 end ) as Sum_Gold,
sum ( case when medal = 'Silver' then 1 else 0 end ) as Sum_Silver,
Sum(case when medal = 'Bronze' then 1 else 0 end ) as Sum_Bronze,
Sum ( case when medal = 'NA' then 1 else 0  end ) as Sum_NA
into 
dbo.Medal_sex_sum
from dbo.medal_sex
where sex in ( 'M', 'F')
group by sex
 
select * from  Medal_sex_sum
select * from dbo.Medal_sex_percent

--Percentage of the individual medals won 

select *,
((Sum_Gold +  Sum_Silver + Sum_Bronze + Sum_NA) / Total_medal) * 100 as Percent_medals,
( Total_medal/sum_gold) * 100 as Percent_gold ,
(  Total_Medal / Sum_Silver) * 100 as Percent_Silver ,
( Total_medal / Sum_Bronze) * 100 as Percent_Bronze
into
dbo.Medal_sex_percent
from dbo.Medal_sex_sum

--_____________________________________________________________________________________________

--Medals by Country
--In USA 9683 participated in the olympics  and 5637  has won the medal , the number of participants has nothing to do with the number of
--medals to be won example France has the number of participants of 6170 and won about 1767 medals while Italy with
--the number of participants of 3787 won 1637 medals.

Select * from dbo.medal_country2 
select * from dbo.N_participant_medals2
order by Number_medal desc 

select * 
from dbo.N_participant_medals2
order by Number_medal desc 

--_____________________________________________________________________________

--medals by country and season 

select * , count (season) from dbo.Medals_country_Year_season
group by year,  season , country, NUM_medals
order by Num_medals desc

_--___________________________________________________________________________

--Number of countiries  vs the total number of medals won by eaach country 
--USA won the highest medal of 5637 with a participant of 9653
--followed by Russia having total number of participant of 5610 
--and 3947 medals won while countryies like mali, Gambia ,mali and Virgin Islands 
--has never won a medal before.
select * from N_participant_medals2

--____________________________________________________________________________

select season, country, sum(num_medals ) as sum_medal
from Medals_country_Year_season
where country not in ('NULL')
group by season, num_medals, country  
order by sum_medal desc

select  A.year, A.season, A.sport , N.region as Country , count(cast(medal as nvarchar)) as Num_medal
from athlete_events as A left join BD_Noc as N on  A.NOC = N.Noc 
where medal not in ('NA')
group by A.year, A.season, A.sport , N.region,medal
--__________________________________________________________________________________________________
--In USA (Athletics), Russia(gymnastics) , and germany(rowing) are the leading sport in each 
--each country that has the highest number of medals in each sport.
--And the 3 sports are among the top 10 sports with the highest medal.
Select * 
into 
dbo.
from  Sport_country_medals
where country = 'USA'
order by N_medals desc

select * from sport_USA

Select * 
into
dbo.Sport_Russia
from  Sport_country_medals
where country = 'Russia'
order by N_medals desc

select * from dbo.Sport_Russia

Select * 
into
dbo.Sport_Germany
from  Sport_country_medals
where country = 'Germany'
order by N_medals desc

select * from Sport_Germany
select * from dbo.Sport_Russia
select * from sport_USA

--_________________________________________________________________________________________________________________

--The effect of host country to the number of medals won.

select G.Season,G.games,G.Year, M.region 
from Games_num_info as G left join Medals_athlete_noc as M on G.ID = M.ID
where  games = '2004 Summer' and region != 'NULL' and region = 'USA'


select * from Medals_athlete_noc
select * from noc_regions
select * from medals_country
select * from Medals_country_Year_season
where country = 'USA'
order by Num_medals desc


--____________________________________________________________________________________________________
--the USA has hosted the olympics for  8 times since the inception of the olympics 
--and invariably they also have the highest number of medal won in the olymics , this might be duew to the fact
--called the host effect, where favourable crowd cgeers, vegatation , ambiance , weather and even familoiarity with the field 

create table Host_countries
(Host_year int  ,
Season nvarchar (30),
Host_country nvarchar (30))


 select * from Host_countries


insert into Host_countries  ( Host_year , Season , Host_country)
values ( '1896','Summer','Greece'),
       ('1900' , 'Summer','France'),
	   ('1904' ,'Summer', ' USA' ),
	   ('1906' , 'Summer','Greece'),
	   ('1908' , 'Summer','UK' ),
	   ( '1912' , 'Summer', 'Sweden' ),
	   ( '1920' ,  'Summer','Belgium' ),
	   ('1924' ,'Summer', 'France' ),
	   ('1928' ,'Summer','Netherlands' ),
	   ('1932' , 'Summer','USA'),
	   ('1936' , 'Summer', 'Germany'),
	   ('1948' , 'Summer','UK' ),
	   ('1952' , 'Summer', 'Finland' ),
	   ('1956' , 'Summer','Australia'  ),
	   ('1960' , 'Summer', 'Italy'),
	   ('1964',  'Summer','Japan'),
	   ('1968' , 'Summer',  'Mexico' ),
	   ('1972', 'Summer','Germany' ),
	   ('1976' ,  'Summer', 'Canada' ),
	   ('1980' , 'Summer', 'Russia' ),
	   ('1984', 'Summer', 'USA'),
	   ('1988' , 'Summer', 'South Korea '),
	   ('1992' , 'Summer', 'Spain') ,
	   ('1996' ,'Summer', 'USA'),
	   ('2000' ,  'Summer', 'Australia' ),
	   ('2004' , 'Summer', 'Greece' ),
	   ('2008' , 'Summer', 'China' ),
	   ('2012' , 'Summer', 'UK' ),
	   ( '2016' , 'Summer', 'Brazil' ),
	   ('2020' , 'Summer','Japan'),
	   ('2024', 'Summer', 'France' ),
	   ('2028' , 'Summer', 'USA' ), 
	   ('1924','Winter',  'France' ),
	   ('1928' , 'Winter', 'Switzerland' ),
	   ('1932' ,  'Winter','USA'),
	   ('1936', 'Winter','Germany'),
	   ('1948' , 'Winter', 'Switzerland' ),
	   ('1952', 'Winter', 'Norway'),
	   ('1956', 'Winter', 'Italy'),
	   ('1960', 'Winter','USA'),
	   ('1964' , 'Winter','Austria' ),
	   ('1968' , 'Winter','France'),
	   ('1972' , 'Winter','Japan' ),
	   ('1976' , 'Winter', 'Austria'),
	   ('1980' , 'Winter','USA'),
	   ('1984' , 'Winter','Serbia' ),
	   ('1988' , 'Winter','Canada' ),
	   ('1992', 'Winter','France'),
	   ('1994', 'Winter', 'Norway' ),
	   ('1998', 'Winter', 'Japan' ),
	   ('2002' , 'Winter', 'USA' ),
	   ('2006' , 'Winter', 'Italy'),
	   ('2010' , 'Winter', 'Canada'),
	   ('2014' , 'Winter','Russia'),
	   ('2018' , 'Winter', 'South Korea'),
	   ('2022', 'Winter','China')


select host_country  , Count (host_country) as Num_of_times
into 
dbo.Host_num_times
 from host_countries
group by  Host_country
order by Num_of_times desc

 select * from Host_num_times


--__________________________________________________________________________________________________________-
--medals won by each country over the years, in the years where USA has the highest number of medal has been 
--in the years they hosted the olympics .
--As seen in the graph there has been an host effect in the the USA summer (Milestone 4)
select * 
into 
dbo.Host_medal_USA
from Medals_country_Year_season
where country = 'USA' and season = 'summer' 
order by Num_medals desc
select * from Medals_country_Year_season

select * from Host_medal_USA
--______________________________________________________________________________________

--As seen before there seems to be a host effect in the USA. The country organized 4 Winter Olympics (1932, 1960, 1980 and 2002).
--In these years there has been an increase in the number of medals won by the country.
select * 
into 
dbo.Host_medal_USA2
from Medals_country_Year_season
where country = 'USA' and season = 'Winter' 
order by Num_medals desc


 select * from host_countries 
 where season = 'Winter' and Host_country = 'USA'
select * from Host_medal_USA2

--____________________________________________________________________________________________________


Select A.year, N.region as Country, Count(A.ID) as NUm_medals 
from athlete_events as A left join  BD_Noc  N on A.NOC = N.NOC 
where medal not in ('NA') and  N.region in ('USA',
'France',
'Japan',
'Germany',
'Canada',
'Greece',
'UK',
'Italy',
'Norway',
'Switzerland',
'Australia',
'Austria',
'Russia',
'Finland',
'Netherlands',
'Belgium',
'China',
'Mexico',
'Sweden',
'Spain',
'South Korea',
'Brazil',
'Serbia') and  A.Season = 'Summer'
group by A.year, N.region
order by A.Year


--____________________________________________________________________________________________________



select * from Medals_country_Year_season
where country = 'usa'
select *  from medal_country3
--___________________________________________________________________________
--select the hosted countries year before and after 

create table  Host_effect
(year int  ,
country nvarchar (30),
Period_done nvarchar (30))
drop table Host_effect

insert into Host_effect ( Year , Country , period_done )
values
('1892', 'Greece' ,'Before'),
('1896' , 'France','Before'),
 ('1900' , 'USA' ,'Before'),
('1902' , 'Greece' , 'Before' ),
('1904' ,'UK' ,'Before'),
('1908' , 'Sweden' ,'Before'),
('1916', 'Belgium', 'Before'),
('1920' ,'France' , 'Before'),
('1924' ,'Netherlands','Before'),
('1928' ,'USA' , 'Before'),
('1932', 'Germany' , 'Before'),
('1944' ,'UK' ,'Before'),
('1948' ,'Finland' , 'Before'),
('1952' , 'Australia', 'Before'),
('1956' ,'Italy', 'Before'),
('1960' , 'Japan', 'Before'),
('1964' , 'Mexico', 'Before'),
('1968' , 'Germany' ,'Before'),
('1972 ' ,'Canada' , 'Before'),
('1976', 'Russia' ,'Before'),
('1980 ' ,'USA', 'Before'),
('1984', 'South Korea' ,'Before'),
('1988' , 'Spain', 'Before'),
('1992' , 'USA' , 'Before'),
('1996', 'Australia' ,'Before'),
('2000' , 'Greece' ,'Before'),
('2004' ,'China' ,'Before'),
('2008' ,'UK' ,'Before'),
('2012' ,'Brazil' , 'Before' ),
('2016 ' ,'Japan', 'Before' ),
('2020', 'France', 'Before' ),
('2024' ,'USA' ,'Before' ),
('1896','Greece', 'Hosted' ),
('1900' , 'France' , 'Hosted' ),
('1904', 'USA' , 'Hosted' ),
('1906' , 'Greece' , 'Hosted' ),
('1908' , 'UK', 'Hosted'),
('1912' ,'Sweden' ,'Hosted' ),
('1920','Belgium', 'Hosted' ),
('1924', 'France', 'Hosted'),
('1928 ' ,'Netherlands', 'Hosted' ),
('1932' ,'USA', 'Hosted' ),
('1936' ,'Germany' ,'Hosted'),
('1948' , 'UK'  ,'Hosted'),
('1952' ,'Finland', 'Hosted'),
('1956' ,'Australia' , 'Hosted' ),
('1960' , 'Italy' ,'Hosted'),
('1964' , 'Japan' , 'Hosted'),
('1968' ,'Mexico' , 'Hosted'),
('1972', 'Germany', 'Hosted'),
('1976' ,'Canada', 'Hosted'),
('1980 ' , 'Russia', 'Hosted'),
('1984' , 'USA' , 'Hosted'),
('1988', 'South Korea', 'Hosted'),
('1992' , 'Spain' , 'Hosted'),
('1996', 'USA' , 'Hosted'),
('2000'  ,'Australia' , 'Hosted'),
('2004', 'Greece' , 'Hosted'),
('2008' ,'China' ,'Hosted'),
('2012' ,'UK'  ,'Hosted'),
('2016' ,'Brazil'  ,'Hosted'),
('2020 ' ,'Japan' ,'Hosted'),
('2024' ,'France', 'Hosted'),
('2028' ,'USA' ,'Hosted'),
('1900', 'Greece' ,'After'),
('1904' , 'France' ,'After'),
('1908' , 'USA' ,'After'),
('1910' , 'Greece' ,'After'),
('1912' , 'UK' ,'After'),
('1916' ,'Sweden' ,'After'),
('1924' ,'Belgium' ,'After'),
('1928'  , 'France', 'After'),
('1932', 'Netherlands' , 'After'),
('1936' ,'USA' , 'After' ),
('1940' , 'Germany' , 'After'),
('1952' , 'UK' ,'After'),
('1956' , 'Finland' , 'After'),
('1960'  ,'Australia','After'),
('1964' , 'Italy' , 'After'),
('1968' ,'Japan' ,'After'),
('1972 ' , 'Mexico' ,'After'),
('1976 ' ,'Germany' ,'After'),
('1980' ,'Canada' ,'After'),
('1984' ,'Russia' ,'After'),
('1988' , 'USA' ,'After'),
('1992 ' , 'South Korea'  ,'After'),
('1996'  , 'Spain' , 'After'),
('2000'  , 'USA' ,'After'),
('2004' , 'Australia' , 'After'),
('2008' , 'Greece' ,'After'),
('2012'  , 'China' ,'After'),
('2016' , 'UK' , 'After'),
('2020' ,'Brazil' ,'After'),
('2024' ,'Japan' ,'After' ),
('2028' , 'France' , 'After'),
('2032' , 'USA'  , 'After')

select * from host_effect


--____________________________________________________
--Selecting just the hosted year
select * 
into 
dbo_host_hosted 
from host_effect
where period_done = 'Hosted' 

select * from dbo_host_hosted


---Joining the hosted countries and the number of medal they have won.
select   m.year,  H.country,  max(M.NUM_medals)  as NUM_medals
into
dbo.medal_year_country_hosted
from dbo_host_hosted as H left join 
medals_hosted_summer as M on  H.year =  M. year
group by m.year,  H.country
order by m.year 

select * from medal_year_country_hosted


select   m.year,  H.country,  max (M.NUM_medals)  as NUM_medals
from dbo_host_hosted as H inner join 
medals_hosted_summer as M on  H.year =  M. year
group by m.year,  H.country 
order by m.year 


---_______________________________________________________________________________________

--Selecting just the Before_hosted year
select * 
into 
dbo.host_Before
from host_effect
where period_done = 'Before'

select * from dbo.host_Before

select * from medals_hosted_summer
where year = '1892'

select   H.year,  H.country,   (M.NUM_medals)  as NUM_medals
from   Medals_year_country_before2  as M inner join 
dbo.host_Before as H on  H.year =  M. year
group by H.year,  H.country , M.NUM_medals
order by H.year 



select num_medals from Medals_year_country_before
where country = 'USA' and year = '1900'

select * 
into 
dbo.medals_year_before2
from Medals_country_Year_season
where year in (
'1892',
'1896 ',
'1900',
'1902 ',
'1904 ',
'1908 ',
'1916 ',
'1920',
'1924',
'1928',
'1932 ',
'1944',
'1948',
'1952',
'1956',
'1960 ',
'1964',
'1968',
'1972',
'1976',
'1980',
'1984',
'1988',
'1992',
'1996',
'2000',
'2004',
'2008',
'2012 ',
'2016 ',
'2020 ',
'2024')


select * 
into 
dbo.Medals_year_country_before2
from medals_year_before2
where country in ('USA',
'France',
'Japan',
'Germany',
'Canada',
'Greece',
'UK',
'Italy',
'Norway',
'Switzerland',
'Australia',
'Austria',
'Russia',
'Finland',
'Netherlands',
'Belgium',
'China',
'Mexico',
'Sweden',
'Spain',
'South Korea',
'Brazil',
'Serbia') and season = 'Summer'
select * from Medals_year_country_before2

select * from Medals_country_Year_season
select * from dbo.host_Before

select * from Medals_year_country_before2
select * 
into 
dbo.medals_year_before2
from Medals_country_Year_season
--________________________________________________________________________________
--Year before they hosted 

select year , country, NUM_medals from Medals_year_country_before2
where year in (
'1892',
'1896 ',
'1900',
'1902 ',
'1904 ',
'1908 ',
'1916 ',
'1920',
'1924',
'1928',
'1932 ',
'1944',
'1948',
'1952',
'1956',
'1960 ',
'1964',
'1968',
'1972',
'1976',
'1980',
'1984',
'1988',
'1992',
'1996',
'2000',
'2004',
'2008',
'2012 ',
'2016 ',
'2020 ',
'2024')
and 
country in ('USA',
'France',
'Japan',
'Germany',
'Canada',
'Greece',
'UK',
'Italy',
'Norway',
'Switzerland',
'Australia',
'Austria',
'Russia',
'Finland',
'Netherlands',
'Belgium',
'China',
'Mexico',
'Sweden',
'Spain',
'South Korea',
'Brazil',
'Serbia')


---_____________________________________________________________________________
--The year after the hosted 
select * 
into 
dbo.host_after
from host_effect
where period_done = 'after'

select * from dbo.host_after


select * from Medals_country_Year_season
where country = 'Greece' and year = '1956'

select year , country, NUM_medals from  Medals_country_Year_season
where year in (
'1900',
'1904',
'1908',
'1910',
'1912',
'1916',
'1924',
'1928',
'1932',
'1936',
'1940',
'1952',
'1956',
'1960',
'1964',
'1968',
'1972',
'1976',
'1980',
'1984',
'1988',
'1992',
'1996',
'2000',
'2004',
'2008',
'2012',
'2016',
'2020',
'2024',
'2028',
'2032')
and 
country in ('Greece',
'France',
'USA',
'Greece',
'UK',
'Sweden',
'Belgium',
'France',
'Netherlands',
'USA',
'Germany',
'UK',
'Finland',
'Australia',
'Italy',
'Japan',
'Mexico',
'Germany',
'Canada',
'Russia',
'USA',
'South Korea',
'Spain',
'USA',
'Australia',
'Greece',
'China',
'UK',
'Brazil',
'Japan',
'France',
'USA') and season = 'Summer'





--______________________________________________________________________________________________

select   m.year,  H.country,  max(M.NUM_medals) from dbo_host_hosted as H left join 
medals_hosted_summer as M on  H.year =  M. year
where m.year in ('1896', 
'1900', 
'1904',
'1906',
'1908',
'1912',
'1920',
'1924',
'1928',
'1932',
'1936',
'1948',
'1952',
'1956',
'1960',
'1964',
'1968',
'1972',
'1976',
'1980',
'1984 ',
'1988 ',
'1992 ',
'1996 ',
'2000 ',
'2004 ',
'2008',
'2012',
'2016 ',
'2020 ',
'2024 ',
'2028')
group by m.year,  H.country
order by m.year




select * 
into medals_hosted_summer
from Medals_country_Year_season
where country in ('USA',
'France',
'Japan',
'Germany',
'Canada',
'Greece',
'UK',
'Italy',
'Norway',
'Switzerland',
'Australia',
'Austria',
'Russia',
'Finland',
'Netherlands',
'Belgium',
'China',
'Mexico',
'Sweden',
'Spain',
'South Korea',
'Brazil',
'Serbia') and season = 'Summer'

 select * from medals_hosted_summer
where country = 'usa'


