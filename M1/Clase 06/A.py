import pandas as pd

def hash_function(key):
    return sum(index * ord(character) for index, character in enumerate(repr(key), start=1))

print('1) Cargar el dataset Emisiones_CO2.csv provisto en la clase 2 en un Dataframe de Pandas, quitar los registros que contengan valores faltantes e implementar una nueva columna, que contenga el resultado de una función Hash aplicada sobre el campo "Código de País" y se denomine "Clave_Hash". Consideraciones: Se puede utilizar la función provista. \n')

dfo = pd.read_csv('Emisiones_CO2.csv', sep='|', decimal=',', encoding='latin-1')

df1 = dfo.dropna(subset=["Código de país"], inplace=False)
print(df1)

df1['hash'] = df1['Código de país'].apply(hash_function)
print(df1)

print('2. A partir del Dataframe creado en el punto 1, construir uno nuevo, que contenga solo los valores distintos de la tupla "Clave_Hash", "Código de País" , "Nombre de país" y "Región". Quitando luego del dataframe original los campos "Código de País" , "Nombre de país" y "Región"')

df2 = df1
delete_columns = ['CO2 (kt)', 'CO2 per cápita (toneladas métricas)', 'Año']
df2 = df2.drop(delete_columns, axis=1)
print(df2)