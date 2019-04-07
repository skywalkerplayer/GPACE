function [u,v]=GetAnnualHori(year)
global ThisdataPri;
% global ThisdataSec;
GPS=YearExtract(ThisdataPri,year,'xyz');
[~,mx]=max(GPS.z);
[~,mn]=min(GPS.z);
u=GPS.x(mn)-GPS.x(mx);
v=GPS.y(mn)-GPS.y(mx);