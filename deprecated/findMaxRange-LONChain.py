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
PERIOD = "0509"
ZONE="north"
LATRANGE = 10

if PERIOD == "0509":
    if ZONE == "north":
        MANUAL = []
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLAT-sorted\HalloweenStorm-SuperMAG-0509_stations_north.csv', 'r')
    elif ZONE =="equator":
        MANUAL=["TSU","LRM"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLAT-sorted\HalloweenStorm-SuperMAG-0509_stations_equator.csv', 'r')
    else:
        MANUAL=["B12","MCQ","B11"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLAT-sorted\HalloweenStorm-SuperMAG-0509_stations_south.csv', 'r')
else:
    if ZONE == "north":
        MANUAL = []
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLAT-sorted\HalloweenStorm-SuperMAG-1724_stations_north.csv', 'r')
    elif ZONE == "equator":
        MANUAL=["GUI", "PHU","GZH"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLAT-sorted\HalloweenStorm-SuperMAG-1724_stations_equator.csv', 'r')
    else:
        MANUAL=["MCQ", "B04","B11","B12"]
        f = open('D:\Github Repository\SpaceWeather\matlab\examples\MAGLAT-sorted\HalloweenStorm-SuperMAG-1724_stations_south.csv', 'r')
csv_reader = csv.DictReader(f)
manual_save = []
longest = []
current = []
for row in csv_reader:
    if row["IAGA"] in MANUAL:
        manual_save.append(row)
    else:
        current.append(row)
        while abs(float(current[-1]["MAGLAT"]) - float(current[0]["MAGLAT"])) > LATRANGE:
            current.pop(0)
        longest = current.copy() if len(current) > len(longest) else longest



sorted_longest = sorted(longest + manual_save, key=lambda d: float(d['MAGLON'])) 

stations = []
for row in sorted_longest:
    stations.append(row["IAGA"])
    print(row)
    

print("Length: " + str(len(stations)))
print("MAGLON Min/Max: " + str(min_max(sorted_longest, "MAGLON")))
print("MAGLAT Min/Max: " + str(min_max(sorted_longest, "MAGLAT")))

print(str(stations).replace(",", "").replace("'","\""))

print(",".join(list(row.keys())))
for row in sorted_longest:
    print(",".join(list(row.values())))
    