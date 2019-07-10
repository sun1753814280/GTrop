
% load the model coefficients
load('coefficient.mat');

% -------------------------------------------------------

% The size of the coefficients 181*361*37, The first two dimensions represent 
% the latitude and the longitude, respectively, and the third dimension stores
% the model coefficients and the reference height at each grid point
% 
% For the third dimension:
% 
% 1-6   model coefficients of ZHD
% 7-12  model coefficients of ZWD
% 13-18 model coeffiicents of Tm
% 19-24 model coefficients of ZHD lapse rate
% 25-30 model coefficients of ZWD lapse rate
% 31-36 model coefficients of Tm lapse rate
% 37    height of grid point unit: km

% -------------------------------------------------------

% This is an example
lat  = 24.4333; % unit: degree
lon  = 54.6500; % unit: degree
h    = 1.1809;  % unit: km
year = 2018;    % 
doy  = 1;       %

% Use the GTrop model
[zhd,zwd,tm] = GTrop(lat,lon,h,year,doy,coefficient);

% Output the results
disp(['ZHD is ',num2str(zhd),' mm']);
disp(['ZWD is ',num2str(zwd),' mm']);
disp(['Tm is ',num2str(tm),' K']);
