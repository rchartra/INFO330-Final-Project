DROP TABLE IF EXISTS temp;
DROP TABLE IF EXISTS temp2;
DROP TABLE IF EXISTS temp3;

-- Average ratio of Black admissions to White admissions in 2015

SELECT 
    AVG(CAST(a.White AS REAL)/a.Black) AS White_Black_Ratio_2015 
    FROM Admissions AS a 
    INNER JOIN Date_State AS ds ON a.item_id = ds.ID 
    WHERE substr(ds.Date,1,4) IS '2015' LIMIT 5;

-- Difference in Total Admissions for 2020 vs 2017

CREATE TABLE temp (
    seventeen INTEGER
);

CREATE TABLE temp2 (
    twenty INTEGER
);

--INSERT INTO temp(date) SELECT DISTINCT substr(Date,6,5) FROM Date_State WHERE substr(Date,1,4) IS '2017';
INSERT INTO temp(seventeen) SELECT SUM(t.admissions) FROM Total AS t INNER JOIN Date_State AS ds ON t.item_id = ds.ID WHERE substr(ds.Date,1,4) IS '2017' GROUP BY ds.Date;
INSERT INTO temp2(twenty) SELECT SUM(t.admissions) FROM Total AS t INNER JOIN Date_State AS ds ON t.item_id = ds.ID WHERE substr(ds.Date,1,4) IS '2020' GROUP BY ds.Date;

CREATE TABLE temp3 (
    seventeen REAL,
    twenty REAL
);

INSERT INTO temp3(seventeen) SELECT seventeen FROM temp;
INSERT INTO temp3(twenty) SELECT twenty FROM temp2;

SELECT * FROM temp3;

SELECT CAST(temp.seventeen AS REAL) - CAST(temp2.twenty AS REAL) FROM temp, temp2;

--DROP TABLE temp;



