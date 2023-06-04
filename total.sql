CREATE TABLE Total(
    item_id INTEGER PRIMARY KEY,
    releases INTEGER, 
    admissions INTEGER, 
    incarceration INTEGER, 
    incarceration_nonwhite INTEGER, 
    FOREIGN KEY (item_id) REFERENCES Date_State(id)
);


