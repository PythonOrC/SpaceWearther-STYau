time=1260; % * which second to generate frame
latTUC =  32.17; lonTUC =   -110.73;   
% OBStion Id: TUC
% Location: Tucson, AZ
% Latitude: 32.17?N
% Longitude: 110.73?W
latFRN = 37.09; lonFRN = -119.72;
% Station Id: FRN
% Location: O'Neals, CA
% Latitude: 37.09?N
% Longitude: 119.72?W
latBOU = 40.14; lonBOU = -105.24;
% Station Id: BOU
% Location: Boulder, CO
% Latitude: 40.14?N
% Longitude: 105.24?W
latNEW = 48.27; lonNEW = -117.12;
% Station Id: NEWmaps
% Location: Colville National Forest, WA
% Latitude: 48.27?N
% Longitude: 117.12?W
latFRD = 38.20; lonFRD = -77.37;
% Station Id: FRD
% Location: Corbin, VA
% Latitude: 38.20?N
% Longitude: 77.37?W
latBSL = 30.35; lonBSL = -89.63;
% Station Id: BSL
% Location: NASA Stennis Space Center, MS
% Latitude: 30.35?N
% Longitude: 89.63?W
latSJG = 18.11; lonSJG = -66.15;
% Station Id: SJG
% Location: Cayey, PR
% Latitude: 18.11?N
% Longitude: 66.15?W
latHON = 21.32; lonHON = -158.00;
% Station Id: HON
% Location: Ewa Beach, HI
% Latitude: 21.32?N
% Longitude: 158.00?W
latSIT = 57.06; lonSIT = -135.33;
% Station Id: SIT
% Location: Sitka, AK
% Latitude: 57.06?N
% Longitude: 135.33?W
latSHU = 55.35; lonSHU = -160.46;
% Station Id: SHU
% Location: Sand Point, Popof, AK
% Latitude: 55.35?N
% Longitude: 160.46?W
latGUA = 13.59; lonGUA = 35.13;
%latGUA = 13.59; lonGUA = -215.13;
% Station Id: GUA
% Location: Dededo, Guam
% Latitude: 13.59?N
% Longitude: 215.13?W=35.13?E
latBRW = 71.32; lonBRW = -156.62;
% Station Id: BRW
% Location: Point Barrow, AK
% Latitude: 71.32?N
% Longitude: 156.62?W
latCMO = 64.87; lonCMO = -147.86;
% Station Id: CMO
% Location: Fairbanks, AK
% Latitude: 64.8741?N
% Longitude: 147.8597?W

% latDED = 70.36; lonDED = -148.79;
% Station Id: DED
% Location: Deadhorse, AK
% Latitude: 70.36?N
% Longitude: 148.79?W

%Geometry (in this case 'Point') 
%Lat (for points, this is a scalar double)
%Lon (for points, this is a scalar double)

filename = "6_station_dbn_abridged.csv";
delimiter = ",";
dat = readtable("6_station_dbn_abridged.csv", "Delimiter",delimiter, "DatetimeType","datetime");
meta = readtable("supermag-6-stations.csv", "Delimiter",delimiter, "DatetimeType","datetime");
[Stations,IA,IC] = unique(dat.Station);
lat = meta.GEOLAT(1:length(Stations), 1);
long = meta.GEOLON(1:length(Stations), 1);

for i = 1:length(lat)
    if lat(i) > 180
        lat(i) = lat(i) - 360;
    end
    if long(i) > 180
        long(i) = long(i) - 360;
    end
end

data = {};

for i = 1:length(Stations)
    %datS = dat(dat.Station == string(Stations{i}),:);
    datS = meta(meta.IAGA == string(Stations{i}),:);
    disp(meta.dbn_nez);
    data = [data; meta.dbn_nez];
    %dat4 = datS{:,4};
    %dat5 = datS{:,5};
    %dat6 = datS{:,6};
    %data = [data; dat4+dat5+dat6];
end
all = table(Stations, data);
clear OBS;
[OBS(1:length(Stations)).Geometry] = deal('Point');
for i = 1:length(lat)
    OBS(i).Lat = lat(i);
    OBS(i).Lon = long(i);
    OBS(i).Name = string(Stations(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=time:time+60
    pc5 = [];
    for i = 1:length(Stations)
        pc5 = [pc5 all(strcmp(all.Stations, Stations(i)), : ).data{1}(n)];
    end
    %Use meshgrid to create a set of 2-D grid points in the longitude-latitude plane and then use griddata to interpolate the corresponding depth at those points:
    [longi,lati] = meshgrid(-127:0.5:-66, 25:0.5:50); % * 0.5 is the resolution, longitude then latitude
    v = variogram([long lat],pc5');
    [~,~,~,vstruct] = variogramfit(v.distance,v.val,[],[],[],'model','stable');
    close;
    [pc5i,pc5Vari] = krigingtest(vstruct,long',lat',pc5,longi,lati);
    
    % % plot USA map with province
    % s = shaperead('physio_Dissolve_province.shp'); % * any .shp file would do 
    % figure('Color','w'); 
    % mapshow(s);  % * draw the map
    
    % PUT OBS ON THE MAP
    %mapshow(OBS(1:6),'Marker','o',...
     %   'MarkerFaceColor','c','MarkerEdgeColor','k'); % * draw the observatories
    % Display the OBS names using data in the geostruct field Name.
    % Note that you must treat the Name field as a cell array.
    text([OBS.Lon]-1,[OBS.Lat]+0.7,...
        {OBS.Name},'FontWeight','bold');
    hold on
    
    %Put pc5 on the map
    h=pcolor(longi,lati,pc5i); % * draw the points
    set(h,'EdgeColor','none'); 
    xlabel('Longitude'), ylabel('Latitude'), colorbar; 
    %disp(dat.Data_D1);
    % [min, max] = bounds(dat.Data_D1');
    % [min, max] = bounds([dat.Data_D2' max min]);
    % [min, max] = bounds([dat.Data_D3' max min]);
    % max = round(max);
    % min = round(min);
    min = -600;
    max = 800;
    clim([min max]) % * colorbar range
    str_title2=['pc5 BOU9 KRGMaps 1.0 2008068 second-',num2str(n)];
    title(str_title2);
    annotation('textbox',...
        [0.84 0.76 0.077 0.052],... % * position of the text box
        'String',{'nT'},...
        'FontSize',12,...
        'FontName','Arial',...
        'FitBoxToText','off',...
        'LineStyle','none');
    xlim([-127 -66]); % * longitude range
    ylim([25 50]); % * latitude range
    saveas(gcf,['D:\Github Repository\SpaceWeather\matlab\examples\draftFigure\',num2str(n),'.png'], 'png')

end



%%%%%%%%%%%%%
