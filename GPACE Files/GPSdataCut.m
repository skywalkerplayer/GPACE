function returner=GPSdataCut(data,index,direction)
if direction==0
    returner.stationame=data.stationame;
    returner.decimalyear=data.decimalyear(1:index);
    returner.x=data.x(1:index);
    returner.y=data.y(1:index);
    returner.z=data.z(1:index);
    returner.deltax=data.deltax(1:index);
    returner.deltay=data.deltay(1:index);
    returner.deltaz=data.deltaz(1:index);
    returner.sigmax=data.sigmax(1:index);
    returner.sigmay=data.sigmay(1:index);
    returner.sigmaz=data.sigmaz(1:index);
else if direction==1        
    returner.stationame=data.stationame;
    endindex=length(data.decimalyear);
    returner.decimalyear=data.decimalyear(index+1:endindex);
    returner.x=data.x(index+1:endindex);
    returner.y=data.y(index+1:endindex);
    returner.z=data.z(index+1:endindex);
    returner.deltax=data.deltax(index+1:endindex);
    returner.deltay=data.deltay(index+1:endindex);
    returner.deltaz=data.deltaz(index+1:endindex);
    returner.sigmax=data.sigmax(index+1:endindex);
    returner.sigmay=data.sigmay(index+1:endindex);
    returner.sigmaz=data.sigmaz(index+1:endindex);
    end
end