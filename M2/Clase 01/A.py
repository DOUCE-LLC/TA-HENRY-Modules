import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

print('\n1) Calcular: Media, Mediana, Moda, Varianza, Desvío estándar. \n')

henry_height = np.array([[1.85, 1.8, 1.8 , 1.8],
                        [1.73,  1.7, 1.75, 1.76],
                        [1.65, 1.69, 1.67, 1.6],
                        [1.54, 1.57, 1.58, 1.59],
                        [1.4 , 1.42, 1.45, 1.48]])

henry_h_mean = np.mean(henry_height)
henry_h_median = np.median(henry_height)
henry_h_mode = stats.mode(henry_height, axis=None, keepdims=True)[0][0]
# axis=None es para que tome todo el np, y no el ultimo array
henry_h_var = np.var(henry_height)
henry_h_std = np.std(henry_height)

print('Media: ', henry_h_mean)
print('Mediana: ', henry_h_median)
print('Moda: ', henry_h_mode)
print('Varianza: ', henry_h_var)
print('Desvío estándar: ', henry_h_std)

print('\n2. Convierta el arreglo en una lista y realice un Histograma de 5 intervalos. ¿Tiene distribución normal?\n')

list_henry_h = []
for i in henry_height:
    for j in i:
        list_henry_h.append(j)

frecuencias, bordes = np.histogram(list_henry_h, bins=5)
# print("Frecuencias: ", frecuencias)
# print("Bordes de los contenedores: ", bordes)
plt.bar(bordes[:-1], frecuencias, width=np.diff(bordes), align='edge')
# plt.show()

print('\n3. Utilizando pandas describa el dataframe.\n')

df_hh = pd.DataFrame(henry_height)
print(df_hh.describe())

print('\n4. Con los siguientes datos construye un df y un array que permitan describir adecuadamente la muestra.\n')

income_th = [10.5, 6.8, 20.7, 18.2, 8.6, 25.8, 22.2, 5.9, 7.6, 11.8]
years_study = [17, 18, 21, 16, 16, 21, 16, 14, 18, 18]

df4 = pd.DataFrame()
df4['Income in thousands'] = income_th
df4['Years of study'] = years_study

print(df4)

print('\n5. Realice un histograma para de 6 secciones para Ingreso en miles y Años de estudio\n')

df4_income_f, df4_income_e = np.histogram(df4['Income in thousands'], bins=6)
df4_study_f, df4_study_e = np.histogram(df4['Years of study'], bins=6)
# print("Frecuencias: ", frecuencias)
# print("Bordes de los contenedores: ", bordes)
plt.bar(df4_income_e[:-1], df4_income_f, width=np.diff(df4_income_e), align='center')
plt.show()

plt.bar(df4_study_e[:-1], df4_study_f, width=np.diff(df4_study_e), align='edge')
plt.show()

print('\n6. Cálcula la media de Ingreso en miles (df) utilizando pandas.\n')

print(df4['Income in thousands'].mean())

print('\n7. Cálcula la media de Ingreso en miles (array) utilizando numpy.\n')

print(np.mean(income_th))

print('\n8. Agregue los siguientes valores extremos al df [ 50, 35 ], [ 120, 30 ]. ¿En cuanto vario la media?, ¿Qué conclusiones obtiene de este resultado sobre la media?.\n')

print(df4.describe())

df4.loc[11] = [50, 35]
df4.loc[12] = [120, 30]

print(df4.describe())