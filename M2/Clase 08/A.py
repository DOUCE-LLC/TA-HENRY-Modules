import requests
import pandas as pd
import csv
from io import StringIO
import pymysql

request = requests.get('https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ente-de-turismo/oferta-establecimientos-gastronomicos/oferta_gastronomica.csv')

print (
    '1. Bajar el CSV de Oferta Gastronómica desde Buenos Aires Data (https://data.buenosaires.gob.ar/dataset/). Idealmente hacer esto con Python. \n'
)

print(request, '\n')

print (
    '2. Crear una tabla con los siguientes campos: id_local, nombre, categoria, direccion, barrio, comuna, para posteriormente poblarla con los datos bajados, utilzando el conector desde el script de Python. \n'
)

if (request.status_code == 200):
    request_data = request.content.decode('latin-1')
    document = csv.reader(StringIO(request_data))
    print(document, '\n')
else:
    print('Error \n')

df = pd.DataFrame(document)
df = df.rename(columns=df.iloc[0]).drop(df.index[0])
print(df.columns, '\n')

drop_columns = ['long', 'lat', 'cocina', 'ambientacion', 'telefono', 'mail', 'horario', 'calle_nombre', 'calle_altura', 'calle_cruce', 'codigo_postal', 'codigo_postal_argentino']
df = df.drop(drop_columns, axis=1)
print(df.columns)
print(df.head(), '\n')

connection = pymysql.connect(
    host='localhost',
    user='root',
    password='Cmaj7Fmaj7'
)
cursor = connection.cursor()

new_db = 'BsAs_Pubs'
query1 = f"SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '{new_db}'"
cursor.execute(query1)
result = cursor.fetchone()

if result:
    query2 = f"DROP DATABASE {new_db}"
    cursor.execute(query2)
    print(f"La base de datos {new_db} ha sido eliminada.")

query3 = f"CREATE DATABASE {new_db}"
cursor.execute(query3)
query4 = f"USE {new_db}"
cursor.execute(query4)
print(f"La base de datos {new_db} ha sido creada y se ha establecido una conexion exitosamente. \n")

table = 'pubs'
query5 = f"CREATE TABLE {table} (id INT, nombre VARCHAR(50), categoria VARCHAR(20), direccion_completa VARCHAR(50), barrio VARCHAR(20), comuna VARCHAR(15))"
cursor.execute(query5)

for index, row in df.iterrows():
    query6 = f"INSERT INTO {table} (id, nombre, categoria, direccion_completa, barrio, comuna) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (row['id'], row['nombre'], row['categoria'], row['direccion_completa'], row['barrio'], row['comuna'])
    cursor.execute(query6, values)

print (
    '3. A partir de tener los datos disponibles, responder a las siguientes preguntas: \n a) ¿Cuál es el barrio con mayor cantidad de Pubs? \n b) Obtener la cantidad de locales por categoría \n c) Obtener la cantidad de restaurantes por comuna \n'
)

# a) ¿Cuál es el barrio con mayor cantidad de Pubs?
query7 = f'SELECT barrio, count(id) FROM {table} WHERE categoria = "PUB" GROUP BY barrio ORDER BY count(id) DESC LIMIT 1'
cursor.execute(query7)
result = cursor.fetchone()
barrio_con_mas_pubs = result
print("El barrio con la mayor cantidad de Pubs es:", barrio_con_mas_pubs)

# b) Obtener la cantidad de locales por categoría
query8 = f'SELECT categoria, count(id) FROM {table} GROUP BY categoria'
cursor.execute(query8)
result = cursor.fetchall()
cantidad_de_locales = result
print("\nCantidad de locales por categoría:", cantidad_de_locales)

# c) Obtener la cantidad de restaurantes por comuna
query9 = f'SELECT comuna, count(id) FROM {table} WHERE categoria = "RESTAURANTE" GROUP BY comuna'
cursor.execute(query9)
result = cursor.fetchall()
print("\nCantidad de restaurantes por comuna:", result)

connection.commit()
cursor.close()
connection.close()