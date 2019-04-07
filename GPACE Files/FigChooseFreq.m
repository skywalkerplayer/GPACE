function varargout = FigChooseFreq(varargin)
% FIGCHOOSEFREQ MATLAB code for FigChooseFreq.fig
%      FIGCHOOSEFREQ, by itself, creates a new FIGCHOOSEFREQ or raises the existing
%      singleton*.
%
%      H = FIGCHOOSEFREQ returns the handle to a new FIGCHOOSEFREQ or the handle to
%      the existing singleton*.
%
%      FIGCHOOSEFREQ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGCHOOSEFREQ.M with the given input arguments.
%
%      FIGCHOOSEFREQ('Property','Value',...) creates a new FIGCHOOSEFREQ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FigChooseFreq_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FigChooseFreq_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FigChooseFreq

% Last Modified by GUIDE v2.5 21-Nov-2016 19:11:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FigChooseFreq_OpeningFcn, ...
                   'gui_OutputFcn',  @FigChooseFreq_OutputFcn, ...
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


% --- Executes just before FigChooseFreq is made visible.
function FigChooseFreq_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FigChooseFreq (see VARARGIN)

% Choose default command line output for FigChooseFreq
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FigChooseFreq wait for user response (see UIRESUME)
% uiwait(handles.FigChooseFreq);

uiwait(handles.FigChooseFreq);


% --- Outputs from this function are returned to the command line.
function varargout = FigChooseFreq_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global HF;
global LF;
varargout{1} = HF;
varargout{2}=LF;
delete(handles.FigChooseFreq);



function EditLF_Callback(hObject, eventdata, handles)
% hObject    handle to EditLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditLF as text
%        str2double(get(hObject,'String')) returns contents of EditLF as a double


% --- Executes during object creation, after setting all properties.
function EditLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditHF_Callback(hObject, eventdata, handles)
% hObject    handle to EditHF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditHF as text
%        str2double(get(hObject,'String')) returns contents of EditHF as a double


% --- Executes during object creation, after setting all properties.
function EditHF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditHF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PBConfirm.
function PBConfirm_Callback(hObject, eventdata, handles)
% hObject    handle to PBConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global HF;
global LF;
HF=str2double(get(handles.EditLF,'String'));
LF=str2double(get(handles.EditHF,'String'));
uiresume(handles.FigChooseFreq);
