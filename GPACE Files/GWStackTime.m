function [StackedGPS,StackedWater]=GWStackTime(GPS,water)
% global IfFiltered;
[SPG,EPG,SPW,EPW]=CommonTimeFind(GPS.decimalyear,water.time);

point=ones(EPW-SPW+1,1);
plength=1;

%Find corresponding closest point
for i=SPW:1:EPW     
    if i==SPW
        point(plength)=SPG;
        plength=plength+1;
    else if i==EPW
            point(plength)=EPG;
        else
            while(GPS.decimalyear(point(plength))<water.time(i))
                point(plength)=point(plength)+1;
            end
            plength=plength+1;
        end
    end
end
% plength=plength-1;

%Find the midpoint between two corresponding points
midpoint=zeros(plength);
for i=1:1:plength-1
    midpoint(i)=ceil((point(i)+point(i+1))/2);
end

StackedWater.time=water.time(SPW:EPW);
StackedWater.LWE=water.LWE(SPW:EPW);

% if IfFiltered==0    
    StackedGPS.decimalyear=StackedWater.time;
    StackedGPS.x=StackedWater.LWE;
    StackedGPS.y=StackedWater.LWE;
    StackedGPS.z=StackedWater.LWE;
    StackedGPS.x(1)=mean(GPS.x(SPG:midpoint(1)));
    StackedGPS.x(plength)=mean(GPS.x(midpoint(plength-1):EPG));
    StackedGPS.y(1)=mean(GPS.y(SPG:midpoint(1)));
    StackedGPS.y(plength)=mean(GPS.y(midpoint(plength-1):EPG));
    StackedGPS.z(1)=mean(GPS.z(SPG:midpoint(1)));
    StackedGPS.z(plength)=mean(GPS.z(midpoint(plength-1):EPG));
    for i=2:1:plength-1    
        StackedGPS.x(i)=mean(GPS.x(midpoint(i-1):midpoint(i)));
        StackedGPS.y(i)=mean(GPS.y(midpoint(i-1):midpoint(i)));
        StackedGPS.z(i)=mean(GPS.z(midpoint(i-1):midpoint(i)));
    end
% else 
%     StackedGPS.x=GPS.x;
%     StackedGPS.y=GPS.y;
%     StackedGPS.z=GPS.z;
%     StackedGPS.decimalyear=GPS.decimalyear;
% end
    