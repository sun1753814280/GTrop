
function [zhd,zwd,tm] = GTrop(lat,lon,h,year,doy,coefficient)

% -----------------------------------------------------------------

% input parameters:
% 
% lat :  ellipsoid latitude in degree [-90:90] (scalar)
% lon :  longitude in degree [-180:180] (scalar)
% h   :  ellipsoidal height in km (scalar)
% year:  year (scalar)
% doy :  day of year (scalar)
% 
% output parameters:
% 
% zhd :   zenith hydrostatic delay in mm (scalar) 
% zwd :   zenith wet delay in mm (scalar)
% tm  :   weighted mean temperature in K (scalar

% -----------------------------------------------------------------

% Obtain the longitudes and latitudes of the four grid points closet to the
% GNSS receiver
B1 = floor(lat);
B2 = ceil(lat);
L1 = floor(lon);
L2 = ceil(lon);

B = lat;
L = lon;

% The case where the GNSS receiver is at the grid point

if B1==B2&&L1==L2
    
    i            = B1 + 91;
    j            = L1 + 181;
    a(1,:)       = coefficient(i,j,:);
    [zhd,zwd,tm] = GTrop_grid(h,year,doy,a);

% The case where the latitude of the GNSS receiver and that of the grid point
% are the same
    
elseif B1==B2
    
    i               = B1 + 91;
    j               = L1 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd1,zwd1,tm1] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------
    
    i               = B1 + 91;
    j               = L2 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd2,zwd2,tm2] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------
    
    % Linear interpolation along the longitude direction
    
    zhd = ((L2-L)*zhd1+(L-L1)*zhd2)/(L2-L1);    
    zwd = ((L2-L)*zwd1+(L-L1)*zwd2)/(L2-L1);    
    tm  = ((L2-L)*tm1+(L-L1)*tm2)/(L2-L1);    
   
% The case where the longitude of the GNSS receiver and that of the grid point
% are the same
    
elseif L1==L2
   
    i               = B1 + 91;
    j               = L1 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd1,zwd1,tm1] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------
    
    i               = B2 + 91;
    j               = L1 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd2,zwd2,tm2] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------
    
    % Linear interpolation along the latitude direction
    zhd = ((B2-B)*zhd1+(B-B1)*zhd2)/(B2-B1);    
    zwd = ((B2-B)*zwd1+(B-B1)*zwd2)/(B2-B1);    
    tm  = ((B2-B)*tm1+(B-B1)*tm2)/(B2-B1); 

       
% The case where the GNSS receiver is no at the grid point
    
else
   
    i               = B1 + 91;
    j               = L1 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd1,zwd1,tm1] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------

    i               = B1 + 91;
    j               = L2 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd2,zwd2,tm2] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------------
    
    i               = B2 + 91;
    j               = L1 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd3,zwd3,tm3] = GTrop_grid(h,year,doy,a);
    
    % ----------------------------------------------------------
    
    i               = B2 + 91;
    j               = L2 + 181;
    a(1,:)          = coefficient(i,j,:);
    [zhd4,zwd4,tm4] = GTrop_grid(h,year,doy,a);
    
    % ---------------------------------------------------------------------
    
    %Bilinear interpolation along the latitude and longitude directions
    
    zhd = ((B2-B)*(L2-L)*zhd1+(B-B1)*(L-L1)*zhd4+(B-B1)*(L2-L)*zhd3+(B2-B)*(L-L1)*zhd2)/((B2-B1)*(L2-L1));   
    zwd = ((B2-B)*(L2-L)*zwd1+(B-B1)*(L-L1)*zwd4+(B-B1)*(L2-L)*zwd3+(B2-B)*(L-L1)*zwd2)/((B2-B1)*(L2-L1));    
    tm  = ((B2-B)*(L2-L)*tm1+(B-B1)*(L-L1)*tm4+(B-B1)*(L2-L)*tm3+(B2-B)*(L-L1)*tm2)/((B2-B1)*(L2-L1));    
    
end


