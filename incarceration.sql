CREATE TABLE Incarceration(
    item_id INTEGER PRIMARY KEY,
    White INTEGER,
    Black INTEGER,
    Hispanic INTEGER,
    Native INTEGER,
    Asian INTEGER,
    Other INTEGER,
    FOREIGN KEY (item_id) REFERENCES Date_State(ID)
);

INSERT INTO Incarceration SELECT 
    ds.ID, d.incarceration_white, d.incarceration_black, d.incarceration_hispanic, d.incarceration_amerind, d.incarceration_asian, d.incarceration_other 
    FROM data AS d
    INNER JOIN Date_State AS ds ON d.state = ds.State AND d.date = ds.Date;