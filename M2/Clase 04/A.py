from math import e, factorial
from scipy import stats

# preguntas en un lapso de tiempo, usamos poisson.
# recibe 2 argumentos: cantidad segun probabilidad en lapso de tiempo, tiempo
def probabilidad_poisson(lamba_np,x):
    probabilidad = (pow(e,-lamba_np) * pow(lamba_np,x))/factorial(x)
    return probabilidad

def funcion_binomial(k,n,p):
    # k = exitos.
    # n = ensayos
    # p = probabilidad de exito
    num_exitos = factorial(n) 
    num_eventos = factorial (k) * factorial(n-k) 
    exitos_fracaso = pow(p,k) * pow(1-p,(n-k)) 

    binomial = (num_exitos / num_eventos) * exitos_fracaso

    print(binomial, '\n')

def probabilidad_hipergeometrica(N,X,n,x):
  Xx = factorial(X)/(factorial(x)*factorial(X-x))
  NX_nx= factorial(N-X)/(factorial(n-x)*factorial((N-X)-(n-x)))
  Nn = factorial(N)/(factorial(n)*factorial(N-n))
  hipergeometrica = (Xx * NX_nx)/Nn

  return hipergeometrica
# N = tamaño de poblacion
# X = numero de elementos que cumplen la condicion
# n = tamaño de la muestra
# x = n° de elementos q cumplen la condicion en la muestra


# 1. Considera el experimento que consiste en un empleado que arma un producto.
# - a. Defina la variable aleatoria que represente el tiempo en minutos requerido para armar el producto.
# - b. ¿Qué valores toma la variable aleatoria?
# - c. ¿Es una variable aleatoria discreta o continua?

# a. x
# b. La variable puede tomar cualquier numero mayor a 0. Es decir: x > 0 (0; infinito+)
# c. Es una variable continua.


# 2. Considera el experimento que consiste en lanzar una moneda dos veces.
#   - a. Enumere los resultados experimentales.
#   - b. Defina una variable aleatoria que represente el número de caras en los dos lanzamientos.
#   - c. Dé el valor que la variable aleatoria tomará en cada uno de los resultados experimentales.
#   - d. ¿Es una variable aleatoria discreta o continua?

# a. cara = H, cruz = T.
#    (H, H) (H, T) (T, H) (T, T)

# b. número de caras en los dos lanzamientos  =  Y

# c. El valor de Y en cada caso sera:
# (H, H) = 2
# (H, T) = 1
# (T, H) = 1
# (T, T) = 0

# d. Es una variable discreta.

print('3.')
# 3. Considera las decisiones de compra de los próximos tres clientes que lleguen a la tienda de ropa Martin Clothing Store. De acuerdo con la experiencia, el gerente de la tienda estima que la probabilidad de que un cliente realice una compra es 0.30.
#   - a. Describa si cumple con las reglas para clasificarlo como un experimiento binomial.

# a. Cumple con las 4 reglas.
#   1. Cada ensayo tiene solo dos posibles resultados, que se denominan "éxito" y "fracaso".
#   2. La probabilidad de éxito en cada ensayo es constante. 0.30
#   3. Es posible describir el experimento como una serie de tres ensayos idénticos
#   4. La decisión de comprar es independiente de la decisión de compra de los otros clientes.

# b. ¿Cuál es la probabilidad de que dos de los próximos tres clientes realicen una compra?
funcion_binomial(2,3,0.30)
# 18.9%

# c. ¿Cuál es la probabilidad de que cuatro de los próximos diez clientes realicen una compra?
funcion_binomial(4,10,0.30)
# 20.01%

print('4.')
# 4.  A la oficina de reservaciones de una aerolínea regional llegan 48 llamadas por hora.

# 48 llamadas * 60 minutos
# print(48 / 60)
# 48 / 60 = 0.8

# - a. Calcule la probabilidad de recibir cinco llamadas en un lapso de 5 minutos.
probabilidad_poisson((5 * 0.8), 5)

# - b. Estime la probabilidad de recibir exactamente 10 llamadas en un lapso de 15 minutos.
probabilidad_poisson((10 * 0.8), 15)

# - c. Suponga que no hay ninguna llamada en espera. Si el agente de viajes necesitará 5 minutos para la llamada que está atendiendo, ¿cuántas llamadas habrá en espera para cuando él termine? ¿Cuál es la probabilidad de que no haya ninguna llamada en espera?

print('¿Cuántas llamadas habrá en espera para cuando él termine? 5 * 0.8 = 4')
print('¿Cuál es la probabilidad de que no haya ninguna llamada en espera?')
probabilidad_poisson(4, 0)

# - d. Si en este momento no hay ninguna llamada, ¿cuál es la probabilidad de que el agente de viajes pueda tomar 3 minutos de descanso sin ser interrumpido por una llamada?
print('\nSi en este momento no hay ninguna llamada, ¿cuál es la probabilidad de que el agente de viajes pueda tomar 3 minutos de descanso sin ser interrumpido por una llamada?')

probabilidad_poisson((3 * 0.8), 0)


print('\n5.\n')

# 5. En una encuesta realizada por Gallup Organization, se les preguntó a los interrogados, “Cuál es el deporte que prefieres ver”. Futbol y básquetbol ocuparon el primero y segundo lugar de preferencia (www.gallup.com, 3 de enero de 2004). Si en un grupo de 10 individuos, siete prefieren futbol y tres prefieren básquetbol. Se toma una muestra aleatoria de tres de estas personas.

# probabilidad de que prefieras el futbol:
# 7 / 10 = 
# print(7 / 10)

print('\na. ¿Cuál es la probabilidad de que exactamente dos prefieren el futbol?')

print(probabilidad_hipergeometrica(10,7,3,2))
# N = tamaño de poblacion
# X = numero de elementos que cumplen la condicion
# n = tamaño de la muestra
# x = n° de elementos q cumplen la condicion en la muestra

print('\nb. ¿De que la mayoría (ya sean dos o tres) prefiere el futbol?')
print(probabilidad_hipergeometrica(10,7,3,3) + probabilidad_hipergeometrica(10,7,3,2))

