function returner=DataRead(fileID)
%Just for temporary load, need to be rewritten later.
TypeMarker=fscanf(fileID,'%c',6);
if strcmp(TypeMarker,'gpdZhu')
    returner.total=fread(fileID,1,'int16');
    returner.OriginalPath=fscanf(fileID,'%c',100);
    returner.IfSec=fread(fileID,1,'int8');
    returner.SecPath=fscanf(fileID,'%c',100);
    returner.IfFiltered=fread(fileID,1,'int8');
    resthead=fread(fileID,186,'char');%Should be load file informations. Refer to DataWrite.m and File format description.txt
    hwait=waitbar(0,'Reading...');
    for i=1:1:returner.total
        waitbar(i/returner.total,hwait,'Reading...');        
        returner.datas(i)=SingleStationRead(fileID);
    end
    close(hwait);
else
    msgbox('Not GPS Dataset!');
end