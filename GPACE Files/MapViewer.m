function varargout = MapViewer(varargin)
% MAPVIEWER MATLAB code for MapViewer.fig
%      MAPVIEWER, by itself, creates a new MAPVIEWER or raises the existing
%      singleton*.
%
%      H = MAPVIEWER returns the handle to a new MAPVIEWER or the handle to
%      the existing singleton*.
%
%      MAPVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAPVIEWER.M with the given input arguments.
%
%      MAPVIEWER('Property','Value',...) creates a new MAPVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MapViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MapViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MapViewer

% Last Modified by GUIDE v2.5 29-Nov-2016 15:10:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MapViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @MapViewer_OutputFcn, ...
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


% --- Executes just before MapViewer is made visible.
function MapViewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MapViewer (see VARARGIN)

% Choose default command line output for MapViewer
handles.output = hObject;

handles.Pri=varargin{1};
handles.SecDirPath=varargin{2};

% Update handles structure
guidata(hObject, handles);

% Load global variables
global IfSecondaryLoad;
global IfZCorrelated;
global SourceType;
global DataType;
global IfInterpolate;
global ScaleString;
global IfHydrology;
global year;
global DataNumber;
global minY;
global IfHori;
% global water;

% Set default values
IfHori=0;
year=0;
IfSecondaryLoad=0;
IfZCorrelated=0;
SourceType=3;
DataType=1;
IfInterpolate=0;
IfHydrology=0;

% Set slidebar range
minY=9999;
maxY=0;
for i=1:1:DataNumber
    if handles.Pri{i}.decimalyear(1)<minY
        minY=handles.Pri{i}.decimalyear(1);
    end
    if handles.Pri{i}.decimalyear(end)>maxY
        maxY=handles.Pri{i}.decimalyear(end);
    end
end
% geter=get(handles.TxtScale,'Extent');
% width=geter(3);
minY=ceil(minY);
maxY=floor(maxY);
% NumYear=maxY-minY+1;
ScaleString=[num2str(minY),'-',num2str(maxY)];
set(handles.TxtScale,'String',[ScaleString,'   ',num2str(minY)]);
set(handles.SLYear,'Min',minY);
set(handles.SLYear,'Max',maxY);
set(handles.SLYear,'Value',minY);
% UIWAIT makes MapViewer wait for user response (see UIRESUME)
% uiwait(handles.FigMapViewer);


% --- Outputs from this function are returned to the command line.
function varargout = MapViewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in PMShow.
function PMShow_Callback(hObject, eventdata, handles)
% hObject    handle to PMShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PMShow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PMShow
global SourceType;
global minY;
global year;
SourceType=get(hObject,'Value');
switch SourceType
    case 1
        SwitchSliderEnable(handles,'on');
        set(handles.SLYear,'Min',2002);
        set(handles.SLYear,'Value',2002);        
    case 2
        SwitchSliderEnable(handles,'on');
    case 5
        SwitchSliderEnable(handles,'on');
        set(handles.SLYear,'Min',minY);  
    case 10
        SourceType=10;
        SwitchSliderEnable(handles,'on');
        set(handles.SLYear,'Min',2002);
        set(handles.SLYear,'Value',2002);
    case 11
        SourceType=11;
        SwitchSliderEnable(handles,'on');
        set(handles.SLYear,'Min',2002);
        set(handles.SLYear,'Value',2002);
    otherwise        
        SwitchSliderEnable(handles,'off');
        year=0;
end


% --- Executes during object creation, after setting all properties.
function PMShow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PMShow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in PBShowMap.
function PBShowMap_Callback(hObject, eventdata, handles)
% hObject    handle to PBShowMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SecData;
global SourceType;
global IfSecondaryLoad;
global StationCoor;
global IfHydrology;
global water;
global IfWaterRead;
% global DataNumber;
IfHydrology=0;
Draw=1;
if IfSecondaryLoad==0
    LoadSecondaryData(handles.SecDirPath,handles.Pri);
    StationCoor=importdata('StationLatLonHig.txt');
    IfSecondaryLoad=1;
end
switch SourceType
    case 1 %Temporarily for outputs
        ShowHori(handles.Pri);
        
    case 2 %Temporarily for GRACE amplitude outputs.
        GRACEShow(SecData); 
        
    case 3
        ZCorrelate(handles.Pri,SecData);%Calculate the coorelation

    case 4
        WRMSRatio(handles.Pri,SecData);
        
    case 6
        if IfWaterRead==0
            msgbox('Please load water data first!');
            Draw=0;
        else
            CorrWater(handles.Pri,water);
        end
        
    case 7        
        if IfWaterRead==0
            msgbox('Please load water data first!');
            Draw=0;
        else
            PriAPD(handles.Pri,water);
        end
        
    case 8
        if IfWaterRead==0
            msgbox('Please load water data first!');
            Draw=0;
        else
            SecAPD(SecData,water);
        end
        
    case 9
        PriAndSecAPD(handles.Pri);
        
    case 12
        FreqRankMap(handles.Pri);
        
    case 13
        FreqPercentage(handles.Pri);
        
    case 14
        Draconic(handles.Pri);
        
    case 15
        FPminusDR(handles.Pri);
        
    case 16
        if IfWaterRead==0
            msgbox('Please load water data first!');
            Draw=0;
        else
            SecWCorr(SecData,water)
        end                
end
% axes(handles.MainAxle);
if Draw==1
    ShowMap();%Interpolate the wanted plot and show it.
    ifscreenshot=questdlg('Save screenshot?','Screenshot','Yes','No','Yes');
    if strcmp(ifscreenshot,'Yes')==1
        h = handles.FigMapViewer; %创建一个Figure，并返回其句柄
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
    end
end


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


% % --- Executes when selected object is changed in UIPSource.
% function UIPSource_SelectionChangeFcn(hObject, eventdata, handles)
% % hObject    handle to the selected object in UIPSource 
% % eventdata  structure with the following fields (see UIBUTTONGROUP)
% %	EventName: string 'SelectionChanged' (read only)
% %	OldValue: handle of the previously selected object or empty if none was selected
% %	NewValue: handle of the currently selected object
% % handles    structure with handles and user data (see GUIDATA)
% global SourceType;
% global minY;
% switch hObject
%     case handles.RBPri
%         SourceType=1;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBSec
%         SourceType=2;
%         SwitchSliderEnable(handles,'on');
%     case handles.RBCorrelation
%         SourceType=3;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBWRMS
%         SourceType=4;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBAandW
%         SourceType=5;
%         SwitchSliderEnable(handles,'on');
%         set(handles.SLYear,'Min',minY);        
%     case handles.RBCorrWater
%         SourceType=6;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBPriAPD
%         SourceType=7;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBSecAPD
%         SourceType=8;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBPriAndSecAPD
%         SourceType=9;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBPriAnPD
%         SourceType=10;
%         SwitchSliderEnable(handles,'on');
%         set(handles.SLYear,'Min',2002);
%         set(handles.SLYear,'Value',2002);
%     case handles.RBSecAnPD
%         SourceType=11;
%         SwitchSliderEnable(handles,'on');
%         set(handles.SLYear,'Min',2002);
%         set(handles.SLYear,'Value',2002);
%     case handles.RBFreqRank
%         SourceType=12;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBFreqPer
%         SourceType=13;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBDrac
%         SourceType=14;
%         SwitchSliderEnable(handles,'off');
%     case handles.RBFPmDrac
%         SourceType=15;
%         SwitchSliderEnable(handles,'off');
%         
% end;

% --- Executes when selected object is changed in UIPType.
function UIPType_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in UIPType 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

global DataType;
if hObject==handles.RBxyz
    DataType=1;
else
    DataType=2;
end

function ShowMap()%Interpolate the wanted plot and show it.
% cla;
global shower;
global IfInterpolate;
global IfHydrology;
global IfHori;
% global HydroHandle;
    Border=shaperead('F:\Matlab Workspace\Ohio\Shapefile\2DDissolvedStateBorder\2DDissolvedStateBorder.shp');
    border=plot([Border.X],[Border.Y],'-');
    set(border,'HitTest','on');
    set(border,'ButtonDownFcn',@MainAxle_ButtonDownFcn);
    hold on
if IfHydrology==0
    cla;
%     geoshow('F:\Matlab Workspace\Ohio\Shapefile\2DDissolvedStateBorder\2DDissolvedStateBorder.shp');
    Border=shaperead('F:\Matlab Workspace\Ohio\Shapefile\2DDissolvedStateBorder\2DDissolvedStateBorder.shp');
    border=plot([Border.X],[Border.Y],'-');
    set(border,'HitTest','on');
    set(border,'ButtonDownFcn',@MainAxle_ButtonDownFcn);
    hold on
else
%     HydroCData=get(HydroHandle,'CData');
%     HydroCData=bsxfun(@minus,HydroCData,min(HydroCData))/(max(HydroCData)-min(HydroCData));
%     HydroCData=HydroCData/max(HydroCData);
%     HydroCData=bsxfun(@rdivide,bsxfun(@minus,HydroCData,min(HydroCData)),(max(HydroCData)-min(HydroCData)));
end
colormap(jet);
if IfInterpolate==1
    % [X,Y,COR]=griddata(shower(:,1),shower(:,2),shower(:,3),linspace(min(shower(:,1)),max(shower(:,1)))',linspace(min(shower(:,2)),max(shower(:,2))),'v4');
    theta=[10,10];lob=[1e-1,1e-1];upb=[20,20];
    [dmodel, ~] =dacefit(shower(:,1:2), shower(:,3), @regpoly0, @corrgauss, theta, lob, upb);
    X = gridsamp([-86 38;-80 44], 100);
    [YX, ~] = predictor(X, dmodel);
    X1 = reshape(X(:,1),100,100); X2 = reshape(X(:,2),100,100);
    YX = reshape(YX, size(X1));
    l=length(shower(:,1))+1;
    outputer=cell(l+1,3);
    outputer{1,1}='Latitude';
    outputer{1,2}='Longitude';
    outputer{1,3}='AverageHeight';
    for i=2:1:l
        outputer{i,1}=shower(i-1,1);
        outputer{i,2}=shower(i-1,2);
        outputer{i,3}=shower(i-1,3);
    end
    xlswrite('ExportedHeight.xlsx',outputer);
    
%     contourf(X1,X2,YX);
%     image(X1,X2,YX);
    pcolor(X1,X2,YX);
    shading interp
    colorbar();
else if IfHori==0
%     hf1=figure();
%     colormap(jet);
%     scatter(shower(:,1),shower(:,2),50,shower(:,3),'d','fill');
%     colorbar();
%     f1=getframe(gcf);
%     close(hf1);
%     hold on;
%     imshow(f1.cdata);
    image=scatter(shower(:,1),shower(:,2),50,shower(:,3),'d','fill');
%     ScatterHandle=scatter(shower(:,1),shower(:,2),50,shower(:,3),'d','fill');
%     ScatterCData=get(ScatterHandle,'CData');
% %     ScatterCData=bsxfun(@minus,ScatterCData,min(ScatterCData))/(max(ScatterCData)-min(ScatterCData))+1;
%     ScatterCData=ScatterCData/max(ScatterCData)+1;
%     set(HydroHandle,'CData',HydroCData);
%     set(ScatterHandle,'CData',ScatterCData);
%     caxis([0,2]);
    colorbar();
    set(image,'HitTest','on');
    set(image,'ButtonDownFcn',@MainAxle_ButtonDownFcn);
    axis([-87,-79,37,43]);
    else
        IfHori=0;
        if length(shower)>1
            image=quiver(shower(:,1),shower(:,2),shower(:,3),shower(:,4),0.3);
            set(image,'HitTest','on');
            set(image,'ButtonDownFcn',@MainAxle_ButtonDownFcn);        
        end
        axis([-88,-78,35,43]);
    end
end
set(gca,'ButtonDownFcn',@(hObject,eventdata)MapViewer('MainAxle_ButtonDownFcn',hObject,eventdata,guidata(hObject)));

function ShowHori(PriData)
global shower;
global StationCoor;
global DataNumber;
global ThisdataPri;
global number;
global year;
global IfHori;
IfHori=1;
k=1;
hwait=waitbar(0,'Calculating...');
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    ThisdataPri=PriData{i};
    number=i;
    ReadThisSec();
    DandM();
    if ThisdataPri.decimalyear(1)<year && floor(ThisdataPri.decimalyear(end))>year
        while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
            k=k+1;
        end
        Hori(i,2)=StationCoor.data(k,1);
        Hori(i,1)=StationCoor.data(k,2);
        [Hori(i,3),Hori(i,4)]=GetAnnualHori(year);
    end
end
close(hwait);
if k>1
    shower=Hori;
else
    shower=0;
end


function ZCorrelate(PriData,SecData)%Calculate the coorelation
% global ZCorrelation;
global DataNumber;
global shower;
global StationCoor;
ZCorrelation=zeros(DataNumber,3);
j=1;
k=1;
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,SecData{j}.stationame)==0
        j=j+1;
    end
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    ZCorrelation(i,2)=StationCoor.data(k,1);
    ZCorrelation(i,1)=StationCoor.data(k,2);
    ThisDataPri.decimalyear=PriData{i}.decimalyear;
    ThisDataPri.deltax=detrend(PriData{i}.deltax);
    ThisDataPri.deltay=detrend(PriData{i}.deltay);
    ThisDataPri.deltaz=detrend(PriData{i}.deltaz);
    ThisDataPri.x=detrend(PriData{i}.x);
    ThisDataPri.y=detrend(PriData{i}.y);
    ThisDataPri.z=detrend(PriData{i}.z);
    ThisDataSec.decimalyear=SecData{j}.decimalyear;
    ThisDataSec.deltax=detrend(SecData{j}.deltax);
    ThisDataSec.deltay=detrend(SecData{j}.deltay);
    ThisDataSec.deltaz=detrend(SecData{j}.deltaz);
    ThisDataSec.x=detrend(SecData{j}.x);
    ThisDataSec.y=detrend(SecData{j}.y);
    ThisDataSec.z=detrend(SecData{j}.z);
    [ThisDataPri, ThisDataSec]=StackTime(ThisDataPri,ThisDataSec,1);
    corrmatrix=corrcoef(ThisDataPri.z,ThisDataSec.z);
    ZCorrelation(i,3)=corrmatrix(1,2);
end
close(hwait);%close the waitbar.
shower=ZCorrelation;
% ZCorrelation(DataNumber+1,1)=8*10^5;
% ZCorrelation(DataNumber+1,2)=-5.1*10^6;
% ZCorrelation(DataNumber+1,3)=-1;

function WRMSRatio(PriData,SecData) %Calculate WRMSed correlation
global WRatio;
global DataNumber;
global shower;
global StationCoor;
WRatio=zeros(DataNumber,3);
j=1;
k=1;
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');

    while strcmp(PriData{i}.stationame,SecData{j}.stationame)==0
        j=j+1;
    end
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    WRatio(i,2)=StationCoor.data(k,1);
    WRatio(i,1)=StationCoor.data(k,2);
    ThisDataPri.decimalyear=PriData{i}.decimalyear;
    ThisDataPri.deltax=detrend(PriData{i}.deltax);
    ThisDataPri.deltay=detrend(PriData{i}.deltay);
    ThisDataPri.deltaz=detrend(PriData{i}.deltaz);
    ThisDataPri.x=detrend(PriData{i}.x);
    ThisDataPri.y=detrend(PriData{i}.y);
    ThisDataPri.z=detrend(PriData{i}.z);
    ThisDataPri.sigmax=PriData{i}.sigmax;
    ThisDataPri.sigmay=PriData{i}.sigmay;
    ThisDataPri.sigmaz=PriData{i}.sigmaz;
    ThisDataSec.decimalyear=SecData{j}.decimalyear;
    ThisDataSec.deltax=detrend(SecData{j}.deltax);
    ThisDataSec.deltay=detrend(SecData{j}.deltay);
    ThisDataSec.deltaz=detrend(SecData{j}.deltaz);
    ThisDataSec.x=detrend(SecData{j}.x);
    ThisDataSec.y=detrend(SecData{j}.y);
    ThisDataSec.z=detrend(SecData{j}.z);
    [ThisDataPri, ThisDataSec]=StackTime(ThisDataPri,ThisDataSec,2);
    WRatio(i,3)=1-WRMS(ThisDataPri.z-ThisDataSec.z,ThisDataPri.sigmaz,mean(ThisDataPri.z-ThisDataSec.z))/WRMS(ThisDataPri.z,ThisDataPri.sigmaz,mean(ThisDataPri.z));
%     i=i;
end
close(hwait);%close the waitbar.
shower=WRatio;


% --- Executes on button press in PBShowHydro.
function PBShowHydro_Callback(hObject, eventdata, handles)
% hObject    handle to PBShowHydro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% [filename,~]=uigetfile('Hydrological File (*.
cla;
global IfHydrology;
global year;
global HydroMap;
% global StationCoor;
% global HydroHandle;
% hf1=figure();
% geoshow('F:\Matlab Workspace\Ohio\Shapefile\2DDissolvedStateBorder\2DDissolvedStateBorder.shp');
% % hold on
% f1=getframe(gcf);
% close(hf1);
% imshow(f1.cdata,'InitialMagnification',500);
% hold on;
% YLim=get(handles.MainAxle,'YLim');
HydroMap=HydroSort(year,43.5,37.5,279.5,273.5);
% HydroHandle=HydroFigure(HydroMap);
% hf2=figure();
HydroFigure(HydroMap);
% f2=getframe(gcf);
% close(hf2);
% imshow(f2.cdata);
% hold on
IfHydrology=1;
% freezeColors;
% imshow(HydroHandle.cdata);
ShowMap();
% [X,Y,HY]=griddata(HydroMap(:,1),HydroMap(:,2),HydroMap(:,3),linspace(min(HydroMap(:,1)),max(HydroMap(:,1)))',linspace(min(HydroMap(:,2)),max(HydroMap(:,2))),'v4');
% %     contourf(X1,X2,YX);
% %     image(X1,X2,YX);
% pcolor(X,Y,HY);
% shading interp


% --- Executes on slider movement.
function SLYear_Callback(hObject, eventdata, handles)
% hObject    handle to SLYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global year;
global ScaleString;
year=get(hObject,'Value');
if rem(year,1)~=0
    year=round(year);
    set(hObject,'Value',year);
end
set(handles.TxtScale,'String',[ScaleString,'   ',num2str(year)]);

% --- Executes during object creation, after setting all properties.
function SLYear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in PBYearSet.
function PBYearSet_Callback(hObject, eventdata, handles)
% hObject    handle to PBYearSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global year;
global DataNumber;
global shower;
global StationCoor;
global SourceType;
global water;
global SecData;
global number;
global ThisdataPri;
% global ThisDataSec;

switch SourceType;
    case 5 %Annual A&W
        j=1;
        k=1;
        for i=1:1:DataNumber
            if handles.Pri{i}.decimalyear(1)<year && floor(handles.Pri{i}.decimalyear(end))>year
                while strcmp(handles.Pri{i}.stationame,StationCoor.textdata{k})==0
                    k=k+1;
                end
                Amplitudes(j,1)=StationCoor.data(k,2);
                Amplitudes(j,2)=StationCoor.data(k,1);
                number=i;
                DandM();
%                 CurrentGPS=DandSTBlind(handles.Pri{i},-1);
                CurrentGPS=ThisdataPri;
                yearz=PeriodFind(CurrentGPS,year);
                %         Amplitudes(j,3)=mean(TopN(yearz,30,1))-mean(TopN(yearz,30,0));
%                 Amplitudes(j,3)=max(yearz)-min(yearz);
                Amplitudes(j,3)=max(yearz)-mean(CurrentGPS.z);
                j=j+1;
            end
        end
        shower=Amplitudes;
        
    case 10 %Primary annual phase difference
        j=1;
        k=1;
        for i=1:1:DataNumber
            if handles.Pri{i}.decimalyear(1)<year && floor(handles.Pri{i}.decimalyear(end))>year
                while strcmp(handles.Pri{i}.stationame,StationCoor.textdata{k})==0
                    k=k+1;
                end
                [ThisGPS,ThisWater]=GWDandM(handles.Pri{i},StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water));
                if ThisGPS.decimalyear(1)<year && floor(ThisGPS.decimalyear(end))>year
                    PPD(j,1)=StationCoor.data(k,2);
                    PPD(j,2)=StationCoor.data(k,1);
                    ThisGPS.z=detrend(ThisGPS.z);
                    [HighDif,LowDif]=PhaseDif(ThisGPS,ThisWater,year);
                    PPD(j,3)=(abs(HighDif)+abs(LowDif))/2;
                    j=j+1;
                end
            end
        end
        shower=PPD;     
        
    case 11 %Secondary annual phase difference
        j=1;
        k=1;
        for i=1:1:DataNumber
            if handles.Pri{i}.decimalyear(1)<year && floor(handles.Pri{i}.decimalyear(end))>year
                while strcmp(handles.Pri{i}.stationame,StationCoor.textdata{k})==0
                    k=k+1;
                end
                SPD(j,1)=StationCoor.data(k,2);
                SPD(j,2)=StationCoor.data(k,1);
                [HighDif,LowDif]=PhaseDif(SecData{i},StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water),year);
                SPD(j,3)=(abs(HighDif)+abs(LowDif))/2;
                j=j+1;
            end
        end
        shower=SPD;     
        
end


% --- Executes during object creation, after setting all properties.
function TxtScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxtScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in PBExport.
function PBExport_Callback(hObject, eventdata, handles)
% hObject    handle to PBExport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shower;
global HydroMap;
[FileName, PathName]=uiputfile({'*.xls','XLS (*.xls)'},'export');
l=length(shower(:,1))+1;
if length(shower(1,:))==3
    outputer=cell(l+1,3);
    outputer{1,1}='Latitude';
    outputer{1,2}='Longitude';
    outputer{1,3}='SourceType';
    for i=2:1:l
        outputer{i,1}=shower(i-1,1);
        outputer{i,2}=shower(i-1,2);
        outputer{i,3}=shower(i-1,3);
    end
else
    outputer=cell(l+1,6);
    outputer{1,1}='Latitude';
    outputer{1,2}='Longitude';
    outputer{1,3}='u';
    outputer{1,4}='v';
    outputer{1,5}='distance';
    outputer{1,6}='angle';
    for i=2:1:l
        outputer{i,1}=shower(i-1,1);
        outputer{i,2}=shower(i-1,2);
        outputer{i,3}=shower(i-1,3);
        outputer{i,4}=shower(i-1,4);
        [outputer{i,5},outputer{i,6}]=RectandPolar(0,shower(i-1,3),shower(i-1,4));
    end    
end
xlswrite([PathName,FileName],outputer);
l=length(HydroMap(:,1))+1;
outputer=cell(l+1,3);
outputer{1,1}='Latitude';
outputer{1,2}='Longitude';
outputer{1,3}='Water';
for i=2:1:l
    outputer{i,1}=HydroMap(i-1,1);
    outputer{i,2}=HydroMap(i-1,2);
    outputer{i,3}=HydroMap(i-1,3);
end
xlswrite([PathName,FileName(1:end-4),'Water.xls'],outputer);

function GRACEShow(SecData)
global shower;
global DataNumber;
global StationCoor;
global year;
j=1;
k=1;
for i=1:1:DataNumber
    if SecData{i}.decimalyear(1)<year && floor(SecData{i}.decimalyear(end))>year
        while strcmp(SecData{i}.stationame,StationCoor.textdata{k})==0
            k=k+1;
        end
        Amplitudes(j,1)=StationCoor.data(k,2);
        Amplitudes(j,2)=StationCoor.data(k,1);
        yearz=PeriodFind(SecData{i},year);
        Amplitudes(j,3)=max(yearz)-min(yearz);
        j=j+1;
    end
end
shower=Amplitudes;

function CorrWater(PriData,water)
global shower;
global DataNumber;
global StationCoor;
% j=1;
k=1;
hwait=waitbar(0,'Calculating...');%set up a waitbar.
CorrWater=ones(DataNumber,3);
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
%     while strcmp(PriData{i}.stationame,SecData{j}.stationame)==0
%         j=j+1;
%     end
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    CorrWater(i,2)=StationCoor.data(k,1);
    CorrWater(i,1)=StationCoor.data(k,2);
    ThisDataPri.decimalyear=PriData{i}.decimalyear;
    ThisDataPri.x=PriData{i}.x;
    ThisDataPri.y=PriData{i}.y;
    ThisDataPri.z=detrend(PriData{i}.z);
    ThisDataSec=StationWaterExtract(CorrWater(i,2),CorrWater(i,1),water);
    [ThisDataPri,ThisDataSec]=GWStackTime(ThisDataPri,ThisDataSec);
    corrmatrix=corrcoef(ThisDataPri.z/max(abs(ThisDataPri.z)),ThisDataSec.LWE/max(abs(ThisDataSec.LWE)));
    CorrWater(i,3)=corrmatrix(1,2);
end
close(hwait);%close the waitbar.
shower=CorrWater;

function PriAPD(PriData,water)
global shower;
global DataNumber;
global StationCoor;
k=1;
hwait=waitbar(0,'Calculating...');%set up a waitbar.
AvgPhase=ones(DataNumber,3);

for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    AvgPhase(i,1)=StationCoor.data(k,2);
    AvgPhase(i,2)=StationCoor.data(k,1);
    [ThisGPS,Thiswater]=GWDandM(PriData{i},StationWaterExtract(AvgPhase(i,1),AvgPhase(i,2),water));
    AvgPhase(i,3)=mean(abs(StationPhaseDif(ThisGPS,1,Thiswater,1)));
end
close(hwait);
shower=AvgPhase;

function SecAPD(SecData,water)
global shower;
global DataNumber;
global StationCoor;

k=1;
AvgPhase=ones(DataNumber,3);
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(SecData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    AvgPhase(i,1)=StationCoor.data(k,2);
    AvgPhase(i,2)=StationCoor.data(k,1);
    ThisWater=StationWaterExtract(AvgPhase(i,2),AvgPhase(i,1),water);
    AvgPhase(i,3)=mean(abs(StationPhaseDif(SecData{i},2,ThisWater,1)));
end
close(hwait);
shower=AvgPhase;

function PriAndSecAPD(PriData)
global DataNumber;
global StationCoor;
global shower;
global number
tempnumber=number;
k=1;
hwait=waitbar(0,'Calculating...');%set up a waitbar.
AvgPhase=ones(DataNumber,3);
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    AvgPhase(i,1)=StationCoor.data(k,2);
    AvgPhase(i,2)=StationCoor.data(k,1);
    number=i;
    ReadThisSec();
    AvgPhase(i,3)=mean(abs(StationGGPhaseDif()));
end
close(hwait);
shower=AvgPhase;
number=tempnumber;


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function FigMapViewer_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to FigMapViewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [X,Y]=ginput(1);
% Z=X;
% a=gco;
% b=a;


function MainAxle_ButtonDownFcn(hObject,eventdata,handles)
global shower;
% global DataNumber;
global number;

%Find closest station
[X,Y]=ginput(1);
minD=9999;
for i=1:1:length(shower(:,3))
    d=sqrt((X-shower(i,1))^2+(Y-shower(i,2))^2);
    if d<minD
        minD=d;
        number=i;
    end
end

%Show corresponding time series in main frame
GPACE=findobj('Tag','GPSMain');
GPACEhandle=guidata(GPACE);
SB=GPACEhandle.Stationbox;
set(SB,'Value',number);
feval(@(hObject,eventdata)GPSWORK('Stationbox_Callback',hObject,eventdata,guidata(hObject)),SB,eventdata);

%Show frequency or phase analysis result in Analyzer
DA=findobj('Tag','DataAnalyzer');
DAhandle=guidata(DA(1));
PM=DAhandle.PMStationNames;
set(PM,'Value',number);
feval(@(hObject,eventdata)DataAnalyzer('PMStationNames_Callback',hObject,eventdata,guidata(hObject)),PM,eventdata);
% axes(hObject);

function FreqRankMap(PriData)
global shower;
global DataNumber;
global StationCoor;
k=1;
hwait=waitbar(0,'Calculating...');%set up a waitbar.
FRM=ones(DataNumber,3);
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    FRM(i,1)=StationCoor.data(k,2);
    FRM(i,2)=StationCoor.data(k,1);
    [PF,~,~]=GetSingleFreq(i,0);
    [Peaks,POSs]=findpeaks(PF.Ampl);
    [~,ranks]=sort(Peaks,1,'descend');
    for j=2:1:length(POSs)-1
        if abs(POSs(j)-87)<abs(POSs(j-1)-87) &&abs(POSs(j)-87)<abs(POSs(j+1)-87)
            for l=1:1:length(ranks)
                if ranks(l)==j
                    FRM(i,3)=l;
                end
            end
        end
    end
end
close(hwait);
shower=FRM;

function FreqPercentage(PriData)
global shower;
global DataNumber;
global StationCoor;
k=1;
FPM=ones(DataNumber,3);
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    FPM(i,1)=StationCoor.data(k,2);
    FPM(i,2)=StationCoor.data(k,1);
    [PF,~,~]=GetSingleFreq(i,0);
    [Peaks,POSs]=findpeaks(PF.Ampl);
%     [~,ranks]=sort(Peaks,1,'descend');
    for j=2:1:length(POSs)-1
        if abs(POSs(j)-87)<abs(POSs(j-1)-87) &&abs(POSs(j)-87)<abs(POSs(j+1)-87)
            FPM(i,3)=Peaks(j)/sum(PF.Ampl);
        end
    end
end
close(hwait);
shower=FPM;

function Draconic(PriData)
global shower;
global DataNumber;
global StationCoor;
k=1;
Dra=ones(DataNumber,3);
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    Dra(i,1)=StationCoor.data(k,2);
    Dra(i,2)=StationCoor.data(k,1);
    [PF,~,~]=GetSingleFreq(i,1);
    [~,POSs]=findpeaks(PF.Ampl);
%     [~,ranks]=sort(Peaks,1,'descend');
    for j=2:1:length(POSs)-1
        if abs(POSs(j)-87)<abs(POSs(j-1)-87) &&abs(POSs(j)-87)<abs(POSs(j+1)-87)
            Dra(i,3)=PF.Freq(POSs(j))-1;
        end
    end
end
close(hwait);
shower=Dra;

function FPminusDR(PriData)
global shower;
global DataNumber;
global StationCoor;
k=1;
FPmDR=ones(DataNumber,3);
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(PriData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    FPmDR(i,1)=StationCoor.data(k,2);
    FPmDR(i,2)=StationCoor.data(k,1);
    [PF,~,~]=GetSingleFreq(i,1);
    [Peaks,POSs]=findpeaks(PF.Ampl);
%     [~,ranks]=sort(Peaks,1,'descend');
    for j=2:1:length(POSs)-1
        if abs(POSs(j)-87)<abs(POSs(j-1)-87) &&abs(POSs(j)-87)<abs(POSs(j+1)-87)
            FP=Peaks(j)/sum(PF.Ampl);
            DR=PF.Freq(POSs(j))-1;
            FPmDR(i,3)=FP*10-DR;
        end
    end
end
close(hwait);
shower=FPmDR;

function SecWCorr(SecData,water)
global shower;
global DataNumber;
global StationCoor;

k=1;
SWC=ones(DataNumber,3);
hwait=waitbar(0,'Calculating...');%set up a waitbar.
for i=1:1:DataNumber
    waitbar(i/DataNumber,hwait,'Calculating...');
    while strcmp(SecData{i}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    SWC(i,1)=StationCoor.data(k,2);
    SWC(i,2)=StationCoor.data(k,1);
    ThisWater=StationWaterExtract(SWC(i,2),SWC(i,1),water);
    [ThisSec,ThisWater]=GRWMatchtime(SecData{i},ThisWater);
    corrmatrix=corrcoef(ThisSec.z/max(abs(ThisSec.z)),ThisWater.LWE/max(abs(ThisWater.LWE)));
    SWC(i,3)=corrmatrix(1,2);
end
close(hwait);
shower=SWC;