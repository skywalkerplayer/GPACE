function returner=DataWrite(fileID,dataset)
%dataset includes total,OriginalPath,ifSec,SecPath
returner=1;%Should be modified to a success marker.
fwrite(fileID,'gpdZhu','char');
fwrite(fileID,dataset.total,'int16');
% blankfill(fileID,390);
%Should put other informations in later.

fwrite(fileID,dataset.OriginalPath,'char');
blankfill(fileID,100-length(dataset.OriginalPath));
% for i=1:1:100-length(dataset.OriginalPath)
%     fwrite(fileID,' ','char');
% end
fwrite(fileID,dataset.IfSec,'int8');
if dataset.IfSec==1
    fwrite(fileID,dataset.SecPath{1},'char');
    fprintf(fileID,'%c%c',' ',' ');
    if isempty(dataset.SecPath{2})==1
        dataset.SecPath{2}='\\';
    end
    fwrite(fileID,dataset.SecPath{2},'char');
    fprintf(fileID,'%c%c',' ',' ');
    fwrite(fileID,dataset.SecPath{3},'char');
    fprintf(fileID,'%c%c',' ',' ');
    blankfill(fileID,100-(length(dataset.SecPath{1})+length(dataset.SecPath{2})+length(dataset.SecPath{3})+6));
else
    fwrite(fileID,'Null','char');
    blankfill(fileID,100-length('Null'))
end
fwrite(fileID,dataset.IfFiltered,'int8');
% blankfill(fileID,87);
% fwrite(fileID,dataset.IfDirac,'int8');
% fwrite(fileID,dataset.IfShift,'int8');
% fwrite(fileID,dataset.IfGap,'int8');
% fwrite(fileID,dataset.DataNumberBot,'int16');
% blankfill(fileID,89);
blankfill(fileID,186);
hwait=waitbar(0,'Saving...');
for i=1:1:dataset.total
    waitbar(i/dataset.total,hwait,'Saving...');
    SingleStationWrite(dataset.datas(i),fileID);
end
close(hwait);