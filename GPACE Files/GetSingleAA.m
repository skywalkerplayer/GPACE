function [PAA,SAA,WAA]=GetSingleAA(Innumber)
%Gives Annual max amplitude-mean of all datasets in one year

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
ThisWater=StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water);
[ThisGPS,~]=GWDandM(datas{number},ThisWater);
Pzmean=mean(ThisGPS.z);
Szmean=mean(ThisdataSec.z);
Whmean=mean(ThisWater.LWE);
start=ceil(ThisGPS.decimalyear(1));
stop=floor(ThisGPS.decimalyear(end))-1;
YearNumber=stop-start+1;
PAA.Ampl=ones(YearNumber,1);
PAA.year=ones(YearNumber,1);
SAA.Ampl=ones(YearNumber,1);
SAA.year=ones(YearNumber,1);
WAA.Ampl=ones(YearNumber,1);
WAA.year=ones(YearNumber,1);
for i=1:1:YearNumber
    ThisPz=YearExtract(ThisGPS,start+i-1,'z');
    PAA.Ampl(i)=max(ThisPz.z)-Pzmean;
    PAA.year(i)=start+i-1;
    ThisSz=YearExtract(ThisdataSec,start+i-1,'z');
    SAA.Ampl(i)=max(ThisSz.z)-Szmean;
    SAA.year(i)=start+i-1;
    ThisWh=YearExtract(ThisWater,start+i-1,'h');
    WAA.Ampl(i)=max(ThisWh.LWE)-Whmean;
    WAA.year(i)=start+i-1;
end
% PAA.Ampl=PAA.Ampl/max(abs(PAA.Ampl));
% SAA.Ampl=SAA.Ampl/max(abs(SAA.Ampl));
% WAA.Ampl=WAA.Ampl/max(abs(WAA.Ampl));
