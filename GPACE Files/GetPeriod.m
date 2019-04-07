function chosenperiod=GetPeriod(GPSData,GPSelement,startime,endtime)
%Temporarily modified for Spacial Modeling presentation. Needs work.
switch GPSelement
    case 'z'
        trace=detrend(GPSData.z);
%         trace=GPSData.deltaz;
end
i=1;
j=1;
selected=0;
while GPSData.decimalyear(i)<endtime
    if GPSData.decimalyear(i)>startime
        selected(j)=trace(i);
        j=j+1;
        i=i+1;
    else
         i=i+1;
    end
end
chosenperiod=selected;
return;