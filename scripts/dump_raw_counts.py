#This is python code to get all the table names in the database 
#and then loop through each table with sql commands to get the row counts of each table
import duckdb
connection = duckdb.connect('main.db')
table_names = connection.sql('SHOW TABLES').fetchall()
for table_name in table_names:
    row_count = connection.execute(f"SELECT COUNT(*) FROM {table_name[0]}").fetchone()[0]
    print('Table name: ' + table_name[0] + '. Number of rows: ' + str(row_count))
connection.close()