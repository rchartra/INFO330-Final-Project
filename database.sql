DROP TABLE IF EXISTS Date_State;
DROP TABLE IF EXISTS temp;
DROP TABLE IF EXISTS data;
DROP TABLE IF EXISTS data2;
DROP TABLE IF EXISTS Admissions;
DROP TABLE IF EXISTS Releases;

.mode csv
.import INFO330-Final-Project/admissions_releases_states.csv data
.import INFO330-Final-Project/populations_states.csv data2

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
