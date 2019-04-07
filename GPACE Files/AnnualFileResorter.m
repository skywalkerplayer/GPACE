function returner=AnnualFileResorter(FolderName)
FileList=dir(FolderName);%Get Filename list. Notice that all files will be included. dir will create "." and ".." in the result list.
FileNumber=length(FileList);
FileNumber=FileNumber-2;%Do not read the "." and "..".
FileNameList=cell(FileNumber,1);
hwait=waitbar(0,'Resorting...');%set up a waitbar.
for i=1:1:FileNumber
    waitbar(i/FileNumber,hwait,'Resorting...');    
    FileNameList{i}=FileList(i+2).name;
    [~,FileName,expand]=fileparts(FileNameList{i});
    if strcmp(expand,'.twOH')||strcmp(expand,'.soilmOH');
        returner.time(i)=str2double(FileName(1:9));
        temp=importdata(FileNameList{i});
        for j=1:1:length(temp(:,3))
            if j==1
                k=1;
                l=1;
            end
            if i==1 && j==1
                returner.lon=temp(j,1);
                returner.lat=temp(j,2);
                returner.LWE=ones(2,2,2);
            end
            
            if returner.lat(l)~=temp(j,2)
                l=l+1;
                if i==1
                    returner.lat(l)=temp(j,2);
                end
            end
            if l==1
                if i==1
                    returner.lon(k)=temp(j,1);
                end
                k=k+1;
            end
            if l==2 && j==k
                k=k-1;
            end
            if mod(j,k)==0
                returner.LWE(k,l,i)=temp(j,3);
            else
                returner.LWE(mod(j,k),l,i)=temp(j,3);
            end
            
        end
    else
        if strcmp(expand,'.GRACE_OH')
            returner.time(i)=str2double(FileName(1:9));
            temp=importdata(FileNameList{i});
            for j=1:1:length(temp(:,3))
                if j==1
                    k=1;
                    l=1;
                end
                if i==1 && j==1
                    returner.lon=temp(j,1);
                    returner.lat=temp(j,2);
                    returner.LWE=ones(2,2,2);
                end
                if returner.lon(k)~=temp(j,1)
                    k=k+1;
                    if i==1
                        returner.lon(k)=temp(j,1);
                    end
                end
                if k==1
                    if i==1
                        returner.lat(l)=temp(j,2);
                    end
                    l=l+1;
                end
                if k==2 && j==l
                    l=l-1;
                end
                if mod(j,l)==0
                    returner.LWE(k-1,l,i)=temp(j,3);
                else
                    returner.LWE(k,mod(j,l),i)=temp(j,3);
                end              
            end
        end
    end
end
close(hwait);
        