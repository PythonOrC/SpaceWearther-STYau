SEG = "1724";
PRENOON = true;
ZONE = "upper north";
Xcorr = 99;
LINE = "MAGLON";
SPACING = 0;
OFFSET = 0;
INCLUDE_IMF = false;
IMF_SCALE = 10;

if SEG == "0509"
    INTERVAL = 50:150;
    if LINE == "MAGLAT"
        if PRENOON == true
            if Xcorr == 0
                STATIONS =["MAW" "CZT" "HBK" "LMM" "MLT" "ELT" "QSB" "ISK" "SUA" "LVV" "BEL" "HLP" "TAR" "LOV" "UPS" "NUR" "HAN" "OUJ" "PEL" "SOD" "KIR" "MUO" "IVA" "ABK" "KIL" "MAS" "AND" "TRO" "SOR" "BJN" "HOR" "HRN" "ALE"];
            elseif Xcorr == 1
                STATIONS =["SOR" "BJN" "HOR" "HRN"];
            elseif Xcorr == 2
                STATIONS =["HAN" "OUJ" "PEL" "SOD" "KIR" "MUO" "IVA" "ABK" "KIL" "MAS" "AND"];
            elseif Xcorr == 3
                STATIONS =["HBK" "LMM" "MLT" "ELT" "QSB" "ISK" "SUA" "LVV" "BEL" "HLP" "TAR" "LOV" "UPS"];
            elseif Xcorr == 4
                STATIONS =["BJN" "HOR" "HRN" "ALE"];
            end
        elseif PRENOON == false
            if Xcorr == 0
                STATIONS = ["DRV" "LEM" "ASP" "CTA" "KDU" "WEP" "WEW" "GUA" "CBI" "KNY" "KAG" "HTY" "KAK" "ONW" "PPI" "RIK" "MMB" "MSR" "MGD" "CHD" "TIK" "KTN"]; 
            elseif Xcorr == 1
                STATIONS = ["CHD" "TIK" "KTN"];  
            elseif Xcorr == 2
                STATIONS = ["LEM" "ASP" "CTA" "KDU" "WEP" "WEW" "GUA" "CBI" "KNY" "KAG" "HTY" "KAK" "ONW" "PPI" "RIK" "MMB" "MSR" "MGD"]; 
            elseif Xcorr == 3
                STATIONS = ["GUA" "HTY" "ONW" "MMB"];
            end
        end
    elseif LINE == "MAGLON"
        if ZONE == "upper north"
            if Xcorr == 0
                STATIONS =["TIK" "KTN" "CHD" "BRW" "BET" "KAV" "ARC" "CMO" "PKR" "FYU" "GAK" "EAG" "DAW" "FSP" "YKC" "CNL" "SMI" "FMC" "GIM" "ISL" "FCC" "RAN" "PBQ" "IQA" "SKT" "FHB" "STF" "NAQ" "AMK" "LRV" "SCO" "JAN" "AND" "ABK" "KIR" "TRO" "KIL" "PEL" "MUO" "SOR" "MAS" "SOD" "BJN" "IVA" "KEV" "NOK"];
            elseif Xcorr == 1
                STATIONS = ["SCO" "JAN" "AND" "ABK" "KIR" "TRO" "KIL" "PEL" "MUO" "SOR" "MAS" "SOD" "BJN" "IVA" "KEV" "NOK" "TIK" "KTN" "CHD" "BRW"];
            elseif Xcorr == 2
                STATIONS = ["BET" "KAV" "ARC" "CMO" "PKR" "FYU" "GAK" "EAG" "DAW" "FSP" "YKC" "CNL" "SMI" "FMC" "GIM" "ISL" "FCC" "RAN" "PBQ" "IQA" "SKT" "FHB" "STF" "NAQ" "AMK" "LRV"];
            elseif Xcorr == 99
                STATIONS = ["PBQ" "IQA" "SVS" "STF" "AMK" "SCO" "JAN" "BJN" "LYR" "NOK" "TIK" "KTN" "CHD" "BRW" "KAV" "ARC" "FSP" "CNL" "BLC" "RAN"];
            end
        elseif ZONE == "lower north"
            if Xcorr == 99
                STATIONS = ["FRD" "STJ" "CLF" "FUR" "LVV" "NVS" "IRT" "BMT" "PPI" "MSR" "PET" "VIC" "FRN" "TUC" "BOU" "DLR" "BSL"];
            end
        elseif ZONE == "equator"
            if Xcorr == 0
                STATIONS = ["KDU" "WEP" "CTA" "API" "PPT" "VLD" "OSO" "SER" "CER" "PAC" "TRW" "VSS" "ASC" "TAN"]; 
            elseif Xcorr == 1
                STATIONS = ["KDU" "WEP" "CTA" "API" "PPT" "VLD" "OSO" "SER" "CER" "PAC" "TRW" "VSS" "ASC" "TAN"];  
            elseif Xcorr == 4
                STATIONS = ["KDU" "WEP" "CTA" "API" "PPT" ];  
            elseif Xcorr == 99
                STATIONS = ["HUA" "VRE" "KOU" "MBO" "TAM" "BNG" "MLT" "AAE" "ABG" "PHU" "TND" "GUA" "API" "HON" "PPT"];
            end
        elseif ZONE == "south"
            if Xcorr == 0
                STATIONS = ["DRV" "MCQ" "MCM" "SBA" "B23" "B18" "B14" "B21" "B12" "B19" "B20" "B11" "B17" "B22" "B15" "B04" "MAW" "CSY"]; 
            elseif Xcorr == 1
                STATIONS = ["DRV" "MCQ" "MCM" "SBA" "B23" "B18" "B14" "B21" "B12" "B19" "B20" "B11" "B17" "B22" "B15" "B04" "MAW" "CSY"];  
            elseif Xcorr == 4
                STATIONS = ["MCM" "SBA"];  
            elseif Xcorr == 5
                STATIONS = ["B23" "B18" "B14" "B21" "B12" "B19" "B20" "B11" "B17" "B22" "B15" "B04"];  
            elseif Xcorr == 99
                STATIONS = ["B03" "B23" "B14" "B15" "B04" "MAW" "CZT" "PAF" "AMS" "CSY" "KAT" "LEM" "DRV" "MCQ" "EYR" "MCM" "SBA"];
            end
        end
    end
elseif SEG == "1724"
    INTERVAL = 1:250; % or 50:150 for 0509
    if LINE == "MAGLAT"
        if PRENOON == true
            if Xcorr == 0
                STATIONS =["DRV" "ASP" "CTA" "KDU" "WEP" "WEW" "GUA" "CBI" "KNY" "KAG" "HTY" "KAK" "ONW" "PPI" "MMB" "MSR" "MGD" "CHD" "KTN"];
            elseif Xcorr == 1
                STATIONS = ["CHD" "KTN"];
            elseif Xcorr == 2
                STATIONS =["ASP" "CTA" "KDU" "WEP" "WEW" "GUA" "CBI" "KNY" "KAG" "HTY" "KAK" "ONW" "PPI" "MMB" "MSR"];
            elseif Xcorr == 4
                STATIONS =["ASP" "CTA" "KDU" "WEP" "WEW" "GUA" "CBI" "KNY" "KAG" "HTY" "KAK" "ONW" "PPI" "MMB" "MSR" "MGD"];
            end
        elseif PRENOON == false
            if Xcorr == 0
                STATIONS = ["MAW" "CZT" "HBK" "BNG" "AAE" "MLT" "ELT" "QSB" "ISK" "SUA" "LVV" "BEL" "HLP" "TAR" "LOV" "UPS" "NUR" "HAN" "OUJ" "PEL" "SOD" "KIR" "MUO" "IVA" "ABK" "KIL" "MAS" "KEV" "AND" "TRO" "SOR" "BJN" "HRN" "HOR" "LYR" "NAL" "DMH" "NRD" "ALE"]; 
            elseif Xcorr == 1
                STATIONS = ["PEL" "SOD" "KIR" "MUO" "IVA" "ABK" "KIL" "MAS" "KEV" "AND" "TRO" "SOR" "BJN" "HRN" "HOR" "LYR" "NAL" "DMH" "NRD" "ALE"];  
            elseif Xcorr == 2
                STATIONS = ["CZT" "HLP" "LOV" "UPS" "NUR" "HAN" "OUJ"]; 
            elseif Xcorr == 3
                STATIONS = ["HBK" "BNG" "AAE" "MLT" "ELT" "QSB" "ISK" "SUA" "LVV" "BEL"];  
            end
        end
    elseif LINE == "MAGLON"
        if ZONE == "upper north"
            if Xcorr == 0
                STATIONS =["KTN" "CHD" "BRW" "BET" "KAV" "ARC" "CMO" "PKR" "FYU" "GAK" "EAG" "DAW" "FSP" "YKC" "CNL" "FMC" "RAL" "GIM" "ISL" "FCC" "PBQ" "IQA" "SKT" "FHB" "STF" "NAQ" "AMK" "LRV" "SCO" "JAN" "AND" "ABK" "KIR" "TRO" "KIL" "PEL" "MUO" "SOR" "MAS" "SOD" "BJN" "IVA" "KEV" "NOK"];
            elseif Xcorr == 1
                STATIONS = ["FSP" "YKC" "CNL" "FMC" "RAL" "GIM" "ISL" "FCC" "PBQ" "IQA" "SKT" "FHB" "STF" "NAQ" "AMK" "LRV" "SCO" "JAN" "AND" "ABK" "KIR" "TRO" "KIL" "PEL" "MUO" "SOR" "MAS" "SOD" "BJN" "IVA" "KEV" "NOK"];
            elseif Xcorr == 2
                STATIONS = ["NOK"];
            elseif Xcorr == 99
                STATIONS = ["PBQ" "IQA" "SVS" "STF" "AMK" "SCO" "JAN" "BJN" "LYR" "NOK" "TIK" "KTN" "CHD" "BRW" "KAV" "ARC" "FSP" "CNL" "BLC" "RAN"];
            end
        elseif ZONE == "lower north"
            if Xcorr == 99
                STATIONS = ["FRD" "STJ" "CLF" "FUR" "LVV" "NVS" "IRT" "BMT" "PPI" "MSR" "PET" "VIC" "FRN" "TUC" "BOU" "DLR"];
            end    
        elseif ZONE == "equator"
            if Xcorr == 0
                STATIONS = ["GZH" "BMT" "KAG" "KNY" "HTY" "KAK" "ONW" "CBI" "EWA" "HON" "SJG" "SPT" "EBR" "MLT" "ELT" "QSB" "LZH" "PHU"]; 
            elseif Xcorr == 1
                STATIONS = ["GZH" "BMT" "KAG" "KNY" "HTY" "KAK" "ONW" "CBI" "EWA" "HON" "SJG" "SPT" "EBR" "MLT" "ELT" "QSB" "LZH" "PHU"];  
            elseif Xcorr == 99
                STATIONS = ["HUA" "VRE" "KOU" "MBO" "TAM" "BNG" "MLT" "AAE" "ABG" "PHU" "TND" "GUA" "API" "HON" "PPT"];
            end
        elseif ZONE == "south"
            if Xcorr == 0
                STATIONS = ["DRV" "MCQ" "MCM" "SBA" "SPA" "B23" "B18" "B14" "B21" "B12" "B19" "B20" "B11" "B17" "B22" "B15" "B04" "MAW" "CSY"]; 
            elseif Xcorr == 1
                STATIONS = ["DRV" "MCM" "SBA" "SPA" "B23" "B18" "B14" "B21" "B12" "B19" "B20" "B11" "B17" "B22" "B15" "B04" "MAW" "CSY"];  
            elseif Xcorr == 99
                STATIONS = ["B03" "B23" "B14" "B15" "B04" "MAW" "CZT" "PAF" "AMS" "CSY" "LRM" "LEM" "DRV" "MCQ" "EYR" "MCM" "SBA"];
            end
        end
    end
end


DATA = 'dbn_nez';

% import the raw unprocessed data
if SEG == "0509"
    raw = readtable("HalloweenStorm-SuperMAG-0509.csv", "Delimiter",",", "DatetimeType","datetime");
    raw_ACE = readtable("ACE_0509_interp.csv");
else
    raw = readtable("HalloweenStorm-SuperMAG-1724.csv", "Delimiter",",", "DatetimeType","datetime");
    raw_ACE = readtable("ACE_1724_interp.csv");
end

% get the stations from the raw data
[Stations,IA,IC] = unique(raw.IAGA, 'stable');
mlt_all = raw.MLT;
% get the latitude and longitude of each station
lat = raw.MAGLAT(1:length(Stations), 1);
long = raw.MAGLON(1:length(Stations), 1);

Bx = raw_ACE.Bx;
By = raw_ACE.By;
Bz = raw_ACE.Bz;

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
disp(stat)
if INCLUDE_IMF == true
    filtered = [IMF_SCALE * Bz(INTERVAL-OFFSET); filtered];
    filtered = [IMF_SCALE * By(INTERVAL-OFFSET); filtered];
    filtered = [IMF_SCALE * Bx(INTERVAL-OFFSET); filtered];
end
figure;

hold on;
for i = 1:length(filtered)
    data_f = filtered{i}(:);
    plot(1:length(data_f),data_f+SPACING);
    SPACING = SPACING + 500;
end

corr_lag = [];
corr_r = [];
    % if PRENOON == true
    %     x_station = 2;
    % elseif PRENOON ==false
    %     x_station = 1;
    % end   
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
[r, lag] = xcorr(filtered{1}(:), filtered{4}(:), 'normalized'); 
lag = lag(r == max(r));
r = max(r);