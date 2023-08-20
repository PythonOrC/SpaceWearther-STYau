SEG = "1724";
ZONE = "after-midnight";

if SEG == "0509"
    INTERVAL = 50:150;
    if ZONE == "prenoon"
        STATIONS =["MAW" "CZT" "LMM" "ELT" "QSB" "ISK" "SUA" "LVV" "HLP" "TAR" "HAN" "OUJ" "SOD" "SOR" "BJN" "HRN" "ALE"];
    elseif ZONE == "afternoon"
        STATIONS = ["DRV" "LEM" "ASP" "KDU" "WEP" "WEW" "GUA" "CBI" "KAG" "HTY" "KAK" "ONW" "RIK" "MSR" "MGD" "CHD"]; 
    elseif ZONE == "upper north"
        STATIONS = ["PBQ" "IQA" "SVS" "STF" "AMK" "SCO" "JAN" "BJN" "LYR" "NOK" "TIK" "KTN" "CHD" "BRW" "KAV" "ARC" "FSP" "CNL" "BLC" "RAN"];
    elseif ZONE == "lower north"
        STATIONS = ["FRD" "STJ" "CLF" "FUR" "LVV" "NVS" "IRT" "BMT" "PPI" "MSR" "PET" "VIC" "FRN" "TUC" "BOU" "DLR" "BSL"];
    elseif ZONE == "equator"
        STATIONS = ["HUA" "VRE" "KOU" "MBO" "TAM" "BNG" "MLT" "AAE" "ABG" "PHU" "TND" "GUA" "API" "HON" "PPT"];
    elseif ZONE == "south"
        STATIONS = ["B03" "B23" "B14" "B15" "B04" "MAW" "CZT" "PAF" "AMS" "CSY" "KAT" "LEM" "DRV" "MCQ" "EYR" "MCM" "SBA"];
    end
elseif SEG == "1724"
    INTERVAL = 1:250;
    if ZONE == "pre-midnight"
        STATIONS =["MAW" "CZT" "HBK" "BNG" "AAE" "QSB" "ISK" "SUA" "LVV" "HLP" "TAR" "HAN" "OUJ" "SOD" "SOR" "BJN" "HRN" "NRD" "ALE"];
    elseif ZONE == "after-midnight"
        STATIONS = ["DRV" "ASP" "CTA" "KDU" "WEP" "WEW" "GUA" "CBI" "KAG" "HTY" "KAK" "ONW" "MSR" "MGD" "CHD" "KTN"]; 
    elseif ZONE == "upper north"
        STATIONS = ["PBQ" "IQA" "SVS" "STF" "AMK" "SCO" "JAN" "BJN" "LYR" "NOK" "TIK" "KTN" "CHD" "BRW" "KAV" "ARC" "FSP" "CNL" "BLC" "RAN"];
    elseif ZONE == "lower north"
        STATIONS = ["FRD" "STJ" "CLF" "FUR" "LVV" "NVS" "IRT" "BMT" "PPI" "MSR" "PET" "VIC" "FRN" "TUC" "BOU" "DLR"]; 
    elseif ZONE == "equator"
        STATIONS = ["HUA" "VRE" "KOU" "MBO" "TAM" "BNG" "MLT" "AAE" "ABG" "PHU" "TND" "GUA" "API" "HON" "PPT"];
    elseif ZONE == "south"
        STATIONS = ["B03" "B23" "B14" "B15" "B04" "MAW" "CZT" "PAF" "AMS" "CSY" "LRM" "LEM" "DRV" "MCQ" "EYR" "MCM" "SBA"];
    end
end


DATA = 'dbn_nez';

% import the raw unprocessed data
if SEG == "0509"
    raw = readtable("HalloweenStorm-SuperMAG-0509.csv", "Delimiter",",", "DatetimeType","datetime");
else
    raw = readtable("HalloweenStorm-SuperMAG-1724.csv", "Delimiter",",", "DatetimeType","datetime");
end

% get the stations from the raw data
[Stations,IA,IC] = unique(raw.IAGA, 'stable');
mlt_all = raw.MLT;
% get the latitude and longitude of each station
lat = raw.MAGLAT(1:length(Stations), 1);
long = raw.MAGLON(1:length(Stations), 1);

% extract the necessary data from the raw data
clear data;
data = {};
for i = 1:length(Stations)
    % raw datum refers to all the data from a single station
    raw_datum = raw(raw.IAGA == string(Stations(i)), :);
    % extract the needed datum from the raw datum
    datum = table2array(raw_datum(:,{DATA}));
    %interpolate the Nan values
    datum = fillmissing(datum, 'linear');
    % add the datum to the data cell array
    data = [data; datum];
end

% combine the data and the Stations together
clear OBS;
OBS = table(Stations, data, lat, long);
%resulting sample structure of all:
    % Stations         data           lat      long  
    % ________    _______________    _____    _______
    % {'BOU'}     {1440×1 double}    40.14    -105.24
    % {'BSL'}     {1440×1 double}    30.35     -89.64
    % {'FRD'}     {1440×1 double}     38.2     -77.37
    % {'FRN'}     {1440×1 double}    37.09    -119.72
    % {'NEW'}     {1440×1 double}    48.27    -117.12

%combine all the values together
filtered = {};
stat = {};
for i = 1:length(STATIONS)
    for j = 1:length(Stations)
        if strcmp(string(Stations(j)), string(STATIONS(i)))
            filtered = [filtered; OBS.data{j}(INTERVAL)];
            stat = [stat; STATIONS(i)];
        end
    end
end
clear max;
clear min;
minmaxes  = table();
for i = 1:length(filtered)
    minmaxes = [minmaxes; {stat(i), min(filtered{i}), max(filtered{i})}];
end
minmaxes.Properties.VariableNames = {'Station', 'Min', 'Max'};

corr_lag = [];
corr_r = [];
for i = 1:length(filtered)
    temp_lag = [];
    temp_r = [];
    for j = 1: length(filtered)
        [r, lag] = xcorr(filtered{i}(:), filtered{j}(:), 'normalized'); 
        temp_lag = [temp_lag; lag(r == max(r))];
        temp_r = [temp_r; max(r)];
    end
    corr_r = [corr_r temp_r];
    corr_lag = [corr_lag temp_lag];
end
disp(stat)