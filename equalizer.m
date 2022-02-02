%Konstantinos Tsolakakis
%C1558282
%CM2208


function varargout = equalizer(varargin)
% EQUALIZER MATLAB code for equalizer.fig
%      EQUALIZER, by itself, creates a new EQUALIZER or raises the existing
%      singleton*.
%
%      H = EQUALIZER returns the handle to a new EQUALIZER or the handle to
%      the existing singleton*.
%
%      EQUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUALIZER.M with the given input arguments.
%
%      EQUALIZER('Property','Value',...) creates a new EQUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equalizer

% Last Modified by GUIDE v2.5 12-Apr-2019 03:16:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @equalizer_OutputFcn, ...
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


% --- Executes just before equalizer is made visible.
function equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equalizer (see VARARGIN)

% Choose default command line output for equalizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.wav'; '*.mp3'; '*.flac'; '*.AAC'; '*.MPEG-4';}, 'File Selector');
handles.fullpathname = strcat(pathname, filename);
set(handles.text3, 'String', handles.fullpathname)
handles.info = audioinfo(handles.fullpathname);
guidata(hObject, handles)


function play_equalizer(hObject, handles)
global player;
global Volume;
[handles.y,handles.Fs] = audioread(handles.fullpathname);
Volume = get(handles.volume,'value');
A = struct2cell(handles.info);
set(handles.text33,'String', A);
%handles.y=handles.y(NewStart:end,:); 
handles.g1=get(handles.slider1,'value');
handles.g2=get(handles.slider2,'value');
handles.g3=get(handles.slider3,'value');
handles.g4=get(handles.slider4,'value');
handles.g5=get(handles.slider5,'value');
handles.g6=get(handles.slider6,'value');
handles.g7=get(handles.slider7,'value');
handles.g8=get(handles.slider8,'value');
handles.g9=get(handles.slider9,'value');
handles.g10=get(handles.slider10,'value');
set(handles.text17, 'String',handles.g1);
set(handles.text18, 'String',handles.g2);
set(handles.text19, 'String',handles.g3);
set(handles.text20, 'String',handles.g4);
set(handles.text21, 'String',handles.g5);
set(handles.text22, 'String',handles.g6);
set(handles.text23, 'String',handles.g7);
set(handles.text24, 'String',handles.g8);
set(handles.text25, 'String',handles.g9);
set(handles.text26, 'String',handles.g10);

cut_off=200;
orde=16;
a=fir1(orde,cut_off/(handles.Fs/2),'low');
y1=handles.g1*filter(a,1,handles.y);

%BAND 1
f1=201;
f2=400;
b1=fir1(orde,[f1/(handles.Fs/2) f2/(handles.Fs/2)],'bandpass');
y2=handles.g2*filter(b1,1,handles.y);

%BAND 2
f3=401;
f4=800;
b2=fir1(orde,[f3/(handles.Fs/2) f4/(handles.Fs/2)],'bandpass');
y3=handles.g3*filter(b2,1,handles.y);

%BAND 3
 f4=801;
f5=1500;
 b3=fir1(orde,[f4/(handles.Fs/2) f5/(handles.Fs/2)],'bandpass');
 y4=handles.g4*filter(b3,1,handles.y);
 
%BAND 4
 f5=1501;
f6=3000;
 b4=fir1(orde,[f5/(handles.Fs/2) f6/(handles.Fs/2)],'bandpass');
 y5=handles.g5*filter(b4,1,handles.y);
 
%BAND 5
  f7=3001;
f8=5000;
  b5=fir1(orde,[f7/(handles.Fs/2) f8/(handles.Fs/2)],'bandpass');
  y6=handles.g6*filter(b5,1,handles.y);

%BAND 6
  f9=5001;
f10=7000;
  b6=fir1(orde,[f9/(handles.Fs/2) f10/(handles.Fs/2)],'bandpass');
  y7=handles.g7*filter(b6,1,handles.y);

% BAND 7
  f11=7001;
f12=10000;
  b7=fir1(orde,[f11/(handles.Fs/2) f12/(handles.Fs/2)],'bandpass');
  y8=handles.g8*filter(b7,1,handles.y);

 % BAND 8
f13=10001;
f14=15000;
b8=fir1(orde,[f13/(handles.Fs/2) f14/(handles.Fs/2)],'bandpass');
y9=handles.g9*filter(b8,1,handles.y);
% 
 %highpass
cut_off2=15000;
c=fir1(orde,cut_off2/(handles.Fs/2),'high');
y10=handles.g10*filter(c,1,handles.y);
handles.yT = y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;
checkbox1Value = get(handles.reverbCheck, 'value');

if checkbox1Value == 1
    reverb = reverberator;
    handles.yT = reverb(handles.yT);
    player = audioplayer(Volume*handles.yT, handles.Fs);
else
    player = audioplayer(Volume*handles.yT, handles.Fs);
end

subplot(2,1,1);
plot(handles.y);
subplot(2,1,2);
plot(handles.yT);



guidata(hObject,handles)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles)
stop(player);
guidata(hObject, handles)


% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles)
resume(player);
guidata(hObject, handles)


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles)
pause(player);
guidata(hObject, handles)


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles)
play(player);
guidata(hObject, handles)



% --- Executes on slider movement.
function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Jazz
function Jazz_Callback(hObject, eventdata, handles)
% hObject    handle to Jazz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = -1.5;
g2 = 3.9;
g3 = 5.4;
g4 = 4.5;
g5 =  0.9;
g6 = -1.5;
g7 = -1.8;
g8= -2.1;
g9 = -2.1;
g10 = -0.3;
set(handles.slider1,'value',g1);
set(handles.slider2,'value',g2);
set(handles.slider3,'value',g3);
set(handles.slider4,'value',g4);
set(handles.slider5,'value',g5);
set(handles.slider6,'value',g6);
set(handles.slider7,'value',g7);
set(handles.slider8,'value',g8);
set(handles.slider9,'value',g9);
set(handles.slider10,'value',g10);
set(handles.text17, 'String',g1);
set(handles.text18, 'String',g2);
set(handles.text19, 'String',g3);
set(handles.text20, 'String',g4);
set(handles.text21, 'String',g5);
set(handles.text22, 'String',g6);
set(handles.text23, 'String',g7);
set(handles.text24, 'String',g8);
set(handles.text25, 'String',g9);
set(handles.text26, 'String',g10);


% --- Executes on button press in Metal
function Metal_Callback(hObject, eventdata, handles)
% hObject    handle to Metal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 0;
g2 = 0;
g3 = -0.3;
g4 = -2.7;
g5 =  0;
g6 = 2.1;
g7 = 4.5;
g8= 3;
g9 = 0.6;
g10 = 0;
set(handles.slider1,'value',g1);
set(handles.slider2,'value',g2);
set(handles.slider3,'value',g3);
set(handles.slider4,'value',g4);
set(handles.slider5,'value',g5);
set(handles.slider6,'value',g6);
set(handles.slider7,'value',g7);
set(handles.slider8,'value',g8);
set(handles.slider9,'value',g9);
set(handles.slider10,'value',g10);

set(handles.text17, 'String',g1);
set(handles.text18, 'String',g2);
set(handles.text19, 'String',g3);
set(handles.text20, 'String',g4);
set(handles.text21, 'String',g5);
set(handles.text22, 'String',g6);
set(handles.text23, 'String',g7);
set(handles.text24, 'String',g8);
set(handles.text25, 'String',g9);
set(handles.text26, 'String',g10);


% --- Executes on button press in Rock.
function Rock_Callback(hObject, eventdata, handles)
% hObject    handle to Rock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 4.5;
g2 = -3.6;
g3 = -6.6;
g4 = -2.7;
g5 =  2.1;
g6 = 6;
g7 = 7.5;
g8= 7.8;
g9 =7.8;
g10 = 8.1;
set(handles.slider1,'value',g1);
set(handles.slider2,'value',g2);
set(handles.slider3,'value',g3);
set(handles.slider4,'value',g4);
set(handles.slider5,'value',g5);
set(handles.slider6,'value',g6);
set(handles.slider7,'value',g7);
set(handles.slider8,'value',g8);
set(handles.slider9,'value',g9);
set(handles.slider10,'value',g10);

set(handles.text17, 'String',g1);
set(handles.text18, 'String',g2);
set(handles.text19, 'String',g3);
set(handles.text20, 'String',g4);
set(handles.text21, 'String',g5);
set(handles.text22, 'String',g6);
set(handles.text23, 'String',g7);
set(handles.text24, 'String',g8);
set(handles.text25, 'String',g9);
set(handles.text26, 'String',g10);


% --- Executes on button press in House.
function House_Callback(hObject, eventdata, handles)
% hObject    handle to House (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 4.8;
g2 = 4.2;
g3 = 1.5;
g4 = -2.4;
g5 =  -3.3;
g6 = -1.5;
g7 = 1.5;
g8= 5.1;
g9 = 5.7;
g10 = 5.4;
set(handles.slider1,'value',g1);
set(handles.slider2,'value',g2);
set(handles.slider3,'value',g3);
set(handles.slider4,'value',g4);
set(handles.slider5,'value',g5);
set(handles.slider6,'value',g6);
set(handles.slider7,'value',g7);
set(handles.slider8,'value',g8);
set(handles.slider9,'value',g9);
set(handles.slider10,'value',g10);

set(handles.text17, 'String',g1);
set(handles.text18, 'String',g2);
set(handles.text19, 'String',g3);
set(handles.text20, 'String',g4);
set(handles.text21, 'String',g5);
set(handles.text22, 'String',g6);
set(handles.text23, 'String',g7);
set(handles.text24, 'String',g8);
set(handles.text25, 'String',g9);
set(handles.text26, 'String',g10);


% --- Executes on button press in Hall
function Hall_Callback(hObject, eventdata, handles)
% hObject    handle to Hall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 5.4;
g2 = 0;
g3 = 0;
g4 = 0;
g5 =  0;
g6 = 0;
g7 = 0;
g8= 0;
g9 = 0;
g10 = 5.4;
set(handles.slider1,'value',g1);
set(handles.slider2,'value',g2);
set(handles.slider3,'value',g3);
set(handles.slider4,'value',g4);
set(handles.slider5,'value',g5);
set(handles.slider6,'value',g6);
set(handles.slider7,'value',g7);
set(handles.slider8,'value',g8);
set(handles.slider9,'value',g9);
set(handles.slider10,'value',g10);

set(handles.text17, 'String',g1);
set(handles.text18, 'String',g2);
set(handles.text19, 'String',g3);
set(handles.text20, 'String',g4);
set(handles.text21, 'String',g5);
set(handles.text22, 'String',g6);
set(handles.text23, 'String',g7);
set(handles.text24, 'String',g8);
set(handles.text25, 'String',g9);
set(handles.text26, 'String',g10);


% --- Executes on button press in Classical.
function Classical_Callback(hObject, eventdata, handles)
% hObject    handle to Classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 0;
g2 = 0;
g3 = 0;
g4 = 0;
g5 =  0;
g6 = 0;
g7 = -0.3;
g8= -5.7;
g9 = -6;
g10 = -8.1;
set(handles.slider1,'value',g1);
set(handles.slider2,'value',g2);
set(handles.slider3,'value',g3);
set(handles.slider4,'value',g4);
set(handles.slider5,'value',g5);
set(handles.slider6,'value',g6);
set(handles.slider7,'value',g7);
set(handles.slider8,'value',g8);
set(handles.slider9,'value',g9);
set(handles.slider10,'value',g10);

set(handles.text17, 'String',g1);
set(handles.text18, 'String',g2);
set(handles.text19, 'String',g3);
set(handles.text20, 'String',g4);
set(handles.text21, 'String',g5);
set(handles.text22, 'String',g6);
set(handles.text23, 'String',g7);
set(handles.text24, 'String',g8);
set(handles.text25, 'String',g9);
set(handles.text26, 'String',g10);


% --- Executes on button press in browse2.
function browse2_Callback(hObject, eventdata, handles)
% hObject    handle to browse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.wav'; '*.mp3'; '*.flac'; '*.AAC'; '*.MPEG-4';}, 'File Selector');
handles.fullpathname2 = strcat(pathname, filename);
set(handles.text31, 'String', handles.fullpathname2)
guidata(hObject, handles)


% --- Executes on button press in crossSynth.
function crossSynth_Callback(hObject, eventdata, handles)
% hObject    handle to crossSynth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.x,handles.Fsx] = audioread(handles.fullpathname);
handles.x = handles.x(:, 1);
[handles.y, handles.Fsy] = audioread(handles.fullpathname2);
handles.y = handles.y(:, 1);
play_equalizer(hObject, handles)

global z;
global player;
global Volume;

fs = max(handles.Fsx, handles.Fsy);

% make x and y with equal sampling rate
if handles.Fsx > handles.Fsy
    handles.y = resample(handles.y, handles.Fsx, handles.Fsy);
else
    handles.x = resample(handles.x, handles.Fsy, handles.Fsx);
end

% make x and y with equal length
xlen = length(handles.x);
ylen = length(handles.y);
if xlen > ylen
    handles.x = handles.x(1:ylen);
else
    handles.y = handles.y(1:xlen);
end

% define the analysis and synthesis parameters
wlen = 1024;
hop = wlen/4;
nfft = wlen;

% perform time-frequency analysis
[X_stft, f] = stft(handles.x, wlen, hop, nfft, fs);
[Y_stft, ~] = stft(handles.y, wlen, hop, nfft, fs);

% memory optimization
clear handles.x handles.y

% extract spectral envelope of the carrier signal
X_stft_amp = abs(X_stft);
for k = 1:size(X_stft_amp, 2)
    X_env(:, k) = smoothdata(X_stft_amp(:, k));
end

% extract spectral envelope of the modulating signal
Y_stft_amp = abs(Y_stft);
for k = 1:size(Y_stft_amp, 2)
    Y_env(:, k) = smoothdata(Y_stft_amp(:, k));
end

% memory optimization
clear X_stft_amp Y_stft_amp Y_stft

% cross-synthesis
Z_stft = X_stft./X_env.*Y_env;
z = istft(Z_stft, wlen, hop, nfft, fs);

% memory optimization
clear X_stft Z_stft X_env Y_env

% hear the result signal
%soundsc(z + Volume, fs)
%player = audioplayer(Volume*z, handles.Fs);
if get(handles.volume,'value') == 0
    Volume = 0.2;
    player = audioplayer(Volume*z, fs);
else
    Volume = get(handles.volume, 'value');
    player = audioplayer(Volume*z, fs);
end
play(player)



% --- Executes on button press in exportFile.
function exportFile_Callback(hObject, eventdata, handles)
% hObject    handle to exportFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global z;
audio = z;
audiowrite('audio.wav', audio, 44100)


% --- Executes on button press in reverbCheck.
function reverbCheck_Callback(hObject, eventdata, handles)
% hObject    handle to reverbCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkbox1Value = get(handles.reverbCheck, 'value');
    

% --- Executes on button press in reverbCheck.
function reverb_Callback(hObject, eventdata, handles)
% hObject    handle to reverbCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.y,handles.Fs] = audioread(handles.fullpathname);
reverb = reverberator;
audioOut = reverb(handles.y);
soundsc(audioOut, handles.Fs)