import pandas as pd
import matplotlib.pyplot as plt

print('1a. Cargar los datos desde el archivo csv. \n')

doc = pd.read_csv('Titanic.csv', delimiter=',', encoding='utf-8')
print(doc.head())

print('1b. Investigar qué forma tienen los datos utilizando las funciones exploratorias que aprendimos. ¿Qué información tenemos en los datos?¿Qué representa cada columna?¿Cuántos pasajeros/as están incluidos/as en este Dataset? \n')

print('Shape: \n', doc.shape)
print('Info: \n', doc.info)
print('Describe: \n', doc.describe())
print('Columns: \n', doc.columns)

print('1c. ¿Faltan datos? ¿Se te ocurre por qué? ¿Qué harías con ellos? \n')

print(doc.isnull().sum())
print('Los datos importantes buscaria una forma de llenarlos, mientras que el resto simplemente los eliminaria')

print('1d. ¿Te parece que todas las columnas son informativas o borrarías alguna? \n')

df1 = doc
drop_columns = ['PassengerId']
df1 = df1.drop(drop_columns, axis=1)
print(df1.columns)

print('1e. Para pensar: ¿te parece que la supervivencia (o no) fue un proceso completamente *al azar* o existe algún mecanismo generador de estos datos?¿Qué nos enseñó la famosa película de David Cameron? \n')

print('Por edad: \n')

df_age = df1.dropna(subset=['Age'], inplace=False)
survived_ratio = df_age.groupby('Age')['Survived'].mean() * 100
print(survived_ratio)
# plt.hist(survived_ratio, bins=20)
# plt.show()

print('\nPor Clase Social: \n')

df_class = df1.dropna(subset=['Pclass'], inplace=False)
survived_ratio2 = df_class.groupby('Pclass')['Survived'].mean() * 100
print(survived_ratio2)

print('\nPor Genero: \n')

df_gender = df1.dropna(subset=['Sex'], inplace=False)
survived_ratio3 = df_gender.groupby('Sex')['Survived'].mean() * 100
print(survived_ratio3)

print('2. ¿Cuántas columnas (features) tiene?¿Cuáles son sus nombres?¿Y cuántas filas (instancias)?. \n')

print('3. ¿Cuántos valores faltantes hay en cada columna? \n')

print('4. ¿Cuál o cuáles son las columnas con más valores faltantes? \n')

print('5. Hacerse alguna pregunta acerca del dataset e intentar responderla. Por ejemplo, ¿cuál es la persona de más edad? \n')