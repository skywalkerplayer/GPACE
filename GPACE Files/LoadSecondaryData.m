function LoadSecondaryData(SecPath,PriData)
global SecData;
global DataNumber;
% DataNumber=0;
Filelist=dir(SecPath);%Get Filename list. Notice that all files will be included. dir will create "." and ".." in the result list.
[FileNumber,~]=size(Filelist);
FileNumber=FileNumber-2;%Do not read the "." and "..".
Filenamelist=cell(FileNumber,1);
% for i=1:1:FileNumber
%     Filenamelist{i}=Filelist(i+2).name;%Do not read the "." and "..".
%     DataNumber=DataNumber+IfGPS([SecPath,'\',Filenamelist{i}]);%Count how many of the files are readable GPS files.
% end
% sizer=size(PriData);
% DataNumber=sizer(1);
SecData=cell(DataNumber,1);
unread=0; %number of files that are not gps file and not read.
hwait=waitbar(0,'Reading Secondary Data...');%set up a waitbar.
for i=1:1:FileNumber
    Filenamelist{i}=Filelist(i+2).name;%Do not read the "." and "..".
    [~,Stationame,~]=fileparts([SecPath,'\',Filenamelist{i}]);
    Stationame=Stationame(1:4);%for Stationame_SH only!
    if ((i-unread)<=DataNumber) && strcmp(Stationame,PriData{i-unread}.stationame)
        [ifunread,SecData{i-unread}]=gpsdataread([SecPath,'\',Filenamelist{i}],PriData{i-unread}.x(1),PriData{i-unread}.y(1),PriData{i-unread}.z(1));%  ,PriData{i-unread}.x(1),PriData{i-unread}.y(1),PriData{i-unread}.z(1)
    else
        ifunread=1;
    end
    unread=unread+ifunread;%if a file is not read, count+1 to make datalist continously.
    waitbar(i/FileNumber,hwait,'Reading...');
end
close(hwait);%close the waitbar.