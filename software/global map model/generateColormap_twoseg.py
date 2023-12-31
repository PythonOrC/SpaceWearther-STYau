# Copyright (C) 2023 Ethan Hu
# 
# This file is part of global map model.
# 
# global map model is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# global map model is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with global map model.  If not, see <http://www.gnu.org/licenses/>.

from frequencyToRGB import wavelength_to_rgb
import math
rgb=[]
max_freq = 620
min_freq = 420
# max_freq = 580
# min_freq = 510
resolution = 256
# print((max_freq-min_freq)/resolution)
# print((min_freq-380)/(resolution/2))
x=380
while x < min_freq:
    rgb.append(wavelength_to_rgb(x))
    x += (min_freq-380)/(resolution/2)
    
x = min_freq
while x < max_freq:
    if x < 520:
        curved_x = 100/(1+math.e**(-0.15*(x-495)))+420
    else:
        curved_x = 100/(1+math.e**(-0.15*(x-545)))+520
    
    rgb.append(wavelength_to_rgb(curved_x))
    x += (max_freq-min_freq)/resolution

with open("colormap.txt", "w") as f:
    f.write("[")
    for triple in rgb:
        f.write(str(triple[0]) + " " + str(triple[1]) + " " + str(triple[2]) + "\n")
    f.write("];")
print(100/(1+math.e**(-0.1*(500-470)))+420)
print(100/(1+math.e**(-0.1*(520-570)))+520)