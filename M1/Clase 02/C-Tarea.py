import csv

total_co2 = 0

with open('Emisiones_CO2.csv') as archivo:
    reader = csv.reader(archivo, delimiter='|')

    for row in reader:
        codigo, pais, region, anio, co2_kt, co2_pc = row
        int(co2_kt)
        if anio == '2010':
            if co2_kt:
                total_co2 += co2_kt

print(f'El total de emisiones de CO2 en América Latina y Caribe en 2010 es: {total_co2} kt')