function varargout = GPSWORK(varargin)
% GPSWORK MATLAB code for GPSWORK.fig
%      GPSWORK, by itself, creates a new GPSWORK or raises the existing
%      singleton*.
%
%      H = GPSWORK returns the handle to a new GPSWORK or the handle to
%      the existing singleton*.
%
%      GPSWORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GPSWORK.M with the given input arguments.
%
%      GPSWORK('Property','Value',...) creates a new GPSWORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GPSWORK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GPSWORK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GPSWORK

% Last Modified by GUIDE v2.5 09-Jan-2017 14:14:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GPSWORK_OpeningFcn, ...
                   'gui_OutputFcn',  @GPSWORK_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GPSWORK is made visible.
function GPSWORK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GPSWORK (see VARARGIN)

% Choose default command line output for GPSWORK
handles.output = hObject;
global SecondaryPathSet;
global XDeltaX;
global DataNumber;
global IfPri;
global IfSec;
global IfDandM;
global IfHydro;
global IfMD;
global IfModelDataRead;
global IfFiltered;
global IfWaterRead;
IfModelDataRead=0;
DataNumber=0;
XDeltaX=0;
IfPri=0;
IfSec=0;
IfDandM=0;
SecondaryPathSet=0;
IfHydro=0;
IfMD=0;
IfFiltered=0;
IfWaterRead=0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GPSWORK wait for user response (see UIRESUME)
% uiwait(handles.GPSMain);


% --- Outputs from this function are returned to the command line.
function varargout = GPSWORK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ImportDataFolder_Callback(hObject, eventdata, handles)
% hObject    handle to ImportDataFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This function imports folders of GPS datas never processed by this
%software.
global datas;
global FileNumber;
global DataNumber;
global ThisdataPri;
global IfSec;
global IfDetrend;
global namelist;
global IfPri;
global StationCoor;
global Foldername;
StationCoor=importdata('StationLatLonHig.txt');
IfPri=1;
IfDetrend=0;
IfSec=0;
% global gpsdata;
Foldername=uigetdir('F:\Matlab Workspace','Choose Dir');%Get folder path`
if Foldername~=0
    Filelist=dir(Foldername);%Get Filename list. Notice that all files will be included. dir will create "." and ".." in the result list.
    [FileNumber,~]=size(Filelist);
    FileNumber=FileNumber-2;%Do not read the "." and "..".
    Filenamelist=cell(FileNumber,1);
    DataNumber=0;
    for i=1:1:FileNumber
        Filenamelist{i}=Filelist(i+2).name;%Do not read the "." and "..".
        DataNumber=DataNumber+IfGPS([Foldername,'\',Filenamelist{i}]);%Count how many of the files are readable GPS files.
    end
    datas=cell(DataNumber,1);
    unread=0;
    namelist='';
    hwait=waitbar(0,'Reading...');%set up a waitbar.
    for i=1:1:FileNumber
        [ifunread,datas{i-unread}]=gpsdataread([Foldername,'\',Filenamelist{i}]);
        unread=unread+ifunread;%if a file is nor read, count+1 to make datalist continously.
        if ifunread==0
            namelist=[namelist,datas{i-unread}.stationame,'|'];%add stationame to namelist to be displayed in Stationbox.
        end
        waitbar(i/FileNumber,hwait,'Reading...');
    end
    close(hwait);%close the waitbar.
    msgbox('Finished!');
    set(handles.Stationbox,'String',namelist);
    global number;
    number=1;
    ThisdataPri=datas{number};
    plotfigures(handles,IfPri,IfSec)
end


% --------------------------------------------------------------------
function ResortByTime_Callback(hObject, eventdata, handles)
% hObject    handle to ResortByTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.Stationbox,'String','ACSO|ACSB');


% --------------------------------------------------------------------
function ShowTimeLabels_Callback(hObject, eventdata, handles)
% hObject    handle to ShowTimeLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global datas;

TimeTable=figure;
ColnumNames={'Station Name','Time'};
T=uitalbe(Timetable,'Data',datas);


% --------------------------------------------------------------------
function ExtractStationMap_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractStationMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Extract coordinate and station name to excel table.
global datas;
global DataNumber;
global StationCoor;
j=1;
outputer=cell(DataNumber+1,3);
outputer{1,1}='StationName';
outputer{1,2}='Latitude';
outputer{1,3}='Longitude';
for i=1:1:DataNumber
    outputer{i+1,1}=datas{i}.stationame;
    while strcmp(datas{i}.stationame,StationCoor.textdata{j})==0
        j=j+1;
    end
    outputer{i+1,2}=StationCoor.data(j,1);
    outputer{i+1,3}=StationCoor.data(j,2);
end
xlswrite('ExportedStation.xlsx',outputer);
msgbox('Finished!');


% --------------------------------------------------------------------
function RenameExpand_Callback(hObject, eventdata, handles)
% hObject    handle to RenameExpand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This function rename filenames as 'ACSO_SH_lat' to 'ACSO_SH.lat' so expand
%can be identified by fileparts function.
Foldername=uigetdir('F:\Matlab Workspace','Choose Dir');%Get folder path
Filelist=dir(Foldername);%Get Filename list. Notice that all files will be included. dir will create "." and ".." in the result list.
[FileNumber,~]=size(Filelist);
FileNumber=FileNumber-2;%Do not read the "." and "..".
Filenamelist=cell(FileNumber,1);
hwait=waitbar(0,'Reading...');%set up a waitbar.
for i=1:1:FileNumber
    Filenamelist{i}=Filelist(i+2).name;%Do not read the "." and "..".
    searcher=strfind(Filenamelist{i},'_');%search for all '_' in file.
    if ~isempty(searcher) && searcher(end)==(length(Filenamelist{i})-3)  %if there is '_' and act as'.'
        oldname=Filenamelist{i};
        Filenamelist{i}(end-3)='.'; %change '_' into '.'
        movefile([Foldername,'\',oldname],[Foldername,'\',Filenamelist{i}]); %Rename the file.
    end
    [~,~,expand]=fileparts(Filenamelist{i});
    if strcmp(expand,'.lat')||strcmp(expand,'.eas')
        Filenamelist{i+1}=Filelist(i+3).name;
        Filenamelist{i+2}=Filelist(i+4).name;
        mergefile(Filenamelist{i},Filenamelist{i+1},Filenamelist{i+2},Foldername);
    end
    waitbar(i/FileNumber,hwait,'Renaming and merging...');
end
close(hwait);%close the waitbar.
msgbox('Finished!');


% --- Executes on selection change in Stationbox.
function Stationbox_Callback(hObject, eventdata, handles)
% hObject    handle to Stationbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Stationbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Stationbox

%Callback for click on station list.
global number;
global IfPri;
global IfSec;
global IfDandM;
global ThisdataPri;
% global ThisdataSec;
global datas;
% global IfDetrend;
global DataNumber;
global IfHydro;
global ThisHydro;
global water;
global IfWaterRead;
global StationCoor;
global IfMD;
global IfModelDataRead;
global ThisMD;
global ModelData;
number=get(handles.Stationbox,'value');
if number>DataNumber
    number=number-1;
end
if IfDandM==1;%Detrend and match time between GPS and GRACE
    ThisdataPri=datas{number};
    ReadThisSec();
    DandM();
else
    if IfPri==1
        ThisdataPri=datas{number};
    end
    if IfSec==1
        ReadThisSec();
    end
end

if IfHydro==1 %Show hydrology data
    if IfWaterRead==0
        msgbox('Please load water data first!');
    else
        k=1;
        while strcmp(datas{number}.stationame,StationCoor.textdata{k})==0
            k=k+1;
        end
        ThisHydro=StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water);
        [ThisdataPri,ThisHydro]=GWDandM(datas{number},ThisHydro);
    end
end

if IfMD==1 %Show modeled deformation data
    if IfModelDataRead==0
        msgbox('Please load model deformation data first!');
    else
        k=1;
        while strcmp(datas{number}.stationame,StationCoor.textdata{k})==0
            k=k+1;
        end
        ThisMD=StationMDExtract(StationCoor.data(k,2),StationCoor.data(k,1),ModelData);
        [ThisdataPri,ThisMD]=GMDandM(ThisdataPri,ThisMD);
%         [ThisdataPri,ThisHydro]=GWDandM(datas{number},ThisHydro);
    end
end

plotfigures(handles,IfPri,IfSec);
% else
%     if IfDetrend==0;
%         IfSec=0;
%         ThisdataPri=datas{number};
%         ShowSecondary_Callback(hObject, eventdata, handles);
%         plotfigures(handles,XDeltaX,IfSec);
%     else
%         IfDetrend=0;
%         IfSec=0;
%         PBDetrendandMatchTime_Callback(hObject, eventdata, handles);
%         plotfigures(handles,XDeltaX,IfSec);        
%     end
% end
% set(handle.xDisplayer,



% --- Executes during object creation, after setting all properties.
function Stationbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stationbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end


% --- Executes on button press in ShowSecondary.
% function ShowSecondary_Callback(hObject, eventdata, handles)
% % hObject    handle to ShowSecondary (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global datas;
% global number;
% global SecondaryPath;
% global SecondaryPathSet;
% global XDeltaX;
% global IfSec;
% global ThisdataSec;
% if SecondaryPathSet~=1
%     msgbox('Please set up Secondary Path Format first!');
% else
%     [ifread,ThisdataSec]=gpsdataread([SecondaryPath{1},'\',SecondaryPath{2},datas{number}.stationame,SecondaryPath{3}],datas{number}.x(1),datas{number}.y(1),datas{number}.z(1));
%     %                             Dir                  Prefix           Staioname                suffix            start x,y,z.  
%     IfSec=1-IfSec;
%     if ifread==0
%         plotfigures(handles,XDeltaX,IfSec)
%     end
% end


% --------------------------------------------------------------------
function SetSecondaryPathformat_Callback(hObject, eventdata, handles)
% hObject    handle to SetSecondaryPathformat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SecondaryPath;
global SecondaryPathSet;%bool to indicate SecondaryPath is set.
global IfPri;
global IfSec;
SecondaryPathSet=1;
SecondaryPath=cell(3,1);%Assume that filename contains stationame. 1 is dir, 2 is prefix, 3 is suffix.
SecondaryPath{1}=uigetdir('F:\Matlab Workspace','Choose Secondary Dir');
[SecondaryPath{2},SecondaryPath{3}]=SecondaryFormat();
IfCombine=questdlg('Combine secondary data?','Combine','Yes','Np');
if strcmp(IfCombine,'Yes')
    IfSec=1;
    plotfigures(handles,IfPri,IfSec);
end

% --------------------------------------------------------------------
function View_Callback(hObject, eventdata, handles)
% hObject    handle to View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MapView_Callback(hObject, eventdata, handles)
% hObject    handle to MapView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global datas;
global SecondaryPath;
global SecondaryPathSet;
if SecondaryPathSet==1
    MapViewer(datas,SecondaryPath{1});
else
    msgbox('Please set up Secondary Path Format first!');
end


% --------------------------------------------------------------------
function Screenshot_Callback(hObject, eventdata, handles)
% hObject    handle to Screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = handles.GPSMain; %创建一个Figure，并返回其句柄
    hp3=getframe(h);
    hp3= frame2im(hp3);
    [filename3,pathname3] = uiputfile({'*.jpg','JPEG(*.jpg)';...
        '*.bmp','Bitmap(*.bmp)';...
        '*.gif','GIF(*.gif)';...
        '*.*',  'All Files (*.*)'},...
        'screenshot','screenshot1');
    if filename3==0
        return
    else
        imwrite(hp3,fullfile(pathname3,filename3));
    end


% --------------------------------------------------------------------
function Data_Callback(hObject, eventdata, handles)
% hObject    handle to Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function DataNumberFilter_Callback(hObject, eventdata, handles)
% hObject    handle to DataNumberFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This function filter out the stations does not have enough corresponding
%data between GPS and GRACE
global DataNumber;
global datas;
global ThisdataPri;
% global SecondaryPath;
global SecondaryPathSet;
% global ThisdataSec;
global number;
global namelist;
global IfPri;
global IfSec;
if SecondaryPathSet==0;
%     msgbox();
    error('Please set secondary path format!');
end
j=1;
limit=str2double(cell2mat(inputdlg('Input low limit')));
hwait=waitbar(0,'Reading...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber+j,hwait,'Filtering...');
%     number=i;
%     PBDetrendandMatchTime_Callback(hObject, eventdata, handles);%Use detrend function to calculate length of dataset after stacktimed. Should be rewitten to be more efficient.
    number=i;
    ReadThisSec();
    DandM();
    if (length(ThisdataPri.z))<limit
        lister(j)=i;
        j=j+1;
    end
    if j==1
        lister=[];
    end
end
close(hwait);%close the waitbar.
total=length(lister);
for i=1:1:total
    datas(lister(total-i+1))=[];%Use reverse order to 
    namelist(5*lister(total-i+1)-4:5*lister(total-i+1))=[];
end
DataNumber=DataNumber-total;
msgbox('Finished!');
set(handles.Stationbox,'String',namelist);
set(handles.Stationbox,'String',namelist);
number=1;
ThisdataPri=datas{number};
plotfigures(handles,IfPri,IfSec)


% --------------------------------------------------------------------
function ShiftNeutralize_Callback(hObject, eventdata, handles)
% hObject    handle to ShiftNeutralize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global datas;
global ThisdataPri;
global DataNumber;
global number;
global IfPri;
global IfSec;
% number=DataNumber;
odd=0;
prompt={'Enter slope','Enter n of points:'};
while odd==0
inputed=inputdlg(prompt,'Input parameter',1);
% inputed=cell2mat(answer);
n=str2double(inputed{2});
slope=str2double(inputed{1});
odd=mod(n,2);
end
ThisdataPri.z=ShiftNeutralize(ThisdataPri.z,n,slope);
plotfigures(handles,IfPri,IfSec);
choice=questdlg('Apply this to current data?','To all?','Yes','No','Yes');
if strcmp(choice,'Yes')
    datas{number}.z=ThisdataPri.z;
end
choice=questdlg('Apply this to all data?','To all?','Yes','No','Yes');
if strcmp(choice,'Yes')
    for i=1:1:DataNumber
        datas{i}.z=ShiftNeutralize(datas{i}.z,n,slope);
    end
    number=DataNumber;
% else
%     This
%     datas{i}.z=ThisdataPri.z;
end
ThisdataPri=datas{number};
plotfigures(handles,IfPri,IfSec);

% --- Executes on button press in RBENV.
function RBENV_Callback(hObject, eventdata, handles)
% hObject    handle to RBENV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global XDeltaX;
XDeltaX=0;

% Hint: get(hObject,'Value') returns toggle state of RBENV


% --- Executes on button press in RBDeltaENV.
function RBDeltaENV_Callback(hObject, eventdata, handles)
% hObject    handle to RBDeltaENV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global XDeltaX;
XDeltaX=1;

% Hint: get(hObject,'Value') returns toggle state of RBDeltaENV


% --- Executes on button press in CBPrimary.
function CBPrimary_Callback(hObject, eventdata, handles)
% hObject    handle to CBPrimary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IfPri;
IfPri=get(handles.CBPrimary,'value');

% Hint: get(hObject,'Value') returns toggle state of CBPrimary


% --- Executes on button press in CBSecondary.
function CBSecondary_Callback(hObject, eventdata, handles)
% hObject    handle to CBSecondary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IfSec;
IfSec=get(handles.CBSecondary,'value');

% Hint: get(hObject,'Value') returns toggle state of CBSecondary


% --- Executes on button press in CBDandM.
function CBDandM_Callback(hObject, eventdata, handles)
% hObject    handle to CBDandM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global IfDandM;
% global IfHydro;
IfDandM=get(hObject,'value');
% if IfDandM==1
%     set(handles.CBoxShowHydro,'Enable','on');
% else
%     set(handles.CBoxShowHydro,'Enable','off');
%     IfHydro=0;
% end

% Hint: get(hObject,'Value') returns toggle state of CBDandM


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over RBENV.
function RBENV_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RBENV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global XDeltaX;
XDeltaX=0;
SetTextTag(XDeltaX,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over RBDeltaENV.
function RBDeltaENV_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RBDeltaENV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global XDeltaX;
XDeltaX=1;
SetTextTag(XDeltaX,handles);


% --- Executes on key press with focus on RBDeltaENV and none of its controls.
function RBDeltaENV_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to RBDeltaENV (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

global XDeltaX;
XDeltaX=1;
SetTextTag(XDeltaX,handles);


% --- Executes when selected object is changed in UPENV.
function UPENV_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in UPENV 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

global XDeltaX;
XDeltaX=get(handles.RBDeltaENV,'value');
SetTextTag(XDeltaX,handles);


% --------------------------------------------------------------------
function MPA_Callback(hObject, eventdata, handles)
% hObject    handle to MPA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ThisdataPri;
aver=nsmoother(ThisdataPri.x,5);
figure;
plot(aver);




% --------------------------------------------------------------------
function DiracEleminate_Callback(hObject, eventdata, handles)
% hObject    handle to DiracEleminate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'Enter Height','Enter Width'};
inputed=inputdlg(prompt,'Input parameter',1);
global datas;
global number;
global ThisdataPri;
global IfPri;
global IfSec;
global DataNumber;
height=str2double(inputed{1});
width=str2double(inputed{2});
ThisdataPri.z=DiracEleminate(ThisdataPri.z,width,height);
% halfwidth=ceil(width/2);
% for i=1:1:(length(ThisdataPri.z)-width)
%     if abs(ThisdataPri.z(i+halfwidth)-ThisdataPri.z(i))>=height
%         if abs(ThisdataPri.z(i+halfwidth)-ThisdataPri.z(i+width))>=height
%             ThisdataPri.z(i+halfwidth)=mean([ThisdataPri.z(i+halfwidth-1),ThisdataPri.z(i+halfwidth+1)]);
%         end
%     end
% end
% for i=1:1:halfwidth
%     if abs(ThisdataPri.z(i)-ThisdataPri.z(halfwidth))>=height
%         ThisdataPri.z(i)=mean(ThisdataPri.z(1:halfwidth));
%     end
%     if abs(ThisdataPri.z(length(ThisdataPri.z)-i+1))-ThisdataPri.z(halfwidth)>=height
%         ThisdataPri.z(length(ThisdataPri.z)-i+1)=mean(ThisdataPri.z(length(ThisdataPri.z)-halfwidth:length(ThisdataPri.z)));
%     end
% end
plotfigures(handles,IfPri,IfSec);
choice=questdlg('Apply this to current data?','To current?','Yes','No','Yes');
if strcmp(choice,'Yes')
    datas{number}=ThisdataPri;
end
choice=questdlg('Apply this to all data?','To all?','Yes','No','Yes');
if strcmp(choice,'Yes')
    datas{number}=ThisdataPri;
    for i=1:1:DataNumber
        datas{i}.z=DiracEleminate(datas{i}.z,width,height);
    end
    number=DataNumber;
else
%     This
%     datas{number}.z=ThisdataPri.z;
end
% ThisdataPri=datas{number};
plotfigures(handles,IfPri,IfSec);




% --------------------------------------------------------------------
function GapFill_Callback(hObject, eventdata, handles)
% hObject    handle to GapFill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global datas;
global number;
global IfPri;
global IfSec;
prompt={'Enter Width as decimal year'};
inputed=inputdlg(prompt,'Inpur parameter',1);
width=str2double(inputed{1});
totalyears=length(datas{number}.decimalyear);
for i=1:1:totalyears-1
    if datas{number}.decimalyear(i+1)-datas{number}.decimalyear(i)>width
        interval=datas{number}.decimalyear(i)-datas{number}.decimalyear(i-1);
        yearnumbers=floor((datas{number}.decimalyear(i+1)-datas{number}.decimalyear(i))/interval);
        years=ones(1,yearnumbers);
        for j=1:1:yearnumbers
            years(j)=datas{number}.decimalyear(i)+interval*j;
        end
        endpoint=[datas{number}.decimalyear(i),datas{number}.decimalyear(i+1)];
        xendvalue=[datas{number}.x(i),datas{number}.x(i+1)];
        yendvalue=[datas{number}.y(i),datas{number}.y(i+1)];
        zendvalue=[datas{number}.z(i),datas{number}.z(i+1)];
        xs=interp1(endpoint,xendvalue,years);
%         deltaxs(1:length(years))=xs(2)-xs(1);
%         sigmaxs
        ys=interp1(endpoint,yendvalue,years);
        zs=interp1(endpoint,zendvalue,years);
        datas{number}.decimalyear=[datas{number}.decimalyear(1:i)',years,datas{number}.decimalyear(i+1:totalyears)']';
        datas{number}.x=[datas{number}.x(1:i)',xs,datas{number}.x(i+1:totalyears)']';
        datas{number}.y=[datas{number}.y(1:i)',ys,datas{number}.y(i+1:totalyears)']';
        datas{number}.z=[datas{number}.z(1:i)',zs,datas{number}.z(i+1:totalyears)']';
    end
end
plotfigures(handles,IfPri,IfSec);

% --------------------------------------------------------------------
function DataAnalyzer_Callback(hObject, eventdata, handles)
% hObject    handle to DataAnalyzer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SecondaryPathSet
if SecondaryPathSet
    DataAnalyzer();
else
    msgbox('Please set up Secondary Path Format first!');
end


% --------------------------------------------------------------------
function GapCut_Callback(hObject, eventdata, handles)
% hObject    handle to GapCut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global datas;
global number;
global IfPri;
global IfSec;
global ThisdataPri;
prompt={'Enter Width as decimal year','Enter direction guide'};
inputed=inputdlg(prompt,'Inpur parameter',1);
width=str2double(inputed{1});
direction=str2double(inputed{2});
totalyears=length(datas{number}.decimalyear);
i=1;
cut=0;
while(i<=totalyears-1&&cut==0)
    if datas{number}.decimalyear(i+1)-datas{number}.decimalyear(i)>width
        if direction==0
            if i>totalyears/2
                datas{number}=GPSdataCut(datas{number},i,0);
            else
                datas{number}=GPSdataCut(datas{number},i,1);
            end
            cut=1;
        else
            if direction==1
                datas{number}=GPSdataCut(datas{number},i,0);
                cut=1;
            end
            if direction==2
                datas{number}=GPSdataCut(datas{number},i,1);
                cut=1;
            end
        end
    end
    i=i+1;
end
ThisdataPri=datas{number};
plotfigures(handles,IfPri,IfSec);


% --------------------------------------------------------------------
function New_Callback(hObject, eventdata, handles)
% hObject    handle to New (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.xDisplayer);
cla(handles.yDisplayer);
cla(handles.zDisplayer);
global SecondaryPathSet;
global XDeltaX;
global DataNumber;
global IfPri;
global IfSec;
global IfDandM;
DataNumber=0;
XDeltaX=0;
IfPri=0;
IfSec=0;
IfDandM=0;
SecondaryPathSet=0;
set(handles.CBPrimary,'Value',1);
set(handles.CBSecondary,'Value',0);
set(handles.CBDandM,'Value',0);
set(handles.Stationbox,'String','');
clear;

% --------------------------------------------------------------------
function OpenDataSet_Callback(hObject, eventdata, handles)
% hObject    handle to OpenDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Open a dataset saved by this software. Needs work on reading more information.
global DataNumber;
global datas;
global IfPri;
global IfSec;
global namelist;
global ThisdataPri;
global SecondaryPath;
global SecondaryPathSet;
global number;
global IfFiltered;
global StationCoor;
% global SecDataset;
StationCoor=importdata('StationLatLonHig.txt');
[FileName,PathName]=uigetfile( ...
    {'*.gpdz','GPS Dataset File(*.gpdz)';},...
    'Open GPS dataset');
if FileName~=0
    fileID=fopen([PathName,FileName],'r');
    dataset=DataRead(fileID);
    DataNumber=dataset.total;
    % namelist='';
    hwait=waitbar(0,'Setting data...');
    % tic;
    namelist=blanks(5*DataNumber-1);
    for i=1:1:DataNumber
        waitbar(i/DataNumber,hwait,'Setting data...');
        datas{i}=dataset.datas(i);
    %     namelist=[namelist,dataset.datas(i).stationame,'|'];
        namelist(5*(i-1)+1:5*(i-1)+4)=dataset.datas(i).stationame;
        if i~=DataNumber
            namelist(5*i)='|';
        end
    end
    % toc;
    close(hwait);
    IfSec=dataset.IfSec;
    IfFiltered=dataset.IfFiltered;
    if IfSec==1
        SecondaryPath=SecPathreRead(dataset.SecPath);
        SecondaryPathSet=1;
        set(handles.CBSecondary,'Value',1);
    end
    set(handles.Stationbox,'String',namelist);
    IfPri=1;
    ThisdataPri=datas{1};
    number=1;
    SecDatasetRead();
    plotfigures(handles,IfPri,IfSec);
end


% --------------------------------------------------------------------
function SaveDataSet_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Save a dataset to be open. Needs work on storing more information.
global DataNumber;
global datas;
global Foldername;
% global IfSec;
global SecondaryPath;
global SecondaryPathSet;
global IfFiltered;
[FileName,PathName]=uiputfile( ...
    {'*.gpdz','GPS Dataset File(*.gpdz)';},...
    'Save GPS dataset');
if FileName~=0
    fileID=fopen([PathName,FileName],'w');
    dataset.total=DataNumber;
    dataset.OriginalPath=Foldername;
    dataset.IfSec=SecondaryPathSet;
    dataset.IfFiltered=IfFiltered;
    if SecondaryPathSet==1
        dataset.SecPath=SecondaryPath;
    else
        dataset.SecPath='Null';
    end
    hwait=waitbar(0,'Setting data...');
    for i=1:1:DataNumber
        waitbar(i/DataNumber,hwait,'Setting data...');
        dataset.datas(i)=datas{i};
    end
    close(hwait);
    DataWrite(fileID,dataset);
end



% --------------------------------------------------------------------
function DeleteStation_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global number;
global datas;
global namelist;
global DataNumber;
global ThisdataPri;
global IfPri;
global IfSec;
DataNumber=DataNumber-1;
datas(number)=[];
namelist(5*number-4:5*number)=[];
set(handles.Stationbox,'String',namelist);
number=1;
ThisdataPri=datas{number};
plotfigures(handles,IfPri,IfSec);


% --- Executes on button press in CBoxShowHydro.
function CBoxShowHydro_Callback(hObject, eventdata, handles)
% hObject    handle to CBoxShowHydro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBoxShowHydro
global IfHydro;
IfHydro=get(hObject,'Value');


% --------------------------------------------------------------------
function ReadWaterData_Callback(hObject, eventdata, handles)
% hObject    handle to ReadWaterData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global water;
global IfWaterRead;
choice=questdlg('Which type of data do you want to input?','Data type','.nc','.GRACE_OH','.t or .s','.t or .s');
switch choice
    case '.nc'
        [FileName,PathName]=uigetfile('*.nc');
        water=GRACEncFileRead([PathName,FileName]);
        
    case '.GRACE_OH'
        FolderName=uigetdir('F:\Matlab Workspace','Choose Dir');
        water=AnnualFileResorter(FolderName);
        
    case '.t or .s'
        FolderName=uigetdir('F:\Matlab Workspace','Choose Dir');
        water=AnnualFileResorter(FolderName);
        
%     case '.soilm_OH_all'
%         FolderName=uigetdir('F:\Matlab Workspace','Choose Dir');
%         water=AnnualFileResorter(FolderName);
        
end
IfWaterRead=1;


% --------------------------------------------------------------------
function StationEditor_Callback(hObject, eventdata, handles)
% hObject    handle to StationEditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StationEditor();


% --------------------------------------------------------------------
function FrequencyDomainFilter_Callback(hObject, eventdata, handles)
% hObject    handle to FrequencyDomainFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global datas;
global DataNumber;
global number;
global IfPri;
global IfSec;
global ThisdataPri;
global IfFiltered;
[LF,HF]=FigChooseFreq();
for i=1:1:DataNumber
    datas{i}.z=FreqFilter(datas{i}.z-datas{i}.z(1),LF,HF);
end
number=1;
ThisdataPri=datas{number};
IfFiltered=1;
plotfigures(handles,IfPri,IfSec)


% --- Executes on button press in CBShowMD.
function CBShowMD_Callback(hObject, eventdata, handles)
% hObject    handle to CBShowMD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IfMD;
IfMD=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of CBShowMD


% --------------------------------------------------------------------
function ReadModeledData_Callback(hObject, eventdata, handles)
% hObject    handle to ReadModeledData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ModelData;
global IfModelDataRead;
global IfConvert2XYZ;
FolderName=uigetdir('F:\Matlab Workspace','Choose Dir');
if FolderName~=0
    ModelData=MDncFileRead(FolderName);
    IfModelDataRead=1;
    IfConvert2XYZ=questdlg('Convert to XYZ data?','Convert?','Yes','No','Yes');
end
% if strcmp(IfConvert2XYZ,'Yes')
%     IfConvert2XYZ=1;
% else
%     IfConvert2XYZ=0;
% end


%//Feel free to contact me if you need related files.