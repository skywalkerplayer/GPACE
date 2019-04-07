function [DMGPS,DMModel]=GMDandM(GPS,Model)
%This function suggests that GPS data is already detrended and stacked with
%GRACE or hydrology data.

%Match time
[SPG,EPG,SPM,EPM]=CommonTimeFind(GPS.decimalyear,Model.time);

%Find corresponding closest point
plength=1;
point=ones(EPG-SPG+1,1);
for i=SPG:1:EPG     
    if i==SPG
        point(plength)=SPM;
        plength=plength+1;
    else if i==EPG
            point(plength)=EPM;
        else
            while(Model.time(point(plength))<GPS.decimalyear(i))
                point(plength)=point(plength)+1;
            end
            plength=plength+1;
        end
    end
    point(plength)=point(plength-1)+1;
end

%Find the midpoint between two corresponding points
midpoint=zeros(plength);
for i=1:1:plength-1
    midpoint(i)=ceil((point(i)+point(i+1))/2);
end

DMGPS.decimalyear=GPS.decimalyear(SPG:EPG);
DMGPS.x=GPS.x(SPG:EPG);
DMGPS.y=GPS.y(SPG:EPG);
DMGPS.z=GPS.z(SPG:EPG);
DMModel.time=DMGPS.decimalyear;
DMModel.duEW=DMGPS.x;
DMModel.duNS=DMGPS.y;
DMModel.duV=DMGPS.z;
DMModel.duEW(1)=Model.duEW(1);
DMModel.duNS(1)=Model.duNS(1);
DMModel.duV(1)=Model.duV(1);
for i=2:1:plength-1
    DMModel.duEW(i)=mean(Model.duEW(midpoint(i-1):midpoint(i)));
    DMModel.duNS(i)=mean(Model.duNS(midpoint(i-1):midpoint(i)));
    DMModel.duV(i)=mean(Model.duV(midpoint(i-1):midpoint(i)));
end
DMModel.duEW(plength)=mean(Model.duEW(midpoint(plength-1):EPM));
DMModel.duNS(plength)=mean(Model.duNS(midpoint(plength-1):EPM));
DMModel.duV(plength)=mean(Model.duV(midpoint(plength-1):EPM));