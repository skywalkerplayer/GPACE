function varargout = AddFunction(varargin)
% ADDFUNCTION MATLAB code for AddFunction.fig
%      ADDFUNCTION, by itself, creates a new ADDFUNCTION or raises the existing
%      singleton*.
%
%      H = ADDFUNCTION returns the handle to a new ADDFUNCTION or the handle to
%      the existing singleton*.
%
%      ADDFUNCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDFUNCTION.M with the given input arguments.
%
%      ADDFUNCTION('Property','Value',...) creates a new ADDFUNCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AddFunction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AddFunction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AddFunction

% Last Modified by GUIDE v2.5 16-Oct-2017 02:03:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AddFunction_OpeningFcn, ...
                   'gui_OutputFcn',  @AddFunction_OutputFcn, ...
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


% --- Executes just before AddFunction is made visible.
function AddFunction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AddFunction (see VARARGIN)

% Choose default command line output for AddFunction
handles.output = hObject;

handles.Name='';
handles.Function='';
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes AddFunction wait for user response (see UIRESUME)
uiwait(handles.FigAddFunc);


% --- Outputs from this function are returned to the command line.
function varargout = AddFunction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.Name;
varargout{2} = handles.Function;
delete(handles.FigAddFunc);


% --- Executes on button press in PBAdd.
function PBAdd_Callback(hObject, eventdata, handles)
% hObject    handle to PBAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Name=get(handles.EditName,'String');
handles.Function=get(handles.EditFunctionLine,'String');
guidata(handles.FigAddFunc, handles);
uiresume(handles.FigAddFunc);


% --- Executes on button press in PBCancel.
function PBCancel_Callback(hObject, eventdata, handles)
% hObject    handle to PBCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.FigAddFunc);



function EditFunctionLine_Callback(hObject, eventdata, handles)
% hObject    handle to EditFunctionLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of EditFunctionLine as text
%        str2double(get(hObject,'String')) returns contents of EditFunctionLine as a double


% --- Executes during object creation, after setting all properties.
function EditFunctionLine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditFunctionLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditName_Callback(hObject, eventdata, handles)
% hObject    handle to EditName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditName as text
%        str2double(get(hObject,'String')) returns contents of EditName as a double


% --- Executes during object creation, after setting all properties.
function EditName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
