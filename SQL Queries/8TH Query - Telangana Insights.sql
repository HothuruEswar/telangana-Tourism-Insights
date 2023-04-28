/* 8 Estimate the projected revenue for Hyderabad in 2025 based on average spend per tourist (approximate data)
    |      Tourist          |   Avg_Revenue      |
    |   Foreign Tourist     |    5600            |
    |   Domestic Tourist    |   1200             |
Suggested areas for further secondary research to get more insights: Crime rate, Cleanliness Ratings, Infrastructure Development Ratings etc.*/

/* Created a VIEW for 'visitors in 2025 by previous year percentage' from previous answer [View name - 'by_2025' */
select * from by_2025; 

/* Create table how much avg money they spend in 2025 by last year percentage (CAGR)*/
Create Table spend
(
Tourist varchar(100),
avg_revenue int
);
/* insert values to the table */
insert into spend values ('Foreign',5600),('Domestic',1200);

/* Visitors by 2025 - calculated by using Power Bi forcasting Line Chart */
Create table BI
(
Tourist varchar(100),
by_2025_forcast int
);
/* insert values what i got from Power BI */
insert into BI values ('Foreign',710443),('Domestic',514833);

# QUERY
# Calculate Revenue by 2025

WITH CTE1 AS
     (
     SELECT District, CAGR, b.tourist AS Tourist, by_2025_visitors AS 2025_by_CAGR, 
     by_2025_forcast AS 2025_by_Forecast, avg_revenue AS Avg_Spend_by_one
     FROM by_2025 a /* 'BY_2025' IS A VIEW (2025 total visitors compared by previous year avg growth */
     JOIN bi b ON a.visitor_type = b.tourist /* 'BI' table is forecasted value in Power BI using Line chart */
     JOIN spend s ON b.tourist = s.tourist /* 'spend' table is avg spend in 2025 (expected spend per visitors) */
     ),
CTE2 AS
     (
     SELECT district, 2025_by_CAGR, 2025_by_Forecast, Tourist, 
     ROUND((2025_by_cagr+2025_by_forecast)/2,0) AS Visitors_by_2025, avg_spend_by_one
     FROM CTE1
     )
SELECT District, Tourist, Visitors_by_2025, (Visitors_by_2025 * avg_spend_by_one) AS Actual_revenue_in_2025,
CONCAT(((Visitors_by_2025 * avg_spend_by_one)/10000000),' Cr') AS Revenue_in_2025_Cr 
FROM CTE2;





