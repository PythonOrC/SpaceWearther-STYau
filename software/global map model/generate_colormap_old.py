# Copyright (C) 2023 Ethan Hu
# 
# This file is part of Final.
# 
# Final is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Final is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Final.  If not, see <http://www.gnu.org/licenses/>.
import math
rgb = []
blocks = 64
interval = 4/(blocks-1)
def r_val(x):
    return -0.0542*x**4 + 0.375*x**3 - 0.6458*x**2 + 0.225*x + 0.2
def g_val(x):
    return 0.0208*x**4 - 0.125*x**3 + 0.1292*x**2 + 0.375*x + 0.1
def b_val(x):
    return -0.0125*x**4 + 0.1417*x**3 - 0.5875*x**2 + 0.7583*x + 0.5


def getRGB(x):
    r=r_val(x)
    g=g_val(x)
    b=b_val(x)
    r=max(0,min(1,r))
    g=max(0,min(1,g))
    b=max(0,min(1,b))
    r=round(r,3)
    g=round(g,3)
    b=round(b,3)
    return [r,g,b]


for i in range(0,blocks):
    x = i*interval
    # x = 4/(1+25*math.e**(-1.6*x))
    x = 4/(1+270.4265*math.e**(-2.8*x))
    rgb.append(getRGB(x))

print("[", end="")
for triple in rgb:
    print(triple[0], triple[1], triple[2])
print("];")

for i in range(0,blocks):
    x = i*interval
    x = 2/(1+99.465*math.e**(-2.8*x))
    rgb.append(getRGB(x))

    
    
