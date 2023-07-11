import numpy as np
import pandas as pd

# CLASE 2

print('1. Abrir el dataset e imprimir sus primeras instancias.')
print(' ')

csv = pd.read_csv('wine_reviews.csv')
print(csv.head())

print(' ')
print('2. ¿Cuántas columnas (features) tiene?¿Cuáles son sus nombres?¿Y cuántas filas (instancias)? Luego, descartar la columna Unnamed: 0.')
print(' ')

print(f'Tiene {csv.shape[1]} columnas, y {csv.shape[0]} filas')
print(csv.columns.tolist())
csv = csv.drop(labels='Unnamed: 0', axis=1)
print(csv.columns.tolist())

print(' ')
print('3. ¿Cuántos valores faltantes hay en cada columna?')
print(' ')

print(csv.isnull().sum())
print((csv.isnull().sum() / csv.shape[0]) * 100)

print(' ')
print('4. ¿Cuál o cuáles son los vinos con más valores faltantes?')
print(' ')

csv_wines = csv.isnull().sum(axis=1).sort_values(ascending=False)
# print(csv_wines.iloc[10])
print(csv_wines.head())

print(' ')
print('5. Hacerse alguna pregunta acerca del dataset e intentar responderla. Por ejemplo, ¿cuáles son el peor y el mejor vino? Imprimir en pantalla sus características y su descripción. ¿Hay un solo vino que sea el mejor o el peor?')

print(' ')

# quiero un data frame que contenga:
# - solo elementos que tengan todas las columnas
# - ordenarlos por precio de mas caro a mas barato.

best_wines = csv.dropna()
best_wines = best_wines.sort_values(by='price', ascending=False)
print(best_wines)

# soy un kpo JAJAJAJAJJAJAJAJ


