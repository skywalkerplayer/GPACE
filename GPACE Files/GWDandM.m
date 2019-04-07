function [DMGPS,DMwater]=GWDandM(GPS,water)
GPS.z=detrend(GPS.z);
[DMGPS,DMwater]=GWStackTime(GPS,water);