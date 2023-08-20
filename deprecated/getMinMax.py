def clean_dict_print(li):
    for item in li:
        print(item)
    print()
def num_range(dict_li, key):
    return max([float(d[key]) for d in dict_li]) - min([float(d[key]) for d in dict_li])

def min_max(dict_li, key):
    return min([float(d[key]) for d in dict_li]), max([float(d[key]) for d in dict_li])

    

#longitudinal distributed chain
import csv

files = ["D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-0509_stations_prenoon.csv", 
         "D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-0509_stations_afternoon.csv", 
         "D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-1724_stations_prenoon.csv", 
         "D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-1724_stations_afternoon.csv", 
         ]
stations_xtreme = {}
for file in files:
    csv_reader = csv.DictReader(open(file, 'r'))
    for row in csv_reader:
        if row['Station'] not in stations_xtreme:
            stations_xtreme[row['Station']] = row['']
        