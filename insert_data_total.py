import sqlite3
import csv

connection = sqlite3.connect('total_test.db')
cursor = connection.cursor()

cursor.execute('''
    CREATE TABLE IF NOT EXISTS Total (
        item_id INTEGER,
        releases INTEGER,
        admissions INTEGER, 
        incarceration INTEGER, 
        incarceration_nonwhite INTEGER, 
        FOREIGN KEY (item_id) REFERENCES Date_State(id)
    )
''')

#read admissions and releases csv file
with open('admissions_releases_states.csv', 'r') as admissions_file:
    admissions_csv_data = csv.reader(admissions_file)
    #move past header row
    next(admissions_csv_data)

    #read populations csv file
    with open('populations_states.csv', 'r') as populations_file:
        populations_csv_data = csv.reader(populations_file)
        next(populations_csv_data)

        #Iterate over both CSV files
        for admissions_row, populations_row in zip(admissions_csv_data, populations_csv_data):
            date = admissions_row[0]
            admissions = int(admissions_row[1])
            admissions_white = int(admissions_row[2])
            admissions_black = int(admissions_row[3])
            admissions_hispanic = int(admissions_row[4])
            admissions_amerind = int(admissions_row[5])
            admissions_asian = int(admissions_row[6])
            admissions_other = int(admissions_row[7])
            releases = int(admissions_row[8])
            releases_white = int(admissions_row[9])
            releases_black = int(admissions_row[10])
            releases_hispanic = int(admissions_row[11])
            releases_amerind = int(admissions_row[12])
            releases_asian = int(admissions_row[13])
            releases_other = int(admissions_row[14])
            state = admissions_row[15]

            incarcerated_total = int(populations_row[2])
            incarcerated_white = int(populations_row[3])
            incarcerated_black = int(populations_row[4])
            incarcerated_hispanic = int(populations_row[5])
            incarcerated_amerind = int(populations_row[6])
            incarcerated_asian = int(populations_row[7])
            incarcerated_other = int(populations_row[8])

            incarceration_nonwhite = (
                incarcerated_black + incarcerated_hispanic +
                incarcerated_amerind + incarcerated_asian + incarcerated_other
            )

            #Get item_id from Date_State table
            cursor.execute("SELECT ID FROM Date_State WHERE Date=? AND State=?", (date, state))
            result = cursor.fetchone()
            if result:
                item_id = result[0]
            else:
                item_id = None

            #insert values
            cursor.execute('''
                INSERT INTO Total (item_id, releases, admissions, incarceration, incarceration_nonwhite)
                VALUES (?, ?, ?, ?, ?)
            ''', (item_id, releases, admissions, incarcerated_total, incarceration_nonwhite))

#commit changes
connection.commit()
connection.close()


