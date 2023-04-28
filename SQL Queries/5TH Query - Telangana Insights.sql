# 5 show the top & bottom 3 districts with high domestic to foreign tourist ratio ?
/* insight - (government can learn from top district and replicate the same to bottom districts 
which can improve the foreign visitors as foreign visitors will bring more revenue)*/

WITH CTE1 AS
     (
     SELECT d.district AS DD,f.district AS FF, sum(d.visitors)/sum(f.visitors) AS Ratio
     FROM d_visitors d JOIN f_visitors f
     ON d.district = f.district
     GROUP BY d.district,f.district
     ORDER BY ratio DESC
     LIMIT 3
     ),
CTE2 AS
     (
     SELECT d.district AS DD,f.district AS FF, sum(d.visitors)/sum(f.visitors) AS Ratio
     FROM d_visitors d JOIN f_visitors f
     ON d.district = f.district
     WHERE f.visitors > 0
     GROUP BY d.district,f.district
     ORDER BY ratio ASC
     LIMIT 3
     )
SELECT DD AS District,'High' AS Type, Ratio FROM cte1
UNION
SELECT DD AS District,'Low' AS Type, Ratio FROM cte2;








