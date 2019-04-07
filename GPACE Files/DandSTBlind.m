function returner=DandSTBlind(GPSData,interval) 
%Unit of interval is year.

%Need to be fulfilled
if interval==-1
    returner=DandSTBlind(GPSData,0.08+1/300);
else
    returner.stationame=GPSData.stationame;
%     DataNumber=floor((GPSData.decimalyear(end)-GPSData.decimalyear(1))/interval);
    i=1;
    j=1;
    k=1;
    while(GPSData.decimalyear(k)<GPSData.decimalyear(end)-interval)
        while(GPSData.decimalyear(k)-GPSData.decimalyear(j)<interval)
            k=k+1;
        end
        j=k;
        returner.decimalyear(i)=mean(GPSData.decimalyear(j:k));
        returner.x(i)=mean(GPSData.x(j:k));
        returner.y(i)=mean(GPSData.y(j:k));
        returner.z(i)=mean(GPSData.z(j:k));
        i=i+1;
    end
    i=i+1;
    returner.decimalyear(i)=mean(GPSData.decimalyear(j:end));
    returner.x(i)=mean(GPSData.x(j:end));
    returner.y(i)=mean(GPSData.y(j:end));
    returner.z(i)=mean(GPSData.z(j:end));
end
