
--Write an SQL query to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.
--From <https://leetcode.com/problems/the-latest-login-in-2020/> 
SELECT  user_id , max(time_stamp) AS Last_stamp
FROM Logins
WHERE time_stamp LIKE '%2020%'
GROUP BY 1;

OR 

SELECT DISTINCT user_id, MAX(time_stamp) last_stamp
FROM Logins
WHERE YEAR(time_stamp) = '2020'
GROUP BY user_id
