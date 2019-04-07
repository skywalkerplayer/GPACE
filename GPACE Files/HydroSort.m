function returner=HydroSort(year,LatMax,LatMin,LonMax,LonMin)
global water;
Ifstart=0;
LatMin=floor(LatMin-0.5)+0.5;
LonMin=floor(LonMin-0.5)+0.5;
LatMax=ceil(LatMax-0.5)+0.5;
LonMax=ceil(LonMax-0.5)+0.5;
if year==0
    for i=1:1:length(water.time)        
        if Ifstart==0
            temp.LWE=water.LWE(:,:,i);
            Ifstart=1;
        else
            temp.LWE=temp.LWE+water.LWE(:,:,i);
        end
    end
else
    for i=1:1:length(water.time)
        if water.time(i)>year
            if floor(water.time(i))<=year
                if Ifstart==0
                    temp.LWE=water.LWE(:,:,i);
                    Ifstart=1;
                else
                    temp.LWE=temp.LWE+water.LWE(:,:,i);
                end
            end
        end
    end
end
% LatRange=LatMax-LatMin+1;
% LonRange=LonMax-LonMin+1;
% LatMinPos=LatMin+90.5;
% LonMinPos=LonMin+0.5;

% for i=1:1:LatRange
%     for j=1:1:LonRange
%         returner((i-1)*LonRange+j,2)=i+LatMin-1;
%         if j+LonMin-1<180
%             returner((i-1)*LonRange+j,1)=j+LonMin-1;
%         else            
%             returner((i-1)*LonRange+j,1)=j+LonMin-1-360;
%         end
%         returner((i-1)*LonRange+j,3)=temp.LWE(j+LonMinPos-1,i+LatMinPos-1);
%     end
% end
     
LatRange=length(water.lat);
LonRange=length(water.lon);
returner=ones(LatRange*LonRange,3);

for i=1:1:LatRange
    for j=1:1:LonRange
        returner((i-1)*LonRange+j,2)=water.lat(i);
        returner((i-1)*LonRange+j,1)=water.lon(j);
        returner((i-1)*LonRange+j,3)=temp.LWE(j,i);
    end
end