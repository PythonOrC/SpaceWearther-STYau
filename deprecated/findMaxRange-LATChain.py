def clean_dict_print(li):
    for item in li:
        print(item)
    print()
def num_range(dict_li, key):
    return max([float(d[key]) for d in dict_li]) - min([float(d[key]) for d in dict_li])

def min_max(dict_li, key):
    return min([float(d[key]) for d in dict_li]), max([float(d[key]) for d in dict_li])

import csv
PERIOD = "1724"
PRENOON=True
LONRANGE = 15
TOP = 10
# Open the file

if PERIOD == "0509":
    if PRENOON == True:
        MANUAL = ["MAW"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-0509_stations_prenoon.csv', 'r')
    else:
        MANUAL=["MGD", "DRV","TWN","CTA", "HOB","LEM","TIK"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-0509_stations_afternoon.csv', 'r')
else:
    if PRENOON == True:
        MANUAL = ["MGD","DRV","TWN","CTA",]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-1724_stations_prenoon.csv', 'r')
    else:
        MANUAL=["MAW","AAE","BNG","HOR","LYR", "NAL","DMH", "KEV"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLON-sorted\HalloweenStorm-SuperMAG-1724_stations_afternoon.csv', 'r')
csv_reader = csv.DictReader(f)
manual_save = []
longest = []
current = []
for row in csv_reader:
    if row["IAGA"] in MANUAL:
        manual_save.append(row)
    else:
        current.append(row)
        while abs(float(current[-1]["MAGLON"]) - float(current[0]["MAGLON"])) > LONRANGE:
            current.pop(0)
        longest = current.copy() if len(current) > len(longest) else longest



sorted_longest = sorted(longest + manual_save, key=lambda d: float(d['MAGLAT'])) 

stations = []
for row in sorted_longest:
    stations.append(row["IAGA"])
    print(row)
    

print("Length: " + str(len(stations)))
print("MAGLON Min/Max: " + str(min_max(sorted_longest, "MAGLON")))
print("MAGLAT Min/Max: " + str(min_max(sorted_longest, "MAGLAT")))

print(str(stations).replace(",", "").replace("'","\""))