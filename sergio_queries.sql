# What year had the highest number of incarcerated people?
SELECT Date_State.Date, ROUND (MAX(Total.incarceration), 2) AS Total
FROM Date_State, Total
WHERE Date_State.ID = Total.item_id;


# What was the admission/release ratio for Hispanics in 2020?
SELECT Date_State.Date, SUM(Admissions.Hispanic / Releases.Hispanic) AS Ratio
FROM Admissions
INNER JOIN Releases ON Admissions.item_id = Releases.item_id
INNER JOIN Date_State ON Admissions.item_id = Date_State.ID
WHERE Date_State.Date LIKE '2020%';
