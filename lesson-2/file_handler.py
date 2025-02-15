import pyodbc #for SQL SERVER

con_str = 'DRIVER={SQL SERVER};SERVER=WIN-361G0KL8DPA\SQLEXPRESS;DATABASE=lesson2;Trusted_Connection=yes;'
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM file_handler
"""
)

print(cursor.fetchone())