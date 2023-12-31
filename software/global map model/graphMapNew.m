DATA = 'dbn_nez';
SEG = 2;
MARGIN = 0;
MLT_MARGIN = 1;
MAGLAT_CHUNK_SIZE = 10;

% import the raw unprocessed data
if SEG == 1
    raw = readtable("..\\..\\data input\\HalloweenStorm-SuperMAG-Storm1.csv", "Delimiter",",", "DatetimeType","datetime");
    raw_ACE = readtable("..\\..\\data output\\ACE_0509_interp.csv");
    TIME = 309;
    DURATION = 240;
    DATES = {51, 65, 72, 101, 114, 177};
else
    TIME = 1044;
    DURATION = 420;
    DATES = {10, 57, 92, 112, 135, 146, 217, 220};
    raw = readtable("..\\..\\data input\\HalloweenStorm-SuperMAG-Storm2.csv", "Delimiter",",", "DatetimeType","datetime");
    raw_ACE = readtable("..\\..\\data output\\ACE_1724_interp.csv");
end

DATES = cell(1,DURATION);
for i = 1: DURATION
    DATES{i} = i;
end

%INTERVAL = TIME:TIME+DURATION-1;

% get the stations from the raw data
[Stations,IA,IC] = unique(raw.IAGA, 'stable');
mlt_all = raw.MLT;
maglat_all = raw.MAGLAT;
% get the latitude and longitude of each station
lat = raw.GEOLAT(1:length(Stations), 1);
long = raw.GEOLON(1:length(Stations), 1);
for i = 1:length(long)
    if long(i) > 180
        long(i) = long(i)-360;
    end
end



By = raw_ACE.By;
Bz = raw_ACE.Bz;


clear max;
clear min;
max_lat = 90;
min_lat = -90;
max_long = 180;
min_long = -180;
clear max;
clear min;
% extract the necessary data from the raw data
clear data;
data_dbn = {};
data_dbe = {};
data_dbh = {};
for i = 1:length(Stations)
    % raw datum refers to all the data from a single station
    raw_datum = raw(raw.IAGA == string(Stations(i)), :);
    % extract the needed datum from the raw datum
    % datum = table2array(raw_datum(INTERVAL,{DATA}));
    datum_dbn = table2array(raw_datum(:,{DATA}));
    datum_dbe = table2array(raw_datum(:,{'dbe_nez'}));
    %interpolate the Nan values
    datum_dbe = fillmissing(datum_dbe, 'linear');
    datum_dbn = fillmissing(datum_dbn, 'linear');
    % add the datum to the data cell array
    data_dbn = [data_dbn; datum_dbn];
    data_dbe = [data_dbe; datum_dbe];

    %calculate dbh
    for j = 1:length(datum_dbn)
        dbh = sqrt(datum_dbn(j)^2 + datum_dbe(j)^2);
        % assign the dbh to the correct signage
        if datum_dbn(j) < 0
            dbh = -dbh;
        end
        datum_dbh(j) = dbh;
    end
    data_dbh = [data_dbh; datum_dbh'];
end
clear LOC;
% lat + long of stattions MLT != 12
LOC={};

for i = 1:length(raw.MLT)/length(Stations)
    % temp storage for MLT != 12
    loc_n = [];
    % temp storage for MLT == 12
    loc_m = [];
    % indexs
    loc_n_i = zeros(ceil(180/MAGLAT_CHUNK_SIZE)+1,1) + 1;
    loc_m_i = zeros(ceil(180/MAGLAT_CHUNK_SIZE)+1,1) + 1;
    % loop through each station individually
    % j = index of station
    for j = 1:length(Stations)
        mlt = mlt_all((i-1)*length(Stations)+j);
        maglat = maglat_all((i-1)*length(Stations)+j);
        % decide which maglat chunk the station is in
        maglat_chunk = floor(maglat/MAGLAT_CHUNK_SIZE) + ceil(floor(180/MAGLAT_CHUNK_SIZE)/2)+1;
        % append the station to the correct list
        if mlt <= 12+MLT_MARGIN && mlt >= 12-MLT_MARGIN
            loc_m{maglat_chunk}(loc_m_i(maglat_chunk)).Geometry = 'Point';
            loc_m{maglat_chunk}(loc_m_i(maglat_chunk)).Lat = lat(j);
            loc_m{maglat_chunk}(loc_m_i(maglat_chunk)).Lon = long(j);
            loc_m{maglat_chunk}(loc_m_i(maglat_chunk)).StationID = j;
            loc_m_i(maglat_chunk) = loc_m_i(maglat_chunk) + 1;
        else
            loc_n{maglat_chunk}(loc_n_i(maglat_chunk)).Geometry = 'Point';
            loc_n{maglat_chunk}(loc_n_i(maglat_chunk)).Lat = lat(j);
            loc_n{maglat_chunk}(loc_n_i(maglat_chunk)).Lon = long(j);
            loc_n{maglat_chunk}(loc_n_i(maglat_chunk)).StationID = j;
            loc_n_i(maglat_chunk) = loc_n_i(maglat_chunk) + 1;
        end
    end
    LOC{1,i} = loc_m;
    LOC{2,i} = loc_n;
end
% struct of LOC
%                  t=1            t=2            t=3            t=4            t=5            t=6            t=7        t=n 
% MLT == 12 -> {1×16 cell}    {1×16 cell}    {1×16 cell}    {1×16 cell}    {1×16 cell}    {1×16 cell}    {1×16 cell}    ...
% MLT != 12 -> {1×18 cell}    {1×18 cell}    {1×18 cell}    {1×18 cell}    {1×18 cell}    {1×18 cell}    {1×18 cell}    ...

% struct of one of the cell
%    -90           -89 ~ -80       -79 ~ -60               80 ~ 90
% {0×0 double}    {1×4 double}    {0×0 double}    ...    {1×5 double}
% combine the data and the Stations together
clear OBS;
OBS = table(Stations, data_dbn, lat, long, data_dbe, data_dbh);
%resulting sample structure of all:
    % Stations       data_dbn        lat       long        data_dbe            data_dbh      
    % ________    _______________    _____    _______   _______________     _______________
    % {'BOU'}     {1440×1 double}    40.14    -105.24   {1440×1 double}     {1440×1 double}
    % {'BSL'}     {1440×1 double}    30.35     -89.64   {1440×1 double}     {1440×1 double}
    % {'FRD'}     {1440×1 double}     38.2     -77.37   {1440×1 double}     {1440×1 double}
    % {'FRN'}     {1440×1 double}    37.09    -119.72   {1440×1 double}     {1440×1 double}
    % {'NEW'}     {1440×1 double}    48.27    -117.12   {1440×1 double}     {1440×1 double}

%combine all the values together
clear dat;
dat_dbn = [];
dat_dbe = [];
dat_dbh = [];
for i = 1:length(OBS.Stations)
    dat_dbn = [dat_dbn OBS(strcmp(OBS.Stations, OBS.Stations(i)), : ).data_dbn{1}];
    dat_dbe = [dat_dbe OBS(strcmp(OBS.Stations, OBS.Stations(i)), : ).data_dbe{1}];
    dat_dbh = [dat_dbh OBS(strcmp(OBS.Stations, OBS.Stations(i)), : ).data_dbh{1}];
end

%get the upper and lower bounds of the data
clear min;
clear max;
max = 1.4514e+03;
min = -2.9978e+03;
    %Use meshgrid to create a set of 2-D grid points in the longitude-latitude plane and then use griddata to interpolate the corresponding depth at those points:
[longi,lati] = meshgrid(min_long:1:max_long, min_lat:1:max_lat); % * 0.5 is the resolution, longitude then latitude
[longi,lati] = meshgrid(min_long:0.5:max_long, min_lat:0.5:max_lat); % * 0.5 is the resolution, longitude then latitude
% graph the data
s = shaperead('landareas.shp');
for t = 78: length(OBS.data_dbn{1})

%for idx = 1:length(DATES)
    %t = DATES{idx};
    disp(["Generating" t "..."]);
    dat_dbh_c = dat_dbh(t,:); % _c = current data for all stations
    dat_dbe_c = dat_dbe(t,:);
    dat_dbn_c = dat_dbn(t,:);
    v = variogram([OBS.long OBS.lat],dat_dbh_c');
    [~,~,~,vstruct] = variogramfit(v.distance,v.val,[],[],[],'model','stable');
    close;
    [OBSi,OBSVari] = krigingtest(vstruct,OBS.long',OBS.lat',dat_dbh_c,longi,lati);
    
    
  figure('Color','w', 'Position',[0 0 1280 720]);

    h=pcolor(longi,lati,OBSi); % * draw the points
    hold on
    set(h,'EdgeColor','none'); 
        
    % draw the stations diffferently
    for i = 1:length(LOC{2,t})
        if ~isempty(LOC{2,t}{i})
            if i/2 ~= floor(i/2)
                c = [0 0 0];
            else
                c = [1 1 1];
            end
            geoshow(LOC{2,t}{i},'Marker','o',...
            'MarkerFaceColor',c,'MarkerEdgeColor','k', 'MarkerSize', 5);
        end
    end

    for i = 1:length(LOC{1,t})
        if ~isempty(LOC{1,t}{i})
            c = [1 0 1];
            geoshow(LOC{1,t}{i},'Marker','d',...
            'MarkerFaceColor',c,'MarkerEdgeColor','k', 'MarkerSize', 5);
        end
    end
    
    mapshow(s,'FaceAlpha', 0);
    
    % colormap gray;
    xlabel('Longitude'), ylabel('Latitude');
    c = colorbar; 
    clim("manual");
    clim([min max]); % * colorbar range
    map =[0.382 0.0 0.382
0.386 0.0 0.387
0.389 0.0 0.393
0.393 0.0 0.398
0.397 0.0 0.404
0.401 0.0 0.409
0.404 0.0 0.415
0.408 0.0 0.42
0.411 0.0 0.426
0.415 0.0 0.431
0.418 0.0 0.436
0.421 0.0 0.442
0.425 0.0 0.447
0.428 0.0 0.452
0.431 0.0 0.458
0.434 0.0 0.463
0.437 0.0 0.468
0.44 0.0 0.474
0.443 0.0 0.479
0.445 0.0 0.484
0.448 0.0 0.489
0.451 0.0 0.495
0.453 0.0 0.5
0.456 0.0 0.505
0.459 0.0 0.51
0.461 0.0 0.515
0.463 0.0 0.521
0.466 0.0 0.526
0.468 0.0 0.531
0.47 0.0 0.536
0.472 0.0 0.541
0.474 0.0 0.546
0.476 0.0 0.551
0.478 0.0 0.556
0.48 0.0 0.561
0.482 0.0 0.566
0.484 0.0 0.571
0.486 0.0 0.577
0.487 0.0 0.582
0.489 0.0 0.587
0.491 0.0 0.592
0.492 0.0 0.596
0.494 0.0 0.601
0.495 0.0 0.606
0.496 0.0 0.611
0.498 0.0 0.616
0.499 0.0 0.621
0.5 0.0 0.626
0.501 0.0 0.631
0.502 0.0 0.636
0.503 0.0 0.641
0.504 0.0 0.646
0.505 0.0 0.651
0.506 0.0 0.656
0.507 0.0 0.66
0.508 0.0 0.665
0.509 0.0 0.67
0.509 0.0 0.675
0.51 0.0 0.68
0.51 0.0 0.685
0.511 0.0 0.689
0.511 0.0 0.694
0.512 0.0 0.699
0.512 0.0 0.704
0.512 0.0 0.708
0.512 0.0 0.713
0.513 0.0 0.718
0.513 0.0 0.723
0.513 0.0 0.727
0.513 0.0 0.732
0.513 0.0 0.737
0.513 0.0 0.742
0.512 0.0 0.746
0.512 0.0 0.751
0.512 0.0 0.756
0.512 0.0 0.76
0.511 0.0 0.765
0.511 0.0 0.77
0.51 0.0 0.774
0.51 0.0 0.779
0.509 0.0 0.784
0.509 0.0 0.788
0.508 0.0 0.793
0.507 0.0 0.798
0.506 0.0 0.802
0.506 0.0 0.807
0.505 0.0 0.812
0.504 0.0 0.816
0.503 0.0 0.821
0.502 0.0 0.825
0.5 0.0 0.83
0.499 0.0 0.835
0.498 0.0 0.839
0.497 0.0 0.844
0.495 0.0 0.848
0.494 0.0 0.853
0.492 0.0 0.857
0.491 0.0 0.862
0.489 0.0 0.866
0.488 0.0 0.871
0.486 0.0 0.875
0.484 0.0 0.88
0.482 0.0 0.885
0.481 0.0 0.889
0.479 0.0 0.894
0.477 0.0 0.898
0.475 0.0 0.903
0.473 0.0 0.907
0.47 0.0 0.911
0.468 0.0 0.916
0.466 0.0 0.92
0.464 0.0 0.925
0.461 0.0 0.929
0.459 0.0 0.934
0.456 0.0 0.938
0.454 0.0 0.943
0.451 0.0 0.947
0.449 0.0 0.952
0.446 0.0 0.956
0.443 0.0 0.96
0.44 0.0 0.965
0.437 0.0 0.969
0.434 0.0 0.974
0.431 0.0 0.978
0.428 0.0 0.982
0.425 0.0 0.987
0.422 0.0 0.991
0.419 0.0 0.996
0.385 0.0 1.0
0.384 0.0 1.0
0.383 0.0 1.0
0.382 0.0 1.0
0.38 0.0 1.0
0.379 0.0 1.0
0.378 0.0 1.0
0.376 0.0 1.0
0.375 0.0 1.0
0.373 0.0 1.0
0.372 0.0 1.0
0.37 0.0 1.0
0.368 0.0 1.0
0.367 0.0 1.0
0.365 0.0 1.0
0.363 0.0 1.0
0.361 0.0 1.0
0.359 0.0 1.0
0.357 0.0 1.0
0.354 0.0 1.0
0.352 0.0 1.0
0.35 0.0 1.0
0.347 0.0 1.0
0.345 0.0 1.0
0.342 0.0 1.0
0.339 0.0 1.0
0.337 0.0 1.0
0.334 0.0 1.0
0.331 0.0 1.0
0.327 0.0 1.0
0.324 0.0 1.0
0.321 0.0 1.0
0.317 0.0 1.0
0.313 0.0 1.0
0.31 0.0 1.0
0.306 0.0 1.0
0.301 0.0 1.0
0.297 0.0 1.0
0.293 0.0 1.0
0.288 0.0 1.0
0.283 0.0 1.0
0.278 0.0 1.0
0.273 0.0 1.0
0.268 0.0 1.0
0.262 0.0 1.0
0.256 0.0 1.0
0.25 0.0 1.0
0.244 0.0 1.0
0.237 0.0 1.0
0.23 0.0 1.0
0.223 0.0 1.0
0.216 0.0 1.0
0.208 0.0 1.0
0.2 0.0 1.0
0.192 0.0 1.0
0.183 0.0 1.0
0.174 0.0 1.0
0.164 0.0 1.0
0.154 0.0 1.0
0.143 0.0 1.0
0.132 0.0 1.0
0.121 0.0 1.0
0.108 0.0 1.0
0.095 0.0 1.0
0.081 0.0 1.0
0.066 0.0 1.0
0.049 0.0 1.0
0.03 0.0 1.0
0.006 0.0 1.0
0.0 0.028 1.0
0.0 0.052 1.0
0.0 0.075 1.0
0.0 0.096 1.0
0.0 0.117 1.0
0.0 0.138 1.0
0.0 0.158 1.0
0.0 0.179 1.0
0.0 0.199 1.0
0.0 0.219 1.0
0.0 0.24 1.0
0.0 0.26 1.0
0.0 0.281 1.0
0.0 0.302 1.0
0.0 0.323 1.0
0.0 0.344 1.0
0.0 0.365 1.0
0.0 0.387 1.0
0.0 0.408 1.0
0.0 0.43 1.0
0.0 0.453 1.0
0.0 0.475 1.0
0.0 0.498 1.0
0.0 0.52 1.0
0.0 0.544 1.0
0.0 0.567 1.0
0.0 0.59 1.0
0.0 0.614 1.0
0.0 0.638 1.0
0.0 0.663 1.0
0.0 0.687 1.0
0.0 0.712 1.0
0.0 0.737 1.0
0.0 0.762 1.0
0.0 0.787 1.0
0.0 0.813 1.0
0.0 0.838 1.0
0.0 0.864 1.0
0.0 0.89 1.0
0.0 0.917 1.0
0.0 0.943 1.0
0.0 0.97 1.0
0.0 0.996 1.0
0.0 1.0 0.942
0.0 1.0 0.872
0.0 1.0 0.801
0.0 1.0 0.727
0.0 1.0 0.65
0.0 1.0 0.571
0.0 1.0 0.488
0.0 1.0 0.401
0.0 1.0 0.308
0.0 1.0 0.206
0.0 1.0 0.089
0.029 1.0 0.0
0.073 1.0 0.0
0.111 1.0 0.0
0.146 1.0 0.0
0.179 1.0 0.0
0.211 1.0 0.0
0.241 1.0 0.0
0.271 1.0 0.0
0.299 1.0 0.0
0.327 1.0 0.0
0.355 1.0 0.0
0.381 1.0 0.0
0.407 1.0 0.0
0.433 1.0 0.0
0.458 1.0 0.0
0.483 1.0 0.0
0.507 1.0 0.0
0.53 1.0 0.0
0.554 1.0 0.0
0.576 1.0 0.0
0.599 1.0 0.0
0.621 1.0 0.0
0.642 1.0 0.0
0.663 1.0 0.0
0.684 1.0 0.0
0.704 1.0 0.0
0.724 1.0 0.0
0.744 1.0 0.0
0.763 1.0 0.0
0.781 1.0 0.0
0.8 1.0 0.0
0.817 1.0 0.0
0.835 1.0 0.0
0.852 1.0 0.0
0.869 1.0 0.0
0.885 1.0 0.0
0.901 1.0 0.0
0.917 1.0 0.0
0.932 1.0 0.0
0.947 1.0 0.0
0.962 1.0 0.0
0.976 1.0 0.0
0.99 1.0 0.0
1.0 0.996 0.0
1.0 0.982 0.0
1.0 0.968 0.0
1.0 0.954 0.0
1.0 0.941 0.0
1.0 0.928 0.0
1.0 0.915 0.0
1.0 0.902 0.0
1.0 0.89 0.0
1.0 0.878 0.0
1.0 0.866 0.0
1.0 0.854 0.0
1.0 0.843 0.0
1.0 0.832 0.0
1.0 0.821 0.0
1.0 0.811 0.0
1.0 0.8 0.0
1.0 0.79 0.0
1.0 0.78 0.0
1.0 0.771 0.0
1.0 0.762 0.0
1.0 0.753 0.0
1.0 0.744 0.0
1.0 0.735 0.0
1.0 0.727 0.0
1.0 0.719 0.0
1.0 0.711 0.0
1.0 0.703 0.0
1.0 0.695 0.0
1.0 0.688 0.0
1.0 0.681 0.0
1.0 0.674 0.0
1.0 0.667 0.0
1.0 0.661 0.0
1.0 0.655 0.0
1.0 0.649 0.0
1.0 0.643 0.0
1.0 0.637 0.0
1.0 0.631 0.0
1.0 0.626 0.0
1.0 0.62 0.0
1.0 0.615 0.0
1.0 0.61 0.0
1.0 0.606 0.0
1.0 0.601 0.0
1.0 0.596 0.0
1.0 0.592 0.0
1.0 0.588 0.0
1.0 0.584 0.0
1.0 0.58 0.0
1.0 0.576 0.0
1.0 0.572 0.0
1.0 0.568 0.0
1.0 0.565 0.0
1.0 0.562 0.0
1.0 0.558 0.0
1.0 0.555 0.0
1.0 0.552 0.0
1.0 0.549 0.0
1.0 0.546 0.0
1.0 0.543 0.0
1.0 0.541 0.0
1.0 0.538 0.0
1.0 0.536 0.0
1.0 0.533 0.0
1.0 0.531 0.0
1.0 0.529 0.0
1.0 0.526 0.0
1.0 0.524 0.0
1.0 0.522 0.0
1.0 0.52 0.0
1.0 0.518 0.0
1.0 0.517 0.0
1.0 0.515 0.0
1.0 0.513 0.0
1.0 0.511 0.0
1.0 0.51 0.0
1.0 0.508 0.0
1.0 0.507 0.0
1.0 0.505 0.0
1.0 0.504 0.0
1.0 0.502 0.0
1.0 0.501 0.0
1.0 0.5 0.0
1.0 0.499 0.0
1.0 0.498 0.0
1.0 0.496 0.0
1.0 0.495 0.0
1.0 0.494 0.0
1.0 0.493 0.0
];
    colormap(map);
    %colormap(parula(24));
    %colormap(jet(16));
    set(gca,'ColorScale','linear')
    c.Label.String = "Variation (nT)";
    c.Label.FontSize = 12;
    
    if t+TIME-1 <= 1440
        date_label =  '20031029 minute ';
        minute_time = t+TIME-1;
    else
        date_label =  '20031030 minute ';
        minute_time = t+TIME-1-1440;
    end
    hour = num2str(fix(minute_time/60));
    if strlength(hour) == 1
        hour = ['0' hour];
    end

    minute = num2str(mod(minute_time, 60));
    if strlength(minute) == 1
        minute = ['0' minute];
    end
    if t-16 < 1 
        Bz_now = 0; 
        By_now = 0; 
    else 
        Bz_now = Bz(t-16); 
        By_now = By(t-16);
    end

    str_title=['UTC ' hour ':' minute ' IMF By: ' num2str(round(By_now,1)) ' Bz: ' num2str(round(Bz_now,1)) ];

    title(str_title);
    annotation('textbox',...
        [0.82 0.066 0.077 0.052],... % * position of the text box
        'String',{'nT'},...
        'FontSize',12,...
        'FontName','Arial',...
        'FitBoxToText','off',...
        'LineStyle','none');
    xlim([min_long max_long-1]); % * longitude range
    ylim([min_lat max_lat-1]); % * latitude range
    x0=10;
    y0=10;
    width=1800/3; %600
    height=1200/3; %400
    set(gcf,'position',[x0,y0,width,height]);
    saveas(gcf,['temp6\',date_label,num2str(minute_time),'.png'], 'png');
end