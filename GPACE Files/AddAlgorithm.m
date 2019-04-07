function varargout = AddAlgorithm(varargin)
% ADDALGORITHM MATLAB code for AddAlgorithm.fig
%      ADDALGORITHM, by itself, creates a new ADDALGORITHM or raises the existing
%      singleton*.
%
%      H = ADDALGORITHM returns the handle to a new ADDALGORITHM or the handle to
%      the existing singleton*.
%
%      ADDALGORITHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDALGORITHM.M with the given input arguments.
%
%      ADDALGORITHM('Property','Value',...) creates a new ADDALGORITHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AddAlgorithm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AddAlgorithm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AddAlgorithm

% Last Modified by GUIDE v2.5 25-Sep-2017 14:41:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AddAlgorithm_OpeningFcn, ...
                   'gui_OutputFcn',  @AddAlgorithm_OutputFcn, ...
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


% --- Executes just before AddAlgorithm is made visible.
function AddAlgorithm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AddAlgorithm (see VARARGIN)

% Choose default command line output for AddAlgorithm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AddAlgorithm wait for user response (see UIRESUME)
uiwait(handles.FGAddAlgorithm);


% --- Outputs from this function are returned to the command line.
function varargout = AddAlgorithm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.Name=get(handles.EditName,'String');
handles.Formula=get(handles.EDFormula,'String');
varargout{1} = handles.Name;
varargout{2} = handles.Formula;
delete(handles.FGAddAlgorithm);


function EDFormula_Callback(hObject, eventdata, handles)
% hObject    handle to EDFormula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global Formula;
% Formula=get(hObject,'String');

% Hints: get(hObject,'String') returns contents of EDFormula as text
%        str2double(get(hObject,'String')) returns contents of EDFormula as a double


% --- Executes during object creation, after setting all properties.
function EDFormula_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDFormula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PBPlus.
function PBPlus_Callback(hObject, eventdata, handles)
% hObject    handle to PBPlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'+'];
set(handles.EDFormula,'String',handles.Formula);


% --- Executes on button press in PBMinus.
function PBMinus_Callback(hObject, eventdata, handles)
% hObject    handle to PBMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'-'];
set(handles.EDFormula,'String',handles.Formula);

% --- Executes on button press in PBMulti.
function PBMulti_Callback(hObject, eventdata, handles)
% hObject    handle to PBMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'*'];
set(handles.EDFormula,'String',handles.Formula);

% --- Executes on button press in PBDivide.
function PBDivide_Callback(hObject, eventdata, handles)
% hObject    handle to PBDivide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'/'];
set(handles.EDFormula,'String',handles.Formula);

% --- Executes on button press in PBPower.
function PBPower_Callback(hObject, eventdata, handles)
% hObject    handle to PBPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'^'];
set(handles.EDFormula,'String',handles.Formula);

% --- Executes on button press in PBParentheses.
function PBParentheses_Callback(hObject, eventdata, handles)
% hObject    handle to PBParentheses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'()'];
set(handles.EDFormula,'String',handles.Formula);

% --- Executes on button press in PBBrackets.
function PBBrackets_Callback(hObject, eventdata, handles)
% hObject    handle to PBBrackets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'[]'];
set(handles.EDFormula,'String',handles.Formula);

% --- Executes on button press in PBBigParentheses.
function PBBigParentheses_Callback(hObject, eventdata, handles)
% hObject    handle to PBBigParentheses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'{}'];
set(handles.EDFormula,'String',handles.Formula);


% --- Executes on selection change in PMFunctions.
function PMFunctions_Callback(hObject, eventdata, handles)
% hObject    handle to PMFunctions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PMFunctions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PMFunctions


% --- Executes during object creation, after setting all properties.
function PMFunctions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PMFunctions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on EDFormula and none of its controls.
function EDFormula_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to EDFormula (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(hObject,'String');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over EDFormula.
function EDFormula_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to EDFormula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in PBX.
function PBX_Callback(hObject, eventdata, handles)
% hObject    handle to PBX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PBY.
function PBY_Callback(hObject, eventdata, handles)
% hObject    handle to PBY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PBZ.
function PBZ_Callback(hObject, eventdata, handles)
% hObject    handle to PBZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Formula=get(handles.EDFormula,'String');
handles.Formula=[handles.Formula,'z'];
set(handles.EDFormula,'String',handles.Formula);


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



% --- Executes on button press in PBAdd.
function PBAdd_Callback(hObject, eventdata, handles)
% hObject    handle to PBAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.FGAddAlgorithm);
% close(handles.FGAddAlgorithm);