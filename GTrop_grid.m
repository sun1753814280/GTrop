
function [zhd,zwd,tm] = GTrop_grid(h,year,doy,a)

% This function is used to calcualte tropospheric parameters at a grid
% point

Tr = year + doy/365.25 - 1980;
C1 = cos(doy*2*pi/365.25);
S1 = sin(doy*2*pi/365.25);
C2 = cos(doy*4*pi/365.25);
S2 = sin(doy*4*pi/365.25);

% Get the ZHD, ZWD, and Tm at the reference level and their lapse rates

zhd0 = a(1)*Tr + a(2) + a(3)*C1 + a(4)*S1 + a(5)*C2 + a(6)*S2;
zwd0 = a(7)*Tr + a(8) + a(9)*C1 + a(10)*S1 + a(11)*C2 + a(12)*S2;
tm0  = a(13)*Tr + a(14) + a(15)*C1 + a(16)*S1 + a(17)*C2 + a(18)*S2;
zhdh = a(19)*Tr + a(20) + a(21)*C1 + a(22)*S1 + a(23)*C2 + a(24)*S2;
zwdh = a(25)*Tr + a(26) + a(27)*C1 + a(28)*S1 + a(29)*C2 + a(30)*S2;
tmh  = a(31)*Tr + a(32) + a(33)*C1 + a(34)*S1 + a(35)*C2 + a(36)*S2;
h0   = a(37);

% Height correction

zhd = zhd0*(1 - zhdh*(h - h0))^5.225;
zwd = zwd0*(1 - zwdh*(h - h0))^5.225;
tm  = tm0 - tmh*(h - h0);
