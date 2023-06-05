
CREATE TABLE Releases(
    item_id INTEGER PRIMARY KEY,
    White INTEGER,
    Black INTEGER,
    Hispanic INTEGER,
    Native INTEGER,
    Asian INTEGER,
    Other INTEGER,
    FOREIGN KEY (item_id) REFERENCES Date_State(ID)
);


INSERT INTO Releases SELECT 
    ds.ID, d.releases_white, d.releases_black, d.releases_hispanic, d.releases_amerind, d.releases_asian, d.releases_other 
    FROM data AS d
    INNER JOIN Date_State AS ds ON d.state = ds.State AND d.date = ds.Date;