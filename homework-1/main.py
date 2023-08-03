"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv
import os

conn = psycopg2.connect(host='localhost',
                        database='north',
                        user='postgres',
                        password='1310')

files = ['customers_data.csv', 'employees_data.csv', 'orders_data.csv']
data = []

for file_name in files:
    with open(os.path.join('north_data', file_name), newline='', encoding='windows-1251') as file:
        reader = csv.reader(file)
        file_data = []
        for row in reader:
            row = tuple(row)
            file_data.append(row)

    data.append(file_data)

table_data = {'customers': data[0],
              'employees': data[1],
              'orders': data[2]}

columns = '%s, '

try:
    with conn:
        with conn.cursor() as cur:
            for k, v in table_data.items():
                columns_counter = len(v[0])
                for row in v[1:]:
                    cur.execute(f"INSERT INTO {k} ({', '.join(v[0])}) VALUES ({(columns * columns_counter)[:-2]})", row)
                print(k, 'converted')
finally:
    conn.close()

