function [ifunread,gpsdata]=gpsdataread(filename,startx,starty,startz)
% Read GPS data from a single file and infer x,y,z if needed. 
% Format is [gpsdata(GPS struct defined in main)]=gpsdataread('filename,startx,starty,startz')
[~,stationame,expand]=fileparts(filename);
a=cell(1);
gpsdata=struct('stationame',a,'decimalyear',a,'x',a,'y',a,'z',a,'deltax',a,'deltay',a,'deltaz',a);
filetype=0;
ifunread=1;
switch expand
%     case '.lat'
%         filetype=11;
%     case '.lon'
%         filetype=12;
%     case '.rad'
%         filetype=13;
%     case '.eas'
%         filetype=21;
%     case '.nor'
%         filetype=22;
%     case '.ver'
%         filetype=23;
    case '.llr'
        filetype=1;
    case '.env'
        filetype=2;
    case '.tenv'
        filetype=3;
    case '.txyz2'
        filetype=4;
    case '.tenv3'
        filetype=5;
end
%Reconize filetype by file expand name.
file=fopen(filename);
%use boolx(y,z)delta to mark if the file contains x or deltax.
boolxdelta=1;
boolydelta=1;
boolzdelta=1;
switch filetype
%     case 11 %.lat
%         scanner=textscan(file,'%f %f %f %s %s %s');
%         gpsdata.stationame=scanner(1,4)+'lat';
%         gpsdata.decimalyear=scanner(:,1);
%         gpsdata.deltax=scanner(:,2)/100;        
%         
%     case 12 %.lon
%         scanner=textscan(file,'%f %f %f %s %s %s');
%         gpsdata.stationame=scanner(1,4)+'lon';
%         gpsdata.decimalyear=scanner(:,1);
%         gpsdata.deltay=scanner(:,2)/100;
%         
%     case 13 %.rad
%         scanner=textscan(file,'%f %f %f %s %s %s');
%         gpsdata.stationame=scanner(1,4)+'rad';
%         gpsdata.decimalyear=scanner(:,1);
%         gpsdata.deltaz=scanner(:,2)/100;
%         
%     case 21 %.eas
%         scanner=textscan(file,'%f_%s %f %f');
%         gpsdata.stationame=stationame;
%         gpsdata.decimalyear=scanner(:,1);
%         gpsdata.deltax=scanner(:,3);
    case 1 %.llr
        scanner=textscan(file,'%f,%f,%f,%f,%f,%f,%f,%f,%f');
        gpsdata.stationame=stationame;
        gpsdata.decimalyear=scanner{1,1};
        gpsdata.deltax=scanner{1,2};
        gpsdata.deltay=scanner{1,5};
        gpsdata.deltaz=scanner{1,8};
        boolxdelta=1;
        boolydelta=1;
        boolzdelta=1;
        ifunread=0;
    case 2 %.env
        scanner=textscan(file,'%f,%f,%f,%f,%f,%f,%f,%f,%f');
        gpsdata.stationame=stationame(1:4);
        gpsdata.decimalyear=scanner{1,1};
        gpsdata.deltax=scanner{1,2};
        gpsdata.deltay=scanner{1,5};
        gpsdata.deltaz=scanner{1,8};
        boolxdelta=1;
        boolydelta=1;
        if abs(gpsdata.deltay(1))>200
            boolydelta=0;
        end
        boolzdelta=1;
        if abs(gpsdata.deltaz(1))>500
            boolzdelta=0;
        end
        ifunread=0;
    case 3 %.tenv
        scanner=importdata(filename);
        gpsdata.stationame=scanner.textdata{1,1};
        gpsdata.decimalyear=scanner.data(:,1);
        gpsdata.deltax=scanner.data(:,5);
        gpsdata.deltay=scanner.data(:,6);
        gpsdata.deltaz=scanner.data(:,7);
        boolxdelta=1;
        boolydelta=1;
        boolzdelta=1;
        ifunread=0;
    case 4 %.txyz2
        scanner=importdata(filename);
        gpsdata.stationame=scanner.textdata{1,1};
        gpsdata.decimalyear=scanner.data(:,1);
        gpsdata.x=scanner.data(:,2);
        gpsdata.y=scanner.data(:,3);
        gpsdata.z=scanner.data(:,4);
        gpsdata.sigmax=scanner.data(:,5);
        gpsdata.sigmay=scanner.data(:,6);
        gpsdata.sigmaz=scanner.data(:,7);        
        boolxdelta=0;
        boolydelta=0;
        boolzdelta=0;
        ifunread=0;
    case 5 %.tenv3
        scanner=importdata(filename);
        gpsdata.stationame=scanner.textdata{2,1};
        gpsdata.decimalyear=scanner.data(:,1);
        gpsdata.x=scanner.data(:,6)+scanner.data(:,7);
        gpsdata.y=scanner.data(:,8)+scanner.data(:,9);
        gpsdata.z=scanner.data(:,10)+scanner.data(:,11);
        gpsdata.sigmax=scanner.data(:,12);
        gpsdata.sigmay=scanner.data(:,13);
        gpsdata.sigmaz=scanner.data(:,14);
        boolxdelta=0;
        boolydelta=0;
        boolzdelta=0;
        ifunread=0;
end

% if filetype==4 || filetype==5 %if there is too less data recorded, ignore this file.
%     
%     if records<=elements
%         ifunread=1;
%         return;
%     end
% end

if boolxdelta==0;
    switch filetype
        case 4
            gpsdata.deltax=gpsdata.x;    
            gpsdata.deltax(1)=0;
            for i=2:1:length(scanner.data)
                gpsdata.deltax(i)=gpsdata.x(i)-gpsdata.x(i-1); 
            end
        case 2
            gpsdata.x=gpsdata.deltax;    
            gpsdata.deltax(1)=0;
            for i=2:1:length(scanner{1,1})
                gpsdata.deltax(i)=gpsdata.x(i)-gpsdata.x(i-1);
            end
        case 5
            gpsdata.deltax=gpsdata.x;    
            gpsdata.deltax(1)=0;
            [records,~]=size(scanner.data);
            for i=2:1:records
                gpsdata.deltax(i)=gpsdata.x(i)-gpsdata.x(i-1); 
            end
    end
end
if boolydelta==0;
    switch filetype
        case 4
            gpsdata.deltay=gpsdata.y;    
            gpsdata.deltay(1)=0;
            for i=2:1:length(scanner.data)
                gpsdata.deltay(i)=gpsdata.y(i)-gpsdata.y(i-1);
            end
        case 2
            gpsdata.y=gpsdata.deltay;    
            gpsdata.deltay(1)=0;
            for i=2:1:length(scanner{1,1})
                gpsdata.deltay(i)=gpsdata.y(i)-gpsdata.y(i-1);
            end
        case 5
            gpsdata.deltay=gpsdata.y;    
            gpsdata.deltay(1)=0;
            [records,~]=size(scanner.data);
            for i=2:1:records
                gpsdata.deltay(i)=gpsdata.y(i)-gpsdata.y(i-1);
            end
    end
end
if boolzdelta==0;
    switch filetype
        case 4
            gpsdata.deltaz=gpsdata.z;    
            gpsdata.deltaz(1)=0;
            for i=2:1:length(scanner.data)
                gpsdata.deltaz(i)=gpsdata.z(i)-gpsdata.z(i-1);
            end
        case 2
            gpsdata.z=gpsdata.deltaz;    
            gpsdata.deltaz(1)=0;
            for i=2:1:length(scanner{1,1})
                gpsdata.deltaz(i)=gpsdata.z(i)-gpsdata.z(i-1);
            end
        case 5
            gpsdata.deltaz=gpsdata.z;    
            gpsdata.deltaz(1)=0;
            [records,~]=size(scanner.data);
            for i=2:1:records
                gpsdata.deltaz(i)=gpsdata.z(i)-gpsdata.z(i-1);
            end
    end
end
if nargin>1 && filetype==2
    gpsdata.x=gpsdata.deltax;
    gpsdata.y=gpsdata.deltay;
    gpsdata.z=gpsdata.deltaz;
    gpsdata.x(1)=startx;
    gpsdata.y(1)=starty;
    gpsdata.z(1)=startz;
    for i=2:1:length(scanner{1,1})
        gpsdata.x(i)=gpsdata.x(i-1)+gpsdata.deltax(i);
        gpsdata.y(i)=gpsdata.y(i-1)+gpsdata.deltay(i);
        gpsdata.z(i)=gpsdata.z(i-1)+gpsdata.deltaz(i);
    end
end
fclose('all');
end