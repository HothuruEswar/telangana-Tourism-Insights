# Created database as Telangana
CREATE DATABASE Telangana;

/* ----------------------------------------------------------------------------------- */

# Create table for d_visitors
CREATE TABLE d_visitors
(
d_id INT,
district VARCHAR(100),
date DATE,
month VARCHAR(100),
visitors int
);

# Create table for f_visitors
CREATE TABLE f_visitors
(
d_id INT,
district VARCHAR(100),
date DATE,
month VARCHAR(100),
visitors int
);
# After this i imported Appended data from my local storage

/* ----------------------------------------------------------------------------------- */

# I merged 4 diff year sheets by using EXCEL - Append Queries and i imported to SQL
/* ----------------------------------------------------------------------------------- */

# Add new column to both the tables and display DOMESTIC / FOREGIN
# Domestic Table
ALTER TABLE d_visitors
ADD COLUMN visitor_type VARCHAR(100);

# Foreign Table
ALTER TABLE f_visitors
ADD COLUMN visitor_type VARCHAR(100);

/* ----------------------------------------------------------------------------------- */

# I wanna join both tables as one table - ( Easy to write a queries )
Create Table df_visitors as
SELECT * FROM d_visitors
UNION
SELECT * FROM f_visitors;

/* ----------------------------------------------------------------------------------- */

# I wanna add these columns (2016,2017,2018,2019) to df_visitors
ALTER TABLE df_visitors
ADD COLUMN 2016_visitors int;

ALTER TABLE df_visitors
ADD COLUMN 2017_visitors int;

ALTER TABLE df_visitors
ADD COLUMN 2018_visitors int;

ALTER TABLE df_visitors
ADD COLUMN 2019_visitors int;

create table d_visitors1 as select * from d_visitors; 
# I'm going to seperate both visitors values by year in different columns from df_visitors
UPDATE df_visitors
SET 2016_visitors = visitors
WHERE year = '2016';

UPDATE df_visitors
SET 2017_visitors = visitors
WHERE year = '2017';

UPDATE df_visitors
SET 2018_visitors = visitors
WHERE year = '2018';

UPDATE df_visitors
SET 2019_visitors = visitors
WHERE year = '2019';

/* ----------------------------------------------------------------------------------- */

# I found some data related to POPULATION of TELANGANA by DISTRICT wise
# I got this data from WEB and OFFICIAL WEBSITES - it is not Exact data but it is Approximate data

# So we have to create table and import the data from local storage
CREATE TABLE pop1
(
district VARCHAR(100),
population INT
);




