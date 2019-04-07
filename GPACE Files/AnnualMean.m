function returner=AnnualMean(Data,DataType,DataNumber,IfStandardize)
global datas;
global StationCoor;
switch DataType
    case 'SGP' % 1 station GPS
    case 'AGP' % all station GPS
        minY=9999;
        maxY=0;
        minY=ceil(minY);
        maxY=floor(maxY);
        for i=1:1:DataNumber
            if Data{i}.decimalyear(1)<minY
                minY=Data{i}.decimalyear(1);
            end
            if Data{i}.decimalyear(end)>maxY
                maxY=Data{i}.decimalyear(end);
            end
        end
        minY=ceil(minY);
        maxY=floor(maxY);
        %Establish time range
        returner.year=(minY:1:maxY);
        returner.Ampl=zeros(1,length(returner.year));
        hwait=waitbar(0,'Calculating...');%set up a waitbar.
        for i=minY:1:maxY %This part is to accumulate the mean of each station in one specific year to calculate the mean of all stations in each year.
            waitbar((i-minY)/(maxY-minY),hwait,'Calculating...');
            ThisYearSum=0;
            for j=1:1:DataNumber
                ThisYearZ=YearExtract(Data{j},i,'z');
                if ThisYearZ.z(1)~=0
                    returner.Ampl(i-minY+1)=returner.Ampl(i-minY+1)+mean(ThisYearZ.z);%Add mean of each stations up first. 
                    ThisYearSum=ThisYearSum+1;
                end
            end
            returner.Ampl(i-minY+1)=returner.Ampl(i-minY+1)/ThisYearSum;%Divide total number of station.
        end
        close(hwait);
    case 'SGR'
    case 'AGR'
        minY=9999;
        maxY=0;
        minY=ceil(minY);
        maxY=floor(maxY);
        for i=1:1:DataNumber
            if Data{i}.decimalyear(1)<minY
                minY=Data{i}.decimalyear(1);
            end
            if Data{i}.decimalyear(end)>maxY
                maxY=Data{i}.decimalyear(end);
            end
        end
        minY=ceil(minY);
        maxY=floor(maxY);
        %Establish time range
        returner.year=(minY:1:maxY);
        returner.Ampl=zeros(1,length(returner.year));
        hwait=waitbar(0,'Calculating...');%set up a waitbar.
        for i=minY:1:maxY %This part is to accumulate the mean of each station in one specific year to calculate the mean of all stations in each year.
            waitbar((i-minY)/(maxY-minY),hwait,'Calculating...');
            ThisYearSum=0;
            for j=1:1:DataNumber
                ThisYearZ=YearExtract(Data{j},i,'z');
                if ThisYearZ.z(1)~=0
                    returner.Ampl(i-minY+1)=returner.Ampl(i-minY+1)+mean(ThisYearZ.z);%Add mean of each stations up first. 
                    ThisYearSum=ThisYearSum+1;
                end
            end
            returner.Ampl(i-minY+1)=returner.Ampl(i-minY+1)/ThisYearSum;%Divide total number of station.
        end
        close(hwait);
%         returner.year=1999:2017;
%         returner.Ampl=0;
    case 'SW'  % 1 station water
    case 'AW'  % all station water
        minY=9999;
        maxY=0;
        minY=ceil(minY);
        maxY=floor(maxY);
        for i=1:1:DataNumber
            if Data.time(1)<minY
                minY=Data.time(1);
            end
            if Data.time(end)>maxY
                maxY=Data.time(end);
            end
        end
        minY=ceil(minY);
        maxY=floor(maxY);
        returner.year=(minY:1:maxY);
        returner.Ampl=zeros(1,length(returner.year));
        hwait=waitbar(0,'Calculating...');%set up a waitbar.
        for i=minY:1:maxY
            waitbar((i-minY)/(maxY-minY),hwait,'Calculating...');
            ThisYearSum=0;
            for j=1:1:DataNumber
                k=1;
                while strcmp(datas{j}.stationame,StationCoor.textdata{k})==0
                    k=k+1;
                end
                ThisWater=StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),Data);
                ThisYearZ=YearExtract(ThisWater,i,'h');
                if ThisYearZ.LWE(1)~=0
                    returner.Ampl(i-minY+1)=returner.Ampl(i-minY+1)+mean(ThisYearZ.LWE);%Add mean of each stations up first. 
                    ThisYearSum=ThisYearSum+1;
                end
            end
            returner.Ampl(i-minY+1)=returner.Ampl(i-minY+1)/ThisYearSum;%Divide total number of station.
        end
        close(hwait);
end

if IfStandardize==1
    returner.Ampl=Standardize(returner.Ampl);
end