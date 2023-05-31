
CREATE TABLE Admissions(
    item_id INTEGER PRIMARY KEY,
    White INTEGER,
    Black INTEGER,
    Hispanic INTEGER,
    Native INTEGER,
    Asian INTEGER,
    Other INTEGER,
    FOREIGN KEY (item_id) REFERENCES Date_State(ID)
);

INSERT INTO Admissions SELECT 
    ds.ID, d.admissions_white, d.admissions_black, d.admissions_hispanic, d.admissions_amerind, d.admissions_asian, d.admissions_other 
    FROM data AS d
    INNER JOIN Date_State AS ds ON d.state = ds.State AND d.date = ds.Date;