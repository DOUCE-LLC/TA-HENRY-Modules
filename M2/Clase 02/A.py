from math import factorial
import pandas as pd

print('\n1. Lanza una moneda al aire 10 veces, ¿cuantos resultados posibles forman parte del espacio muestral?.\n')

def comb1(x,p):
    return p ** x
print(comb1(10,2))
 
print('\n2. En un aeropuerto se tiene a 10 pasajeros esperando en la sala de preembarque, la polícia debe controlar a 3 de ellos. ¿Cuantas combinaciones posibles se pueden obtener?.\n')

def comb2(a,b):
    return factorial(a) / (factorial(b) * factorial(a-b))
print(comb2(10,3))

print('\n3. La Agencia Nacional de Seguridad Vial realizó una investigación para saber si los conductores de están usando sus cinturones de seguridad. Los datos muestrales fueron los siguientes: Conductores que emplean el cinturón \n')

print('- a) ¿Qué metodo cree que se utilizo para asignar probabilidades?.')
print('- b) Construya un cuadro similar, pero con la asignación de probabilidades.')
print('- c) ¿Cuál sería el mejor método pára estimar la probabilidad de que en Estados Unidos un conductor lleve puesto el cinturón?.')
print('- d) Un año antes, la probabilidad en Argentina de que un conductor llevara puesto el cinturón era 0.75. El director de ANSV, se esperaba que la probabilidad llegara a 0.78. ¿Estará satisfecho con los resultados del estudio? (Utilizar tabla adjunta (![Ejercicio](../_src/assets/ejercicio3.PNG))')
print('- e) ¿Cuál es la probabilidad de que se use el cinturón en las distintas regiones del país? ¿En qué región se usa más el cinturón?(Utilizar misma tabla que el ejercicio anterior).\n')

regions = ['Norte','Noreste','Sur','Centro']
regions_y = [148, 162, 296, 252]
regions_n = [52, 54, 74, 48]

df3 = pd.DataFrame()
df3['regions'] = regions
df3['yes'] = regions_y
df3['no'] = regions_n
df3['tot'] = df3['yes'] + df3['no']
df3['%'] = (df3['yes'] / df3['tot']) * 100

print(df3)

print(f'La probabilidad de que un USA use el cinturon es de {(sum(regions_y) / (sum(regions_y) + sum(regions_n))) * 100}%')

print('\n4. Crear una funcion que permita calcular a probabilidad de los siguientes eventos en un baraja de 52 cartas: Obtener una carta roja. Obtener una carta negra. Obtener una pica. Obtener un trébol. Obtener un corazón. Obtener un diamante. \n')

def comb4(a,b,c):
    print(f'Probabilidad de que sea roja/negra: {round((b / a)*100, 2)}%')
    print(f'Probabilidad de que sea pica/trébol/corazón/diamante: {round((c / a)*100, 2)}%')
comb4(52,26,13)

print('\n5. La probabilidad de que salga un 7 o un 8 al seleccionar una carta de una baraja de las 52 cartas que contiene el mazo. \n')

def comb5(a,b):
    print(f'Probabilidad de que sea un 7 o un 8 {round((b / a)*100, 2)}%')
comb5(52,8)

print('\n6. La probabilidad de tu país gane el mundial de fútbol.\n')

def comb6(a,b):
    print(f'{round((b / a)*100, 2)}%')
comb6(32,1) 

print('\n7. Un experimento que tiene tres resultados es repetido 50 veces y se ve que E1 aparece 20 veces, E2 13 veces y E3 17 veces. Asigne probabilidades a los resultados.\n')

comb6(50,20)
comb6(50,13)
comb6(50,17)

print('\n1. Si la probabilidad de que un cliente pague en efectivo (E) es 6/15, con tarjeta de crédito (TD) es 7/15 y con tarjeta de débito (TD) es 2/15. Hallar la probabilidad de que dos clientes sucesivos que pagan sus cuentas lo hagan: \n')

p_e = 6/15
p_tc = 7/15
p_td = 2/15

print(f'a) el primero en efectivo y el segundo con tarjeta de crédito: {round((p_e*p_tc)*100,2)}% \n')
print(f'b) Los dos clientes en efectivo: {round((p_e*p_e)*100,2)}% \n')

print('\n2. La probabilidad de que un Henry repruebe el M1 de 0.8, de que apruebe M2 es 0.5 y de que repruebe el M3 es de 0.4. (Los eventos no interfieren entre si)')
print('Determinar la probabilidad de que: \n')

print('a) Apruebe un módulo.\n')


print('b) Repruebe las tres materias.\n')