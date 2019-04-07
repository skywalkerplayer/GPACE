function varargout = DataAnalyzer(varargin)
% DATAANALYZER MATLAB code for DataAnalyzer.fig
%      DATAANALYZER, by itself, creates a newalgorithmset DATAANALYZER or raises the existing
%      singleton*.
%
%      H = DATAANALYZER returns the handle to a newalgorithmset DATAANALYZER or the handle to
%      the existing singleton*.
%
%      DATAANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAANALYZER.M with the given input arguments.
%
%      DATAANALYZER('Property','Value',...) creates a newalgorithmset DATAANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DataAnalyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DataAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DataAnalyzer

% Last Modified by GUIDE v2.5 09-Dec-2017 18:43:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DataAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @DataAnalyzer_OutputFcn, ...
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


% --- Executes just before DataAnalyzer is made visible.
function DataAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DataAnalyzer (see VARARGIN)

% Choose default command line output for DataAnalyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DataAnalyzer wait for user response (see UIRESUME)
% uiwait(handles.DataAnalyzer);

global namelist;
global DataNumber;
global IfPS;
global IfPW;
global IfSW;
global IfPF;
global IfSF;
global IfWF;
global IfPAA;
global IfSAA;
global IfWAA;
global IfAlSelect;
global AlgorithmList;
global AlNameList;
IfPS=0;
IfPW=0;
IfSW=0;
IfPF=0;
IfSF=0;
IfWF=0;
IfPAA=0;
IfSAA=0;
IfWAA=0;
IfAlSelect=0;
set(handles.PMStationNames,'String',[namelist,'|TOTAL']);
set(handles.PMStationNames,'Value',DataNumber);
Empty.Name='';
Empty.Function='';
AlgorithmList=Empty;
AlNameList='';


% --- Outputs from this function are returned to the command line.
function varargout = DataAnalyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in LBStationNames.
function LBStationNames_Callback(hObject, eventdata, handles)
% hObject    handle to LBStationNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LBStationNames contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LBStationNames


% --- Executes during object creation, after setting all properties.
function LBStationNames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LBStationNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PMStationNames.
function PMStationNames_Callback(hObject, eventdata, handles)
% hObject    handle to PMStationNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PMStationNames contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PMStationNames
global number;
global IfPS;
global IfSW;
global IfPW;
global IfPF;
global IfSF;
global IfWF;
global IfPAA;
global IfSAA;
global IfWAA;
global IfPriDeModel;
global IfAlSelected;
number=get(hObject,'Value');
if ((IfPS==1)||(IfSW==1))||(IfPW==1)
    GetPDs();
end
number=get(hObject,'Value');
if ((IfPF==1)||(IfSF==1))||(IfWF==1)
    GetFreqs();
end
number=get(hObject,'Value');
if ((IfPAA==1)||(IfSAA==1))||(IfWAA==1)
    GetAAs();
end
number=get(hObject,'Value');
if IfPriDeModel==1
    GetPDMFreq();
end
number=get(hObject,'Value');
if IfAlSelected==1
    Calc();
end
number=get(hObject,'Value');
ShowStation(handles);

function ShowStation(handles)
global IfPS;
global IfSW;
global IfPW;
global IfPF;
global IfSF;
global IfWF;
global IfPAA;
global IfSAA;
global IfWAA;
global IfPriDeModel;
% global number;
global PDPriSec;
global PDPriWater;
global PDSecWater;
global PF;
global SF;
global WF;
global PAA;
global SAA;
global WAA;
global PDMF;
global IfAlSelected;
global ResultPri;
global ResultSec;
global ResultWater;

global legend1;
global legend2;
global legend3;
global legendposition;

axes(handles.MainAxes);
cla;
% MarkerEdgeColors = jet(52);
if IfPS
    plot(handles.MainAxes,PDPriSec.time,PDPriSec.PD,'b');
    axis([2007,2015,-inf,inf]);
end
hold on;
if IfPW
    plot(handles.MainAxes,PDPriWater.time,PDPriWater.PD,'r');
    axis([2007,2015,-inf,inf]);
end
hold on;
if IfSW
    plot(handles.MainAxes,PDSecWater.time,PDSecWater.PD,'g');
    axis([2007,2015,-inf,inf]);
end
hold off;
if IfPF
    plot(handles.MainAxes,PF.Freq,PF.Ampl,'r');
    axis([0,6,-inf,inf]);
end
hold on;
if IfSF
    plot(handles.MainAxes,SF.Freq,SF.Ampl,'g');
    axis([0,6,-inf,inf]);
end
hold on;
if IfWF
    plot(handles.MainAxes,WF.Freq,WF.Ampl,'b');
    axis([0,6,-inf,inf]);
end
hold off;
if IfPAA
    plot(handles.MainAxes,PAA.year,PAA.Ampl);
    axis([2007,2015,-inf,inf]);
end
hold on;
if IfSAA
    plot(handles.MainAxes,SAA.year,SAA.Ampl);
    axis([2007,2015,-inf,inf]);
end
hold on;
if IfWAA
    plot(handles.MainAxes,WAA.year,WAA.Ampl);
    axis([2007,2015,-inf,inf]);
end
hold off;
if IfPriDeModel
    if IfPF
        plot(handles.MainAxes,PF.Freq,PF.Ampl);
        hold on;
    end
    plot(handles.MainAxes,PDMF.Freq,PDMF.Ampl);
    hold off;
end
if IfAlSelected
    plot(handles.MainAxes,ResultPri.year,ResultPri.Ampl,'r');
    hold on;
    plot(handles.MainAxes,ResultSec.year,ResultSec.Ampl,'g');
    hold on;
    plot(handles.MainAxes,ResultWater.year,ResultWater.Ampl,'b');
    hold off;
%     plotyy(handles.MainAxes,ResultSec.year,ResultSec.Ampl,'g',ResultWater.year,ResultWater.Ampl,'b');
%     hold off;
end
legend(legend1,legend2,legend3,'Location',legendposition);
xlabel('Year');

% --- Executes during object creation, after setting all properties.
function PMStationNames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PMStationNames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function DataAnalyzer_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to DataAnalyzer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function DataAnalyzer_CreateFcn(hObject,eventdata,handles)
% hObject    handle to DataAnalyzer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PBOutputAll.
function PBOutputAll_Callback(hObject, eventdata, handles)
% hObject    handle to PBOutputAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DataNumber;
global StationCoor;
global datas;
global minY;
global maxY;
[FileName, PathName]=uiputfile({'*.xlsx','XLSX (*.xlsx)'},'export');
outputer=cell(DataNumber+1,maxY-minY+3);
outputer{1,1}='Station Name';
outputer{1,2}='Longitude';
outputer{1,3}='Latitude';
for i=minY:1:maxY
    outputer{1,i-minY+4}=num2str(i);
    outputer{1,i-minY+4+maxY-minY+1}=[num2str(i),'water'];
end
k=1;
hwait=waitbar(0,'Writing...');
for i=2:1:DataNumber+1
    waitbar(i/(DataNumber+1),hwait,'Writing...');
    while strcmp(datas{i-1}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    outputer{i,1}=datas{i-1}.stationame;
    outputer{i,2}=StationCoor.data(k,1);
    outputer{i,3}=StationCoor.data(k,2);
    [ThisPAA,~,ThisWAA]=GetSingleAA(i-1);
    l=1;
    for j=minY:1:maxY
        if l<=length(ThisPAA.year) && ThisPAA.year(l)==j
            outputer{i,j-minY+4}=ThisPAA.Ampl(l);
            outputer{i,j-minY+4+maxY-minY+1}=ThisWAA.Ampl(l);
            l=l+1;
        end
    end
end
close(hwait);
xlswrite([PathName,FileName],outputer);
msgbox('Finished!');


% --- Executes on button press in CBPriSec.
function CBPriSec_Callback(hObject, eventdata, handles)
% hObject    handle to CBPriSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBPriSec
global IfPS;
IfPS=get(hObject,'Value');


% --- Executes on button press in CBPriWater.
function CBPriWater_Callback(hObject, eventdata, handles)
% hObject    handle to CBPriWater (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBPriWater
global IfPW;
IfPW=get(hObject,'Value');

% --- Executes on button press in CBSecWater.
function CBSecWater_Callback(hObject, eventdata, handles)
% hObject    handle to CBSecWater (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBSecWater
global IfSW;
IfSW=get(hObject,'Value');

function GetPDs()
global number;
global datas;
global water;
global ThisdataSec;
global PDPriSec;
global PDPriWater;
global PDSecWater;
global DataNumber;
global StationCoor;
global ThisdataPri;
global legend1;
global legend2;
global legend3;
global legendposition;
minY=9999;
maxY=0;
minY=ceil(minY);
maxY=floor(maxY);
if number>DataNumber %Chose 'Total'
    
%-------------------Set data structure---------------------%
    for i=1:1:DataNumber
        if datas{i}.decimalyear(1)<minY
            minY=datas{i}.decimalyear(1);
        end
        if datas{i}.decimalyear(end)>maxY
            maxY=datas{i}.decimalyear(end);
        end
    end
    minY=ceil(minY);
    maxY=floor(maxY);
    PDPriSec.time=(minY:0.5:maxY);
    PDPriWater.time=PDPriSec.time;
    PDSecWater.time=PDPriSec.time;
    PDPriSec.PD=zeros(1,length(PDPriSec.time));
    PDPriWater.PD=PDPriSec.PD;
    PDSecWater.PD=PDPriSec.PD;
    
%-------------------------Calculating Phase Difference(PD) for each station-----------------------------------    
    hwait=waitbar(0,'Adding PD...');
    for i=1:1:DataNumber
        waitbar(i/DataNumber,hwait,'Adding PD...');
        number=i;
        ThisdataPri=datas{number};
        ReadThisSec();
        k=1;
        while strcmp(ThisdataPri.stationame,StationCoor.textdata{k})==0
            k=k+1;
        end
        [ThisGPS,ThisWater]=GWDandM(ThisdataPri,StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water));
        [ThisPW.PD,ThisPW.time]=StationPhaseDif(ThisGPS,1,ThisWater,4);
        [ThisSW.PD,ThisSW.time]=StationPhaseDif(ThisdataSec,2,StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water),4);
        [~,~,ThisPS.PD,ThisPS.time]=StationGGPhaseDif();
        
%----------------------Calculating average phase difference for every year---------------------------------        
        for j=1:1:length(PDPriSec.time)
            if PDPriSec.time(j)==ThisPS.time(1)
                for k=j:1:j+length(ThisPS.PD)-1
                    PDPriSec.PD(k)=PDPriSec.PD(k)+ThisPS.PD(k-j+1);%Add phase difference of each station to total.
                end
            end
            if PDPriWater.time(j)==ThisPW.time(1)
                for k=j:1:j+length(ThisPW.PD)-1
                    PDPriWater.PD(k)=PDPriWater.PD(k)+ThisPW.PD(k-j+1);
                end
            end
            if PDSecWater.time(j)==ThisSW.time(1)
                for k=j:1:j+length(ThisSW.PD)-1
                    PDSecWater.PD(k)=PDSecWater.PD(k)+ThisSW.PD(k-j+1);
                end
            end
        end
    end
    close(hwait);
%     hwait=waitbar(0,'Averaging...');    
    for year=minY:1:maxY-1
        ThisYearSum=0;
        for i=1:1:DataNumber
            if datas{i}.decimalyear(1)<year && floor(datas{i}.decimalyear(end))>year
                ThisYearSum=ThisYearSum+1;
            end
        end
        PDPriSec.PD((year-minY+1)*2-1)=PDPriSec.PD((year-minY+1)*2-1)/ThisYearSum;
        PDPriSec.PD((year-minY+1)*2)=PDPriSec.PD((year-minY+1)*2)/ThisYearSum;        
        PDPriWater.PD((year-minY+1)*2-1)=PDPriWater.PD((year-minY+1)*2-1)/ThisYearSum;        
        PDPriWater.PD((year-minY+1)*2)=PDPriWater.PD((year-minY+1)*2)/ThisYearSum;
%         PDSecWater.PD((year-minY+1)*2-1)=PDSecWater.PD((year-minY+1)*2-1)/ThisYearSum; 
%         PDSecWater.PD((year-minY+1)*2)=PDSecWater.PD((year-minY+1)*2)/ThisYearSum; 
    end
    for year=minY:1:maxY-1
        ThisYearSum=0;
        for i=1:1:DataNumber
            number=i;
            ReadThisSec();
            if ThisdataSec.decimalyear(1)<year && floor(ThisdataSec.decimalyear(end))>year
                ThisYearSum=ThisYearSum+1;
            end
        end
        PDSecWater.PD((year-minY+1)*2-1)=PDSecWater.PD((year-minY+1)*2-1)/ThisYearSum; 
        PDSecWater.PD((year-minY+1)*2)=PDSecWater.PD((year-minY+1)*2)/ThisYearSum; 
    end
else  %Chose single station
    ReadThisSec();
    k=1;
    while strcmp(datas{number}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    [ThisGPS,ThisWater]=GWDandM(datas{number},StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water));
    [PDPriWater.PD,PDPriWater.time]=StationPhaseDif(ThisGPS,1,ThisWater,4);
    [PDSecWater.PD,PDSecWater.time]=StationPhaseDif(ThisdataSec,2,StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water),4);
    [~,~,PDPriSec.PD,PDPriSec.time]=StationGGPhaseDif();
end
legend1='GPS-GRACE';
legend2='GPS-GLDAS';
legend3='GRACE-GLDAS';
legendposition='SouthWest';


% --- Executes on button press in CBPriFreq.
function CBPriFreq_Callback(hObject, eventdata, handles)
% hObject    handle to CBPriFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBPriFreq
global IfPF;
IfPF=get(hObject,'Value');


% --- Executes on button press in CBSecFreq.
function CBSecFreq_Callback(hObject, eventdata, handles)
% hObject    handle to CBSecFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBSecFreq
global IfSF;
IfSF=get(hObject,'Value');


% --- Executes on button press in CBWaterFreq.
function CBWaterFreq_Callback(hObject, eventdata, handles)
% hObject    handle to CBWaterFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBWaterFreq
global IfWF;
IfWF=get(hObject,'Value');

function GetFreqs()
global number;
global DataNumber;
global PF;
global SF;
global WF;
global legend1;
global legend2;
global legend3;
global legendposition;
% global datas;
% global ThisdataSec;
% global water;
% global StationCoor;
if number>DataNumber
    [PF,SF,WF]=GetSingleFreq(1,1);
    PF.Ampl=PF.Ampl/DataNumber;
    SF.Ampl=SF.Ampl/DataNumber;
    WF.Ampl=WF.Ampl/DataNumber;
    hwait=waitbar(1/DataNumber,'Adding Amplitude...');
    for i=2:1:DataNumber
        waitbar(i/DataNumber,hwait,'Adding Amplitude...');
        [ThisPF,ThisSF,ThisWF]=GetSingleFreq(i,1);
        PF.Ampl=PF.Ampl+ThisPF.Ampl/DataNumber;
        SF.Ampl=SF.Ampl+ThisSF.Ampl/DataNumber;
        WF.Ampl=WF.Ampl+ThisWF.Ampl/DataNumber;
    end
    close(hwait);
else
    [PF,SF,WF]=GetSingleFreq(number,0);
end
legend1='GPS';
legend2='GRACE';
legend3='GLDAS';
legendposition='NorthEast';


% --- Executes on button press in CBPriAA.
function CBPriAA_Callback(hObject, eventdata, handles)
% hObject    handle to CBPriAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBPriAA
global IfPAA;
IfPAA=get(hObject,'Value');


% --- Executes on button press in CBSecAA.
function CBSecAA_Callback(hObject, eventdata, handles)
% hObject    handle to CBSecAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBSecAA
global IfSAA;
IfSAA=get(hObject,'Value');


% --- Executes on button press in CBWaterAA.
function CBWaterAA_Callback(hObject, eventdata, handles)
% hObject    handle to CBWaterAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBWaterAA
global IfWAA;
IfWAA=get(hObject,'Value');

function GetAAs()
global number;
global DataNumber;
global PAA;
global SAA;
global WAA;
global datas;
global minY;
global maxY;
global legend1;
global legend2;
global legend3;
global legendposition;
if number>DataNumber
    minY=9999;
    maxY=0;
    minY=ceil(minY);
    maxY=floor(maxY);
    for i=1:1:DataNumber
        if datas{i}.decimalyear(1)<minY
            minY=datas{i}.decimalyear(1);
        end
        if datas{i}.decimalyear(end)>maxY
            maxY=datas{i}.decimalyear(end);
        end
    end
    minY=ceil(minY);
    maxY=floor(maxY);
    PAA.year=(minY:1:maxY);
    SAA.year=PAA.year;
    WAA.year=PAA.year;
    PAA.Ampl=zeros(1,length(PAA.year));
    SAA.Ampl=PAA.Ampl;
    WAA.Ampl=PAA.Ampl;
    hwait=waitbar(1/DataNumber,'Adding Amplitude...');
    for i=1:1:DataNumber
        waitbar(i/DataNumber,hwait,'Adding Amplitude...');
        [ThisPAA,ThisSAA,ThisWAA]=GetSingleAA(i);
        for j=1:1:length(PAA.year)
            if PAA.year(j)==ThisPAA.year(1)
                for k=j:1:j+length(ThisPAA.Ampl)-1
                    PAA.Ampl(k)=PAA.Ampl(k)+ThisPAA.Ampl(k-j+1);
                end
            end
        end
        for j=1:1:length(SAA.year)
            if SAA.year(j)==ThisSAA.year(1)
                for k=j:1:j+length(ThisPAA.Ampl)-1
                    SAA.Ampl(k)=SAA.Ampl(k)+ThisSAA.Ampl(k-j+1);
                end
            end
        end
        for j=1:1:length(WAA.year)
            if WAA.year(j)==ThisWAA.year(1)
                for k=j:1:j+length(ThisWAA.Ampl)-1
                    WAA.Ampl(k)=WAA.Ampl(k)+ThisWAA.Ampl(k-j+1);
                end
            end
        end
    end
    close(hwait);
    for year=minY:1:maxY-1
        ThisYearSum=0;
        for i=1:1:DataNumber
            if datas{i}.decimalyear(1)<year && floor(datas{i}.decimalyear(end))>year
                ThisYearSum=ThisYearSum+1;
            end
        end
        PAA.Ampl(year-minY+1)=PAA.Ampl(year-minY+1)/ThisYearSum;
        SAA.Ampl(year-minY+1)=SAA.Ampl(year-minY+1)/ThisYearSum;
        WAA.Ampl(year-minY+1)=WAA.Ampl(year-minY+1)/ThisYearSum;
    end
    PAA.Ampl=PAA.Ampl/max(abs(PAA.Ampl));
    SAA.Ampl=SAA.Ampl/max(abs(SAA.Ampl));
    WAA.Ampl=WAA.Ampl/max(abs(WAA.Ampl));
    
else
    [PAA,SAA,WAA]=GetSingleAA(number);
end
legend1='GPS';
legend2='GRACE';
legend3='GLDAS';
legendposition='SouthWest';


% --- Executes on button press in CBPriDeModel.
function CBPriDeModel_Callback(hObject, eventdata, handles)
% hObject    handle to CBPriDeModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CBPriDeModel
global IfPriDeModel;
IfPriDeModel=get(hObject,'Value');

function GetPDMFreq()
global number;
global datas;
global DataNumber;
global ThisdataPri;
global PDMF;
global StationCoor;
global ModelData;
if number<=DataNumber;
    k=1;
    while strcmp(datas{number}.stationame,StationCoor.textdata{k})==0
        k=k+1;
    end
    ReadThisSec();
    DandM();
    ThisMD=StationMDExtract(StationCoor.data(k,2),StationCoor.data(k,1),ModelData);
    [ThisdataPri,ThisMD]=GMDandM(ThisdataPri,ThisMD);
    ThisPDM=ThisdataPri.z+ThisMD.duV;
    ThisPDM=ThisPDM-ThisPDM(1);
    ThisPDM=ThisPDM/max(abs(ThisPDM));
    [PDMF.Ampl,PDMF.Freq]=freqz(ThisPDM);
    PDMF.Freq=PDMF.Freq/(2*pi*(1/12));
    PDMF.Ampl=abs(PDMF.Ampl);
else
    hwait=waitbar(1/DataNumber,'Adding Amp...');
    for i=1:1:DataNumber
        waitbar(i/DataNumber,hwait,'Adding Amp...');
        k=1;
        while strcmp(datas{i}.stationame,StationCoor.textdata{k})==0
            k=k+1;
        end
        number=i;
        ReadThisSec();
        DandM();
        ThisMD=StationMDExtract(StationCoor.data(k,2),StationCoor.data(k,1),ModelData);
        [ThisdataPri,ThisMD]=GMDandM(ThisdataPri,ThisMD);
        ThisPDM=ThisdataPri.z+ThisMD.duV;
        ThisPDM=ThisPDM-ThisPDM(1);
        ThisPDM=ThisPDM/max(abs(ThisPDM));
        [ThisPDMF.Ampl,ThisPDMF.Freq]=freqz(ThisPDM);
        ThisPDMF.Freq=ThisPDMF.Freq/(2*pi*(1/12));
        ThisPDMF.Ampl=abs(ThisPDMF.Ampl);
        PDMF.Ampl=ThisPDMF.Ampl/DataNumber;
    end
    close(hwait);
    PDMF.Freq=ThisPDMF.Freq;
end


% --- Executes on button press in CBIfPri.
function CBIfPri_Callback(hObject, eventdata, handles)
% hObject    handle to CBIfPri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IfPriData;
global IfAlSelected;
IfPriData=get(hObject,'Value');
if IfPriData==1
    ClearAllLeft(handles);
    IfAlSelected=1;
else
    IfAlSelected=0;
end

% Hint: get(hObject,'Value') returns toggle state of CBIfPri


% --- Executes on selection change in PMPri.
function PMPri_Callback(hObject, eventdata, handles)
% hObject    handle to PMPri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PriAlgorithm;
global AlgorithmList;
No=get(hObject,'Value');
% PriAlgorithm=AlgorithmList(No).Function;
PriAlgorithm=AlgorithmList(No).Function;

% Hints: contents = cellstr(get(hObject,'String')) returns PMPri contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PMPri


% --- Executes during object creation, after setting all properties.
function PMPri_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PMPri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CBIfWater.
function CBIfWater_Callback(hObject, eventdata, handles)
% hObject    handle to CBIfWater (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IfWaterData;
global IfAlSelected;
IfWaterData=get(hObject,'Value');
if IfWaterData==1
    ClearAllLeft(handles);
    IfAlSelected=1;
else
    IfAlSelected=0;
end

% Hint: get(hObject,'Value') returns toggle state of CBIfWater


% --- Executes on selection change in PMWater.
function PMWater_Callback(hObject, eventdata, handles)
% hObject    handle to PMWater (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WaterAlgorithm;
global AlgorithmList;
No=get(hObject,'Value');
% WaterAlgorithm=AlgorithmList(No).Function;
WaterAlgorithm=AlgorithmList(No).Function;

% Hints: contents = cellstr(get(hObject,'String')) returns PMWater contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PMWater


% --- Executes during object creation, after setting all properties.
function PMWater_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PMWater (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CBIfSec.
function CBIfSec_Callback(hObject, eventdata, handles)
% hObject    handle to CBIfSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IfSecData;
global IfAlSelected;
IfSecData=get(hObject,'Value');
if IfSecData==1
    ClearAllLeft(handles);
    IfAlSelected=1;
else
    IfAlSelected=0;
end
% Hint: get(hObject,'Value') returns toggle state of CBIfSec


% --- Executes on selection change in PMSec.
function PMSec_Callback(hObject, eventdata, handles)
% hObject    handle to PMSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SecAlgorithm;
global AlgorithmList;
No=get(hObject,'Value');
% SecAlgorithm=AlgorithmList(No).Function;
SecAlgorithm=AlgorithmList(No).Function;

% Hints: contents = cellstr(get(hObject,'String')) returns PMSec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PMSec


% --- Executes during object creation, after setting all properties.
function PMSec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PMSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Algorithm_Callback(hObject, eventdata, handles)
% hObject    handle to Algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function NewAlgorithmSet_Callback(hObject, eventdata, handles)
% hObject    handle to NewAlgorithmSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AlgorithmList;
Empty.Name='';
Empty.Function='';
AlgorithmList=Empty;
RefreshPMs(0,'New',handles);

% --------------------------------------------------------------------
function OpenAlgorithmFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenAlgorithmFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AlgorithmList;
[FileName,PathName]=uigetfile( ...
    {'*.gpal','GPS Algorithm File(*.gpal)';},...
    'Open GPS analyzing Algorithm');
fileID=fopen([PathName,FileName],'r');
TypeMarker=fscanf(fileID,'%c',6);
position=1;
if strcmp(TypeMarker,'gpaZhu')
    Total=fread(fileID,1,'int16');
    Names=blanks(101*Total-1);
    for i=1:1:Total
        AlgorithmList(i).Name=deblank(fscanf(fileID,'%c',100));
        AlgorithmList(i).Function=fscanf(fileID,'%c',300);
        size=length(AlgorithmList(i).Name);
        Names(position:position+size-1)=AlgorithmList(i).Name;
        position=position+size;
        if i~=Total
            Names(position)='|';
            position=position+1;
        end
    end
else
    msgbox('Not GPS Algorithm File!');
end
Names=deblank(Names);
RefreshPMs(Names,'Read',handles);
CBIfPri_Callback(handles.CBIfPri,eventdata,handles);

global PriAlgorithm;
No=get(handles.PMPri,'Value');
PriAlgorithm=AlgorithmList(No).Function;

global SecAlgorithm;
No=get(handles.PMSec,'Value');
SecAlgorithm=AlgorithmList(No).Function;

global WaterAlgorithm;
No=get(handles.PMWater,'Value');
WaterAlgorithm=AlgorithmList(No).Function;



% --------------------------------------------------------------------
function SaveAlgorithmFile_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAlgorithmFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AlgorithmList;
[FileName,PathName]=uiputfile( ...
    {'*.gpal','GPS Algorithm File(*.gpal)';},...
    'Save GPS analyzing Algorithm');
fileID=fopen([PathName,FileName],'w');
fwrite(fileID,'gpaZhu','char');
fwrite(fileID,length(AlgorithmList),'int16');
for i=1:1:length(AlgorithmList)
    fwrite(fileID,AlgorithmList(i).Name,'char');
    blankfill(fileID,100-length(AlgorithmList(i).Name));
    fwrite(fileID,AlgorithmList(i).Function,'char');
    blankfill(fileID,300-length(AlgorithmList(i).Function));
end

% --------------------------------------------------------------------
function AddAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to AddAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AlgorithmList;
[NewAlgorithm.Name,NewAlgorithm.Function]=AddAlgorithm();
if isempty(AlgorithmList)
    AlgorithmList=NewAlgorithm;
else
    AlgorithmList(end+1)=NewAlgorithm;
end
RefreshPMs(NewAlgorithm.Name,'Add',handles);

% --------------------------------------------------------------------
function RemoveAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function RefreshPMs(Name,Action,handles)
global AlNameList;
switch Action;
    case 'New'
        AlNameList=' ';
    case 'Read'
        AlNameList=Name;
    case 'Add'
        if ~isempty(AlNameList)
            AlNameList=[AlNameList,'|',Name];
        else
            AlNameList=Name;
        end
    otherwise
end
set(handles.PMPri,'String',AlNameList);
set(handles.PMSec,'String',AlNameList);
set(handles.PMWater,'String',AlNameList);

function Calc()
global number;
global datas;
global DataNumber;
% global ThisdataPri;
% global ThisdataSec;
% global StationCoor;
global water;
global PriAlgorithm;
global SecAlgorithm;
global WaterAlgorithm;
global ResultPri;
global ResultSec;
global ResultWater;
global SecDataset;
global legend1;
global legend2;
global legend3;
global legendposition;
%---------------------------Set up data structure-------------------------
minY=9999;
maxY=0;
minY=ceil(minY);
maxY=floor(maxY);
for i=1:1:DataNumber
    if datas{i}.decimalyear(1)<minY
        minY=datas{i}.decimalyear(1);
    end
    if datas{i}.decimalyear(end)>maxY
        maxY=datas{i}.decimalyear(end);
    end
end
minY=ceil(minY);
maxY=floor(maxY);
ResultPri.year=(minY:0.5:maxY);
ResultSec.year=(minY:0.5:maxY);
ResultWater.year=(minY:0.5:maxY);
ResultPri.Ampl=zeros(1,length(ResultPri.year));
ResultSec.Ampl=ResultPri.Ampl;
ResultWater.Ampl=ResultPri.Ampl;

%-----------------------Calculation-------------------------------
if number>DataNumber
    Data=datas;
    DataType='AGP';
    ResultPri=eval(PriAlgorithm);
    Data=SecDataset;
    DataType='AGR';
    ResultSec=eval(SecAlgorithm);
    Data=water;
    DataType='AW';
    ResultWater=eval(WaterAlgorithm);
else
    DataType='SGP';
    ResultPri=eval(PriAlgorithm);
    DataType='SGR';
    ResultSec=eval(SecAlgorithm);
    DataType='SW';
    ResultWater=eval(WaterAlgorithm);
end
legend1='GPS';
legend2='GRACE';
legend3='GLDAS';
legendposition='NorthEast';

%The following part of code is about the idea to design algorithm in the
%GUI given. Unfortunately it is still barely realistic.
%------------------------------Calculation---------------------------------
% hwait=waitbar(1/DataNumber,'Calculating...');
% for i=1:1:DataNumber
%     waitbar(i/DataNumber,hwait,'Calculating...');
%     k=1;
%     while strcmp(datas{i}.stationame,StationCoor.textdata{k})==0
%         k=k+1;
%     end
%     number=i;
%     ReadThisSec();
%     DandM();
%     [Pri,Water]=GWDandM(ThisdataPri,StationWaterExtract(StationCoor.data(k,1),StationCoor.data(k,2),water));
%     Sec=ThisdataSec;
%     for j=1:1:length(ResultPri.year)
%         if ~isempty(PriAlgorithm)
%             z=Pri.z(j);
%             ResultPri.Ampl(j)=eval(PriAlgorithm);
%         end
%         if ~isempty(SecAlgorithm)
%             z=Sec.z(j);
%             ResultSec.Ampl(j)=eval(SecAlgorithm);
%         end
%         if ~isempty(WaterAlgorithm)
%             z=Water.LWE(j);
%             ResultWater.Ampl(j)=eval(WaterAlgorithm);
%         end
%     end
% %---------------------------Get data for each year-----------------------------------
%     for year=minY:1:maxY-1
%         ThisYearSum=0;
%         for k=1:1:DataNumber
%             if datas{k}.decimalyear(1)<year && floor(datas{k}.decimalyear(end))>year
%                 ThisYearSum=ThisYearSum+1;
%             end
%         end
%         ResultPri.Ampl(year-minY+1)=ResultPri.Ampl(year-minY+1)/ThisYearSum;
%         ResultSec.Ampl(year-minY+1)=ResultSec.Ampl(year-minY+1)/ThisYearSum;
%         ResultWater.Ampl(year-minY+1)=ResultWater.Ampl(year-minY+1)/ThisYearSum;
%     end
% end
% ResultPri.Ampl=Standardize(ResultPri.Ampl);
% ResultSec.Ampl=Standardize(ResultSec.Ampl);
% ResultWater.Ampl=Standardize(ResultWater.Ampl);
% close(hwait);

%The above part of code is about the idea to design algorithm in the
%GUI given. Unfortunately it is still barely realistic.



function ClearAllLeft(handles)
global IfPS;
global IfPW;
global IfSW;
global IfPF;
global IfSF;
global IfWF;
global IfPAA;
global IfSAA;
global IfWAA;
IfPS=0;
IfPW=0;
IfSW=0;
IfPF=0;
IfSF=0;
IfWF=0;
IfPAA=0;
IfSAA=0;
IfWAA=0;
set(handles.CBPriFreq,'Value',0);
set(handles.CBSecFreq,'Value',0);
set(handles.CBWaterFreq,'Value',0);
set(handles.CBPriAA,'Value',0);
set(handles.CBSecAA,'Value',0);
set(handles.CBWaterAA,'Value',0);
set(handles.CBPriSec,'Value',0);
set(handles.CBPriWater,'Value',0);
set(handles.CBSecWater,'Value',0);
set(handles.CBPriSec,'Value',0);
set(handles.CBPriDeModel,'Value',0);


% --------------------------------------------------------------------
function AddExistingFunction_Callback(hObject, eventdata, handles)
% hObject    handle to AddExistingFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AlgorithmList;
[NewAlgorithm.Name,NewAlgorithm.Function]=AddFunction();
if ~isempty(NewAlgorithm.Name)
    if isempty(AlgorithmList(1).Name)
        AlgorithmList=NewAlgorithm;
    else
        AlgorithmList(end+1)=NewAlgorithm;
    end
end
RefreshPMs(NewAlgorithm.Name,'Add',handles);
