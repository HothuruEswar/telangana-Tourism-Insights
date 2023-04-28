/* 7 What will be the projected number of domestic and foreign tourists in Hyderabad in 2025
based on the growth rate from previous years
Insight Better estimate incoming tourists count so that government can plan the infrastructure better */


WITH Main AS 
(
WITH CTE1 AS
     (
     SELECT district,SUM(2016_visitors) AS X ,SUM(2019_visitors) AS Y,visitor_type,
	 ROUND(((POWER((SUM(2019_visitors) / SUM(2016_visitors)) , (1/3)) - 1)*100),2) AS CAGR
     FROM df_visitors
     GROUP BY district,visitor_type
     HAVING cagr IS NOT NULL
     ORDER BY cagr DESC
     )
     SELECT District, X AS In_2016_Visitors, Y AS By_2019_Visitors,
     CONCAT(CAGR,' %') AS CAGR,visitor_type
     FROM CTE1 
     WHERE district = 'hyderabad' AND visitor_type = 'Domestic'
     UNION
     SELECT District, X AS In_2016_Visitors, Y AS By_2019_Visitors,
     CONCAT(CAGR,' %') AS CAGR,visitor_type
     FROM CTE1 
     WHERE district = 'hyderabad' AND visitor_type = 'Foreign'
)
SELECT District, IN_2016_Visitors, By_2019_Visitors, CAGR, Visitor_Type,
ROUND((by_2019_visitors + (by_2019_visitors * (CAGR * 6))/100),0) AS By_2025_Visitors 
FROM Main WHERE visitor_type = 'Domestic'
UNION
SELECT District, IN_2016_Visitors, By_2019_Visitors, CAGR, Visitor_Type,
ROUND((by_2019_visitors + (by_2019_visitors * (CAGR * 6))/100),0) AS By_2025_Visitors 
FROM Main WHERE visitor_type = 'Foreign';



/*-----------------------------------------------------------------------------------------------------*/
# I created a view from this output for calculating the revenue of hyderabad by 2025
Create View by_2025 as
WITH Main AS
(
WITH CTE1 AS
     (
     SELECT district,SUM(2016_visitors) AS X ,SUM(2019_visitors) AS Y,visitor_type,
	 ROUND(((POWER((SUM(2019_visitors) / SUM(2016_visitors)) , (1/3)) - 1)*100),2) AS CAGR
     FROM df_visitors
     GROUP BY district,visitor_type
     HAVING cagr IS NOT NULL
     ORDER BY cagr DESC
     )
     SELECT District, X AS In_2016_Visitors, Y AS By_2019_Visitors,
     CONCAT(CAGR,' %') AS CAGR,visitor_type
     FROM CTE1 
     WHERE district = 'hyderabad' AND visitor_type = 'Domestic'
     UNION
     SELECT District, X AS In_2016_Visitors, Y AS By_2019_Visitors,
     CONCAT(CAGR,' %') AS CAGR,visitor_type
     FROM CTE1 
     WHERE district = 'hyderabad' AND visitor_type = 'Foreign'
)
SELECT District, IN_2016_Visitors, By_2019_Visitors, CAGR, Visitor_Type,
ROUND((by_2019_visitors + (by_2019_visitors * (CAGR * 6))/100),0) AS By_2025_Visitors 
FROM Main WHERE visitor_type = 'Domestic'
UNION
SELECT District, IN_2016_Visitors, By_2019_Visitors, CAGR, Visitor_Type,
ROUND((by_2019_visitors + (by_2019_visitors * (CAGR * 6))/100),0) AS By_2025_Visitors 
FROM Main WHERE visitor_type = 'Foreign';



