/* 6 List the top & bottom 5 districts based on ‘population to tourist footfall ratio*’ ratio in 2019? 
( ” ratio: Total Visitors / Total Residents Population in the given year)
(Insight: Find the bottom districts and create a plan to accommodate more tourists) */

WITH CTE1 AS
     (
     SELECT d.district AS District, Year, (SUM(2019_visitors)/SUM(p.population))*100 AS Ratio
     FROM df_visitors d LEFT JOIN pop1 p ON d.district = p.district
     WHERE Year = 2019
     GROUP BY District,Year
     HAVING Ratio IS NOT NULL
     ),
CTE2 AS
     (
     SELECT District, Ratio, Year,
     ROW_NUMBER() OVER (PARTITION BY Year ORDER BY Ratio DESC) AS top,
	 ROW_NUMBER() OVER (PARTITION BY Year ORDER BY Ratio ASC) AS bottom
     FROM CTE1
     )
SELECT District,Year,
(CASE when top <= 5 then ' Top ' when bottom <= 5 then ' Bottom ' END) as Type,Ratio 
FROM CTE2
WHERE top <= 5 OR bottom <= 5
ORDER BY Ratio DESC;



