#open a csv file and find the minimum and maximum

import csv
import math
with open('20031029-supermag-6-stations.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)

    next(csv_reader)

    min_value = math.inf
    max_value = -math.inf

    for line in csv_reader:
        if float(line[11]) < min_value:
            min_value = float(line[11])
        if float(line[11]) > max_value:
            max_value = float(line[11])
    print(min_value)
    print(max_value)

