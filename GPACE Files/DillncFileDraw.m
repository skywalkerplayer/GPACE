function DillncFileDraw()
FolderName=uigetdir('F:\Matlab Workspace','Choose Dir');
FileList=dir(FolderName);%Get Filename list. Notice that all files will be included. dir will create "." and ".." in the result list.
FileNumber=length(FileList);
FileNumber=FileNumber-2;%Do not read the "." and "..".
FileNameList=cell(FileNumber,1);
hwait=waitbar(0,'Reading...');%set up a waitbar.
for i=1:1:FileNumber
    waitbar(i/FileNumber,hwait,'Reading...');    
    FileNameList{i}=FileList(i+2).name;
    [~,~,expand]=fileparts(FileNameList{i});
    if strcmp(expand,'.nc')
        temp=SingleMDncFileRead(FileNameList{i});
        ncPartWrite(temp,[num2str(i),'.nc']);
    end
end
close(hwait);