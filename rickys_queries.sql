--question: Which race had the highest releases in 2017?
SELECT SUM(r.White), SUM (r.Black), SUM(r.Hispanic), SUM(r.Asian), SUM(r.Other)
FROM Date_State as ds, Releases as r
WHERE ds.ID = r.item_id
AND ds.Date >= '2017-01-01' AND ds.Date < '2017-12-30';


--question: Which state had the highest admitted number of black admissions in 2020?
SELECT ds.State, SUM(a.Black)
FROM Date_State AS DS, Admissions as a
WHERE ds.ID = a.item_id
AND ds.Date >= '2020-01-01' AND ds.Date < '2020-12-30'
GROUP BY ds.State;

