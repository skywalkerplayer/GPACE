function returner=MDncFileRead(FolderName)
FileList=dir(FolderName);%Get Filename list. Notice that all files will be included. dir will create "." and ".." in the result list.
FileNumber=length(FileList);
FileNumber=FileNumber-2;%Do not read the "." and "..".
FileNameList=cell(FileNumber,1);
hwait=waitbar(0,'Reading...');%set up a waitbar.
started=0;
% j=0;
for i=1:1:FileNumber
    waitbar(i/FileNumber,hwait,'Reading...');    
    FileNameList{i}=FileList(i+2).name;
    [~,~,expand]=fileparts(FileNameList{i});
    if strcmp(expand,'.nc')
%         j=j+1;
        tempTime=ncread(FileNameList{i},'time');
        tempDuV=ncread(FileNameList{i},'duV');
        tempDuNS=ncread(FileNameList{i},'duNS');
        tempDuEW=ncread(FileNameList{i},'duEW');
        if started==0
            returner.lat=ncread(FileNameList{i},'lat');
            returner.lon=ncread(FileNameList{i},'lon');
            returner.time=tempTime;
            returner.duV=tempDuV;
            returner.duNS=tempDuNS;
            returner.duEW=tempDuEW;
            started=1;
        else
            returner.time=[returner.time;tempTime];
            returner.duV=PlaneTimeAdd(returner.duV,tempDuV);
            returner.duNS=PlaneTimeAdd(returner.duNS,tempDuNS);
            returner.duEW=PlaneTimeAdd(returner.duEW,tempDuEW);
        end
    end
end
close(hwait);