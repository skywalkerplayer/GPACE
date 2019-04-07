function returner=GRACEncFileRead(filename)
returner.lat=ncread(filename,'lat');
returner.lon=ncread(filename,'lon');
returner.time=ncread(filename,'time');
returner.TimeBounds=ncread(filename,'time_bounds');
returner.LWE=ncread(filename,'lwe_thickness');
for i=1:1:length(returner.time)
    returner.time(i)=returner.time(i)/365+2002;
end
for i=1:1:length(returner.time)
    returner.TimeBounds(1,i)=returner.TimeBounds(1,i)/365+2002;
    returner.TimeBounds(2,i)=returner.TimeBounds(2,i)/365+2002;
end