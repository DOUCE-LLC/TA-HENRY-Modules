print('\n1.\n')
# 1. Suponga dos eventos, A y B, y que P(A) = 0.50, P(B) = 0.60 y P(A ∩ B) = 0.40.
# - a. Halle P(A | B).
# - b. Halle P(B | A).
# - c. ¿A y B son independientes? ¿Por qué sí o por qué no?

a = 0.5
b = 0.6
c = 0.4

print('¿Son independientes? No. \n')

# independientes significa que la probabilidad de uno no se ve afectada por la del otro.
# es como un dado, la probabilidad de que salga un 5 no cambia si anteriormente salio un 5, sigue siendo de 1/6
# en este caso nos dicen que...   P(A) = 0.50,   P(B) = 0.60,   P(A ∩ B) = 0.40.
# si son independientes la probabilidad de que se den estos 2 casos (a y b) deberia ser igual, entonces...
# Ecuacion: P(A ∩ B) = P(A) * P(B)

print('P(A ∩ B) = P(A) * P(B) \n', c, ' = ', a * b, '\n')

# 0.4 = 0.3
# Es decir que no son independientes. Si uno ocurre, la probabilidad del otro cambia.

# Debido a que son independientes nos preguntamos cual es la probabilidad de que ocurra A luego de B.
# Formula: P(A|B) = P(A ∩ B) / P(B)
print('P(A|B):', c / b)
print('P(B|A):', c / a)

print('\n2.\n')
# 2. Suponga dos eventos, A y B, que son mutuamente excluyentes. Admita, además, que P(A) = 0.30 y P(B) = 0.40.
# - a. Obtenga P(A ∩ B). ¿Existe intersección entre los dos conjuntos?.
# - b. Calcule P(A | B).
# - c. Un estudiante de estadística argumenta que los conceptos de eventos mutuamente excluyentes y eventos independientes son en realidad lo mismo y que si los eventos son mutuamente excluyentes deben ser también independientes. ¿Está usted de acuerdo? Use la información sobre las probabilidades para justificar su respuesta.

# Si son excluyentes, por definicion no pueden darse a la vez. Es decir:    P(A ∩ B) = 0
print('P(A ∩ B) = 0 \n')

# Para calcular la probabilidad de que ocurra A luego de B.     P(A ∩ B) / P(B)
print('P(A ∩ B) / P(B) = 0 \n')

# Independiente es que si pasa uno, no afecta al otro. si llueve en el Hymalaya, no tiene porque llover en Bs. As.
# Excluyente significa que si llueve en Bs. As. no puede llover en el Hymalaya, lo que es falso.
print('c. La estudiante de estadistica esta equivocada, independiente no es = a excluyente.')


print('\n3.\n')