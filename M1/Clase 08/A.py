print('\nDada la función provista "ListaDesordenada" implementar los algoritmos de ordenamiento vistos en clase: Selección, Burbuja \n')

import random as r
import numpy as np

def ListaDesordenada(desorden, cantidad): 

    lista = list(range(0, cantidad))
    desorden = int(cantidad * desorden / 100)

    while (desorden > 0):
        i = r.randint(0,cantidad-1)
        j = r.randint(0,cantidad-1)
        aux = lista[i]
        lista[i] = lista[j]
        lista[j] = aux
        desorden-=1

    return lista

lista = ListaDesordenada(100, 21)
print(lista,'\n')

# def ord_por_seleccion(list):
#     lista.sort()

# def ord_por_seleccion(l):

#     i_i = 0
#     j_i = 0

#     for i in l:
#         for j in l:
#             if j < i:
#                 lista[i_i], lista[j_i] = lista[j_i], lista[i_i]
#             j_i += 1
#         i_i += 1
#         j_i = 0

#     print(lista, '\n')

def ord_por_seleccion(l):
    n = len(l)
    for i in range(n):
        min_idx = i
        for j in range(i+1, n):
            if l[j] < l[min_idx]:
                min_idx = j
            l[i], l[min_idx] = l[min_idx], l[i]
    print(l)

ord_por_seleccion(lista)