function [PF,SF,WF]=GetSingleFreq(Innumber,IfNormalize)
global datas;
global StationCoor;
global water;
global ThisdataSec;
global number;
number=Innumber;
ReadThisSec();    
k=1;
while strcmp(datas{number}.stationame,StationCoor.textdata{k})==0
    k=k+1;
end
%     ThisGPSz=datas{number}.z-datas{number}.z(1);
[ThisGPS,~]=GWDandM(datas{number},StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water));
% ThisGPS=datas{number};
% ThisGPSz=datas{number}.z;
ThisGPSz=ThisGPS.z-ThisGPS.z(1);
ThisGPSz=ThisGPSz/max(abs(ThisGPSz));
[PF.Ampl,PF.Freq]=freqz(ThisGPSz);
PF.Freq=PF.Freq/(2*pi*(1/12));
% PF.Freq=PF.Freq/(2*pi*0.00274658202999944);
ThisGRACEz=ThisdataSec.z-ThisdataSec.z(1);
ThisGRACEz=ThisGRACEz/max(abs(ThisGRACEz));
[SF.Ampl,SF.Freq]=freqz(ThisGRACEz);
SF.Freq=SF.Freq/(2*pi*(1/12));
ThisWater=StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water);
ThisWater.LWE=ThisWater.LWE-ThisWater.LWE(1);
ThisWater.LWE=ThisWater.LWE/max(abs(ThisWater.LWE));
[WF.Ampl,WF.Freq]=freqz(ThisWater.LWE);
WF.Freq=WF.Freq/(2*pi*(1/12));
PF.Ampl=abs(PF.Ampl);
SF.Ampl=abs(SF.Ampl);
WF.Ampl=abs(WF.Ampl);
if IfNormalize==1
    PF.Ampl=PF.Ampl/max(PF.Ampl);
    SF.Ampl=SF.Ampl/max(SF.Ampl);
    WF.Ampl=WF.Ampl/max(WF.Ampl);
end