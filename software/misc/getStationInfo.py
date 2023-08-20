# Copyright (C) 2023 Ethan Hu
# 
# This file is part of SpaceWeather.
# 
# SpaceWeather is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# SpaceWeather is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with SpaceWeather.  If not, see <http://www.gnu.org/licenses/>.

import csv

STATIONS = ["MAW", "CZT", "HBK", "LMM", "MLT", "ELT", "QSB", "ISK", "SUA", "LVV", "BEL", "HLP", "TAR", "LOV", "UPS", "NUR", "HAN", "OUJ", "PEL", "SOD", "KIR", "MUO", "IVA", "ABK", "KIL", "MAS", "AND", "TRO", "SOR", "BJN", "HOR", "HRN", "ALE"]
TIME = "0509"
CHAIN="MAGLAT"
f = open(f'D:\Github Repository\SpaceWeather\matlab\examples\HalloweenStorm-SuperMAG-{TIME}-stations.csv', 'r')

csv_reader = csv.DictReader(f)

station_info = []
for row in csv_reader:
    if row["IAGA"] in STATIONS:
        station_info.append(row)
        
        
station_info = sorted(station_info, key=lambda d: float(d[CHAIN])) 
print(",".join(list(row.keys())))
for row in station_info:
    print(",".join(list(row.values())))