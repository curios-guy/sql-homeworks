import pyodbc # SQL SERVER

con_str = "DRIVER={SQL SERVER};SERVER=WIN-361G0KL8DPA\SQLEXPRESS;DATABASE=lesson2;Trusted_Connection=yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM photos;
    """
)

row = cursor.fetchone()
img_id, name, image_data = row

with open(f'{name}.png', 'wb') as f:
    f.write(image_data)