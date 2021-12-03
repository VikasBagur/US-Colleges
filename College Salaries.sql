--Average starting and mid career median salary and the change in salary for each school type
SELECT ct.school_type, count(*) as No_of_colleges, ROUND(AVG(r.starting_median_salary), 2) as avg_Starting_Salary, ROUND(AVG(r.mid_career_median_salary),2) as avg_midcareer_salary,
(ROUND(AVG(r.mid_career_median_salary),2) - ROUND(AVG(r.starting_median_salary), 2)) * 100 / ROUND(AVG(r.starting_median_salary),2) as change_in_salary
FROM salaries_by_region as r
JOIN salaries_by_college_type as ct
ON r.school_name = ct.school_name
GROUP BY ct.school_type
ORDER BY change_in_salary DESC

--Listing average starting and mid career median salary and the percentage change in the salaries
SELECT region, ROUND(AVG(starting_median_salary), 2) as avg_Starting_Salary, ROUND(AVG(mid_career_median_salary),2) as avg_midcareer_salary,
(ROUND(AVG(mid_career_median_salary),2) - ROUND(AVG(starting_median_salary), 2)) * 100 / ROUND(AVG(starting_median_salary),2) as change_in_salary
FROM salaries_by_region
GROUP BY region
ORDER BY change_in_salary DESC

--Difference between percentage of change in salary from starting median to mid career median and average percentage change in salary
SELECT undergraduate_major, percent_change_from_starting_to_mid_career_salary,
(SELECT AVG(percent_change_from_starting_to_mid_career_salary) FROM degrees_that_payback) as avg_change,
percent_change_from_starting_to_mid_career_salary - (SELECT AVG(percent_change_from_starting_to_mid_career_salary) FROM degrees_that_payback) as diff
FROM degrees_that_payback
ORDER BY diff DESC

--Undergrad major whose starting median salary is higher than the average salary of all the majors
SELECT undergraduate_major, starting_median_salary
FROM degrees_that_payback
WHERE starting_median_salary > (SELECT AVG(starting_median_salary) FROM degrees_that_payback)
ORDER BY starting_median_salary DESC

--Highest starting salary in each region and school type
SELECT r.region, ct.school_type, MAX(r.starting_median_salary) as Max_starting_salary
FROM salaries_by_region as r
JOIN salaries_by_college_type as ct
ON r.school_name = ct.school_name
GROUP BY region, school_type
ORDER BY Max_starting_salary DESC

--Difference between high and low starting median salary from each region and school type
SELECT r.region, ct.school_type, MAX(r.starting_median_salary) as Max_starting_salary, MIN(r.starting_median_salary) as min_starting_salary,
MAX(r.starting_median_salary) - MIN(r.starting_median_salary) as diff
FROM salaries_by_region as r
JOIN salaries_by_college_type as ct
ON r.school_name = ct.school_name
GROUP BY region, school_type
ORDER BY diff DESC

