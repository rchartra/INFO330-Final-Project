-- How has the number of incarcerations changed over the years?
-- join Date_State and Incarceration, sum incarceration, group and sort by date
SELECT strftime('%Y', ds.Date) AS Year, SUM(t.incarceration) AS TotalIncarcerations
FROM Date_State AS ds
JOIN Total AS t ON t.item_id = ds.ID 
GROUP BY Year
ORDER BY Year;

-- Which states have had the most significant decrease in prison admissions?
-- Calculates difference in max and min of states admissions
SELECT
    ds.State,
    (
        MAX(COALESCE(a.admissions, 0))
        -
        MIN(COALESCE(a.admissions, 0))
    ) AS admissions_difference
FROM
    Date_State AS ds
LEFT JOIN
    (
        SELECT
            item_id,
            SUM(White + Black + Hispanic + Native + Asian + Other) AS admissions
        FROM
            Admissions
        GROUP BY
            item_id
    ) AS a ON a.item_id = ds.ID
GROUP BY
    ds.State
ORDER BY
    admissions_difference DESC;
