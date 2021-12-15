function varargout = IMselec(varargin)
%IMSELEC MATLAB code file for IMselec.fig
%      IMSELEC, by itself, creates a new IMSELEC or raises the existing
%      singleton*.
%
%      H = IMSELEC returns the handle to a new IMSELEC or the handle to
%      the existing singleton*.
%
%      IMSELEC('Property','Value',...) creates a new IMSELEC using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to IMselec_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      IMSELEC('CALLBACK') and IMSELEC('CALLBACK',hObject,...) call the
%      local function named CALLBACK in IMSELEC.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IMselec

% Last Modified by GUIDE v2.5 17-Sep-2019 14:37:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IMselec_OpeningFcn, ...
                   'gui_OutputFcn',  @IMselec_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before IMselec is made visible.
function IMselec_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for IMselec
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IMselec wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% INICIALIZAÇAO
imdata=evalin('base', 'imdata');
inicializacao(handles);


% --- Outputs from this function are returned to the command line.
function varargout = IMselec_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axesOriginal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesOriginal

% --- Executes on button press in pushbuttonORIGINAL.
function pushbuttonORIGINAL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonORIGINAL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

imagem=imdata.imagem.ORI{1,imdata.sliderValue};

[~,~,n]=size(imagem); % determinação do tamanho da matriz

if n==3
    imagem=rgb2gray(imagem);
end



imdata.imagem.ESC{1,imdata.sliderValue}=imagem;

assignin('base','imdata',imdata);

axes(imdata.SYSTEM.ax2);
imshow(imdata.imagem.ESC{1,imdata.sliderValue});





% --- Executes on button press in pushbuttonEQUALIZADO.
function pushbuttonEQUALIZADO_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonEQUALIZADO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

imagem=imdata.imagem.ORI{1,imdata.sliderValue};

[~,~,n]=size(imagem); % determinação do tamanho da matriz

if n==3
    imagem=rgb2gray(imagem);
end


imdata.imagem.ESC{1,imdata.sliderValue}=histeq(imagem);

assignin('base','imdata',imdata);

axes(imdata.SYSTEM.ax2);
imshow(imdata.imagem.ESC{1,imdata.sliderValue});




% --- Executes on button press in pushbuttonAJUSTADO.
function pushbuttonAJUSTADO_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonAJUSTADO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

imagem=imdata.imagem.ORI{1,imdata.sliderValue};

[~,~,n]=size(imagem); % determinação do tamanho da matriz

if n==3
    imagem=rgb2gray(imagem);
end


imdata.imagem.ESC{1,imdata.sliderValue}=imadjust(imagem);

assignin('base','imdata',imdata);

axes(imdata.SYSTEM.ax2);
imshow(imdata.imagem.ESC{1,imdata.sliderValue});



% --- Executes on button press in pushbuttonADAPTADO.
function pushbuttonADAPTADO_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonADAPTADO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

imagem=imdata.imagem.ORI{1,imdata.sliderValue};

[~,~,n]=size(imagem); % determinação do tamanho da matriz

if n==3
    imagem=rgb2gray(imagem);
end

imdata.imagem.ESC{1,imdata.sliderValue}=adapthisteq(imagem);

assignin('base','imdata',imdata);


axes(imdata.SYSTEM.ax2);
imshow(imdata.imagem.ESC{1,imdata.sliderValue});



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function inicializacao(handles, sliderValue)
imdata = evalin('base','imdata');

if imdata.controlindex > 1
    %set(handles.slider2,'Value',imdata.sliderValue);
    set(handles.slider2,'Min',1);
    set(handles.slider2,'Max',imdata.controlindex);
    set(handles.slider2,'SliderStep',[1/(imdata.controlindex-1) 1/(imdata.controlindex-1)])
    set(handles.slider2,'Visible','on');
end


cindex=imdata.sliderValue;
set(handles.slider2,'Value', cindex);

im1=imdata.imagem.ORI{1,cindex};

[~,~,n]=size(im1); % determinação do tamanho da matriz

if n==3
    im1=rgb2gray(im1);
end

hold on
% Original
axes(handles.axesOriginal)
imshow(im1);
title('Original');

% Equalizado
axes(handles.axesEqualizado)
im2=histeq(im1);
imshow(im2);
title('Equalizado');

% Ajustado
axes(handles.axesAjustado)
im3=imadjust(im1);
imshow(im3);
title('Ajustado');

% Adaptado
axes(handles.axesAdaptado)
im4=adapthisteq(im1);
imshow(im4);
title('Adaptado');

hold off


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

imdata=evalin('base','imdata');
imdata.sliderValue=get(handles.slider2,'Value');
assignin('base','imdata',imdata);

inicializacao(handles);
imatribui(imdata, handles, imdata.sliderValue);
