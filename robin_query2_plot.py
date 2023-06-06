import sqlite3
import csv
import numpy as np
import matplotlib.pyplot as plt

conn = sqlite3.connect('database.db')
cursor = conn.cursor()

cursor = conn.execute("SELECT DISTINCT substr(Date,6,5) FROM Date_State WHERE substr(Date,1,4) IS '2017';")
dates = []
for row in cursor:
    i = row[0]
    dates.append(i)

cursor = conn.execute("SELECT SUM(t.admissions), ds.Date FROM Total AS t INNER JOIN Date_State AS ds ON t.item_id = ds.ID WHERE substr(ds.Date,1,4) IS '2017' GROUP BY ds.Date;")

seventeen = []
for row in cursor:
    i = row[0]
    seventeen.append(i)

twenty = []
cursor = conn.execute("SELECT SUM(t.admissions), ds.Date FROM Total AS t INNER JOIN Date_State AS ds ON t.item_id = ds.ID WHERE substr(ds.Date,1,4) IS '2020' GROUP BY ds.Date;")
for row in cursor:
    i = row[0]
    twenty.append(i)

plt.plot(dates, np.subtract(seventeen, twenty))
plt.xlabel("Month of Year")
plt.ylabel("2017 - 2020 Total Admissions")
plt.title("Total Admissions Difference between 2017 and 2020")
plt.grid()
plt.axhline(y=0, color='black')
plt.show()
