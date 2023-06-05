DROP TABLE IF EXISTS Date_State;
DROP TABLE IF EXISTS temp;
DROP TABLE IF EXISTS data;
DROP TABLE IF EXISTS data2;
DROP TABLE IF EXISTS Admissions;
DROP TABLE IF EXISTS Releases;
DROP TABLE IF EXISTS Incarceration;

--Import CSV

.mode csv
.import INFO330-Final-Project/admissions_releases_states.csv data
.import INFO330-Final-Project/populations_states.csv data2

-- Create Date_State table and add data

CREATE TABLE Date_State (
    ID INTEGER PRIMARY KEY,
    Date VARCHAR(40),
    State Varchar(40)
);

CREATE TABLE temp (
    Date VARCHAR(40),
    State Varchar(40)
);

INSERT INTO temp SELECT DISTINCT data.date, data.state FROM data;
INSERT INTO temp SELECT DISTINCT data2.date, data2.state FROM data2 ;

INSERT INTO Date_State (Date, State) SELECT DISTINCT * FROM temp ORDER BY State, Date;

DROP TABLE temp;

-- Create Admissions table

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

-- Create Releases Table

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

-- Create Incarceration Table

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
    ds.ID, d.incarcerated_white, d.incarcerated_black, d.incarcerated_hispanic, d.incarcerated_amerind, d.incarcerated_asian, d.incarcerated_other 
    FROM data2 AS d
    INNER JOIN Date_State AS ds ON d.state = ds.State AND d.date = ds.Date;

DROP TABLE data;
DROP TABLE data2;