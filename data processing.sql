
-- Author: Hoda Nabavi
-- Date: December 31, 2022


-- Comparing successful and unsuccessful campaigns regarding goal amount
SELECT  avg(goal) as mean, stddev(goal) as std
FROM  kickstarter.campaign cam
where cam.outcome != 'successful' and goal<=5000000; 
SELECT  avg(goal) as mean, stddev(goal) as std
FROM  kickstarter.campaign cam
where cam.outcome = 'successful';


-- Top 3 country in terms of backers and pledged
SELECT cam.id, cam.pledged , cam.backers  , cam.goal, outcome, cou.name
FROM  kickstarter.campaign cam   
join kickstarter.country cou
	 on cou.id = cam.country_id and outcome = 'successful' 
     and cam.pledged <= 50000
     -- order by backers desc
     order by pledged desc;
     
-- cleaning data ( removing outlier data and unsuccessful campaigns and unre categories)
-- calculating campaign time in hours
SELECT cam.id, cam.pledged , cam.backers  , cam.goal, outcome,
hour(floor(timediff( deadline , launched)) )as time
FROM  kickstarter.campaign cam
join kickstarter.sub_category sub
	 on sub.id = cam.sub_category_id 
     and outcome = 'successful' 
     -- and cam.pledged <= 50000
    -- and sub_category_id = 14 
     and currency_id = 2
join kickstarter.category cat
	on cat.id = sub.category_id    
join kickstarter.country cou
	 on cou.id = cam.country_id;