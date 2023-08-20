raw = readtable("HalloweenStorm-SuperMAG-0509.csv", "Delimiter",",", "DatetimeType","datetime");
% get the stations from the raw data
[Stations,IA,IC] = unique(raw.IAGA);
% get the latitude and longitude of each station
lat = raw.GEOLAT(1:length(Stations), 1);
long = raw.GEOLON(1:length(Stations), 1);
clear LOC;
[LOC(1:length(Stations)).Geometry] = deal('Point');
for i = 1:length(Stations)
    LOC(i).Lat = lat(i);
    LOC(i).Lon = long(i);
end

%convert the lat and long from [0,360] to [-180,180]
for i = 1:length(lat)
    if lat(i) > 180
        lat(i) = lat(i) - 360;
    end
    if long(i) > 180
        long(i) = long(i) - 360;
    end
end

clear min_n;
clear max_n;
% extract the necessary data from the raw data
clear data;
data = {};
min_n = [];
max_n=[];
for i = 1:length(Stations)
    % raw datum refers to all the data from a single station
    raw_datum = raw(raw.IAGA == string(Stations(i)), :);
    % extract the needed datum from the raw datum
    datum = table2array(raw_datum(:,{DATA}));
    %interpolate the Nan values
    datum = fillmissing(datum, 'linear');
    min_n = [min(datum) min_n];
    max_n = [max(datum) max_n];
    % add the datum to the data cell array
    data = [data; datum];
end
minimum = min(min_n);
maximum = max(max_n);
