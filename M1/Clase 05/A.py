import random

name = input('Bienvenido a num50. Escribe tu nombre: ')
age = int(input('¿Cuantos años tenes? '))

def finish():
    if (sum(n_list) > 50):
        print('No puedes terminar hasta tener menos de 50 puntos.')
    else:
        print(f'GAME OVER \n Tienes {sum(n_list)} puntos')
        s_left = 50 - sum(n_list)
        score = 10 - s_left
        print(f'{name} de {age} años obtuvo una calificacion final de {score}/10')
    

if (age >= 18):
    print(f'El juego consiste en ... ')

    n_times = int(input('Selecciona la cantidad de numeros aleatorios del 1 al 20 que se generaran: '))

    n_list = []
    i = 0
    while n_times > i:
        n_list.append(random.randint(0, 20))
        i += 1

    while True:
        if (sum(n_list) > 50):
            print(f'Tienes {sum(n_list)} puntos, que la fuerza te acompañe...')

            def drop():
                n_list.pop()
                print(f'Te quedan {sum(n_list)} puntos')

            while (sum(n_list) > 50):
                keyb = input('Esperando... ')
                if (keyb == 'x'):
                    drop()
                elif (keyb == 'y'):
                    finish()
        else:
            finish()
            break

else:
    print(f'Lo siento {name}, no tienes la edad suficiente para jugar a este juego')