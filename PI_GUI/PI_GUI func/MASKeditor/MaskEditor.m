function varargout = MaskEditor(varargin)
% MASKEDITOR MATLAB code for MaskEditor.fig
%      MASKEDITOR, by itself, creates a new MASKEDITOR or raises the existing
%      singleton*.
%
%      H = MASKEDITOR returns the handle to a new MASKEDITOR or the handle to
%      the existing singleton*.
%
%      MASKEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASKEDITOR.M with the given input arguments.
%
%      MASKEDITOR('Property','Value',...) creates a new MASKEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MaskEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MaskEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MaskEditor

% Last Modified by GUIDE v2.5 14-Feb-2020 17:52:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MaskEditor_OpeningFcn, ...
    'gui_OutputFcn',  @MaskEditor_OutputFcn, ...
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


% --- Executes just before MaskEditor is made visible.
function MaskEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MaskEditor (see VARARGIN)

% Choose default command line output for MaskEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MaskEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% INICIALIZAÇAO
imdata=evalin('base', 'imdata');
inicializacao(handles);
imdata.maskeditor = 0;
assignin('base','imdata',imdata);


% --- Outputs from this function are returned to the command line.
function varargout = MaskEditor_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


imdata=evalin('base','imdata');
imdata.sliderValue=get(handles.slider1,'Value');
assignin('base','imdata',imdata);

inicializacao(handles);
imatribui(imdata, handles, imdata.sliderValue);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in Selecaoquadrada.
function Selecaoquadrada_Callback(hObject, eventdata, handles)
% hObject    handle to Selecaoquadrada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

idx=imdata.sliderValue;
mask=imdata.filtro.FIL{1,idx};
b=imdata.imagem.CBASE{1,idx};



% depois de tratamento automático pode ser necessário usar ajustes manuais
axes(handles.axesMask)
rect=getrect;

%calculo das coordenadas a partir da ferramentea getrect
ci=round(rect(1,1));
li=round(rect(1,2));
cf=round(rect(1,1)+rect(1,3));
lf=round(rect(1,2)+rect(1,4));

% se forem selecionadas areas fora da matriz necessitamos restringir ao
% tamanho da matriz
if li<1
    li=1;
end
if ci<1
    ci=1;
end

[m,n]=size(mask);

if lf>m
    lf=m;
end

if cf>n
    cf=n;
end

% aplicação das alterações

mask(li:lf,ci:cf)=str2num(get(handles.edit2, 'String'));

imdata.filtro.FIL{1,idx}=mask;



axes(handles.axesMask)
h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');
%imshow(uint8(mask)*255);

f=b.*uint8(mask);

c=b.*uint8(mask);
d=b;
d(mask==0)=100;

c(:,:,1)=c;
c(:,:,2)=d;
c(:,:,3)=mask;

%imdata.novo.c=c;

% f(f==0)=155;
%imshow(f);
imshow(c);




% Final
axes(handles.axesFinal)
h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

f=b.*uint8(mask);

c=b.*uint8(mask);
d=b;
d(mask==0)=100;

c(:,:,1)=c;
c(:,:,2)=d;
c(:,:,3)=mask;

%imdata.novo.c=c;

% f(f==0)=155;
%imshow(f);
imshow(c);

imdata.imagem.LCO{1,idx}=f;
imdata.imagem.ESC{1,idx}=f;

assignin('base','imdata',imdata);
%imatribui(imdata, handles, imdata.sliderValue);

set(gcf, 'Pointer', 'arrow')
drawnow;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.






function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% imdata = evalin('base','imdata');
% imdata.SYSTEM.t8=handles.edit1;
% assignin('base','imdata',imdata);




function inicializacao(handles)
imdata = evalin('base','imdata');

if imdata.controlindex > 1
    %set(handles.slider2,'Value',imdata.sliderValue);
    set(handles.slider1,'Min',1);
    set(handles.slider1,'Max',imdata.controlindex);
    set(handles.slider1,'SliderStep',[1/(imdata.controlindex-1) 1/(imdata.controlindex-1)])
    set(handles.slider1,'Visible','on');
end



cindex=imdata.sliderValue;
set(handles.slider1,'Value', cindex);

set(handles.edit1, 'String',imdata.ParC.EST1(1, cindex));

im1=imdata.filtro.FIL{1,cindex};
im2=imdata.imagem.LCO{1,cindex};

im3=imdata.filtro.FIL{1,cindex}*255;
im4=im2.*uint8(im1);

hold on

% Mask
axes(handles.axesMask)
h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');
imshow(im3);
title('Mask');

% Final
axes(handles.axesFinal)
h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');
imshow(im4);
title('Final');


hold off

assignin('base','imdata',imdata);


% --- Executes on key press with focus on edit1 and none of its controls.
function edit1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


tecla=get(gcf,'currentkey');

if (strcmp(tecla,'return'))
    
    imdata = evalin('base','imdata');
    
    c1=str2num(get(handles.edit1, 'String'));   %falta uma captura de erro para quando não é número
    
    idx=get(handles.slider1,'Value');
    
    imagemG=imdata.imagem.CBASE{1,idx};
    
    mask=MaskCreation(imagemG, c1);
    
    imdata.filtro.FIL{1,idx}=mask;
    imdata.ParC.EST1(1,idx)=c1; 
   
    axes(handles.axesMask)
    h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');
    imshow(uint8(mask)*255);
    
    % Final
    axes(handles.axesFinal)
    h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');
    
    f=imagemG.*uint8(mask);
    % f(f==0)=155;
    imshow(f);
    
    
    imdata.imagem.LCO{1,idx}=f;
    imdata.imagem.ESC{1,idx}=f;
    
   % imatribui(imdata, handles, imdata.sliderValue);
    
    assignin('base','imdata',imdata);
    'fim de processamento'
end




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pontoponto.
function pontoponto_Callback(hObject, eventdata, handles)
% hObject    handle to pontoponto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

idx=imdata.sliderValue;
mask=imdata.filtro.FIL{1,idx};
b=imdata.imagem.CBASE{1,idx};


set (gcf,'WindowButtonDownFcn',@mouseclick);
%set(gcf,'Pointer','cross')
set(gcf,'Pointer','crosshair')
drawnow;






function mouseclick (varargin)
imdata = evalin('base','imdata');

figHandle = varargin{1};
handles = guidata(figHandle);


C = get(gca,'currentPoint');
c=floor(C(1,1))
l=floor(C(1,2))

imdata = evalin('base','imdata');

idx=imdata.sliderValue;
mask=imdata.filtro.FIL{1,idx};
b=imdata.imagem.CBASE{1,idx};


a=10;

mask(l-a:l+a, c-a:c+a)=str2num(get(handles.edit2,'String'));
str2num(get(handles.edit2,'String'))

% depois de tratamento automático pode ser necessário usar ajustes manuais
axes(handles.axesMask)

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');


f=b.*uint8(mask);

c=b.*mask;
d=b;
d(mask==0)=100;

c(:,:,1)=c;
c(:,:,2)=d;
c(:,:,3)=mask;

%imdata.novo.c=c;

% f(f==0)=155;
%imshow(f);
imshow(c);




% Final
axes(handles.axesFinal)

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

f=b.*uint8(mask);

comp=b.*mask;
d=b;
d(mask==0)=100;

comp(:,:,1)=comp;
comp(:,:,2)=d;
comp(:,:,3)=mask;

%imdata.novo.c=c;


% f(f==0)=155;
%imshow(f);
imshow(comp);

imdata.imagem.LCO{1,idx}=f;
imdata.imagem.ESC{1,idx}=f;
imdata.filtro.FIL{1,idx}=mask;

assignin('base','imdata',imdata);


% --- Executes on button press in contrair.
function contrair_Callback(hObject, eventdata, handles)
% hObject    handle to contrair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imdata=evalin('base', 'imdata');



idx=imdata.sliderValue;
mask1=imdata.filtro.FIL{1,idx};
b=imdata.imagem.CBASE{1,idx};

[l, c]=size(mask1);


% a primeira mascara pode necessitar de ajustes por conter areas com a
% mesma cor do fundo
% procuramos colocar na area de cálculo zonas pontos isolados com a cor de
% fundo
mask2=mask1;

for i=3:l-3
    for j=3:c-3
        somaij = ...
            mask1(i-2,j-2) + mask1(i-1,j-2) + mask1(i,j-2) + mask1(i+1,j-2) + mask1(i+2,j-2) + ...
            mask1(i-2,j-1) + mask1(i-1,j-1) + mask1(i,j-1) + mask1(i+1,j-1) + mask1(i+2,j-1) + ...
            mask1(i-2,j)   + mask1(i-1,j)   + mask1(i,j)   + mask1(i+1,j)   + mask1(i+2,j)   + ...
            mask1(i-2,j+1) + mask1(i-1,j+1) + mask1(i,j+1) + mask1(i+1,j+1) + mask1(i+2,j+1) + ...
            mask1(i-2,j+2) + mask1(i-1,j+2) + mask1(i,j+2) + mask1(i+1,j+2) + mask1(i+2,j+2);
        
                        
        if somaij <=15 && mask1(i,j)==1
            mask2(i,j)=0;
        end
        
    end
end





% figure
% imshow(mask2)
% title('M2')
% 
% figure
% f=b.*uint8(~mask2);
% f(f==0)=155;
% imshow(f)

mask=uint8(mask2);

%figure; imshow(mask.*imagem)

axes(handles.axesMask)
%imshow(uint8(mask)*255);

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');


f=b.*uint8(mask);

c=b.*mask;
d=b;
d(mask==0)=100;

c(:,:,1)=c;
c(:,:,2)=d;
c(:,:,3)=mask;

%imdata.novo.c=c;

% f(f==0)=155;
%imshow(f);
imshow(c);





% Final
axes(handles.axesFinal)

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

f=b.*uint8(mask);

c=b.*mask;
d=b;
d(mask==0)=100;

c(:,:,1)=c;
c(:,:,2)=d;
c(:,:,3)=mask;

%imdata.novo.c=c;

% f(f==0)=155;
%imshow(f);
imshow(c);

imdata.imagem.LCO{1,idx}=f;
imdata.imagem.ESC{1,idx}=f;
imdata.filtro.FIL{1,idx}=mask;

1
assignin('base','imdata',imdata);


% --- Executes on button press in cortarbt.
function cortarbt_Callback(hObject, eventdata, handles)
% hObject    handle to cortarbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



imtemp=0;
imdata=evalin('base','imdata');
idx=imdata.sliderValue;


f1=figure;
imshow(imdata.imagem.LCO{1,idx})

r=getrect(f1);
r=floor(r);


imtemp==imdata.imagem.CBASE{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
imshow(imtemp)

a=questdlg('aceitar','cortar imagem','Sim', 'Não', 'Não')

if a=='Sim'
    
    imdata.imagem.CBASE{1,idx}=imdata.imagem.CBASE{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.imagem.ESC{1,idx}=imdata.imagem.ESC{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.imagem.LCO{1,idx}=imdata.imagem.LCO{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    
    if imdata.maskon==1
        imdata.filtro.FIL{1,idx}=imdata.filtro.FIL{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    end
    
end

close(f1);


assignin('base','imdata',imdata);


% --- Executes on button press in pixel.
function pixel_Callback(hObject, eventdata, handles)
% hObject    handle to pixel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



imdata = evalin('base','imdata');


% Final
axes(handles.axesFinal)
[x,y]=ginput(1);
pixel_x=round(x)
pixel_y=round(y)

pixel=imdata.imagem.CBASE{1,imdata.sliderValue}(pixel_y,pixel_x)


% --- Executes on button press in contraste.
function contraste_Callback(hObject, eventdata, handles)
% hObject    handle to contraste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata = evalin('base','imdata');

p=get(handles.edit3,'String');
p1=str2num(p{1,1});

imagem=double(imdata.imagem.CBASE{1,imdata.sliderValue});

nimagem=((imagem).^p1)/(255^(p1-1));


% Final
axes(handles.axesFinal)

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

imshow((nimagem));


axes(handles.axesMask)
%imshow(uint8(mask)*255);

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

imshow((imagem));




function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in criarmask2.
function criarmask2_Callback(hObject, eventdata, handles)
% hObject    handle to criarmask2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



imdata = evalin('base','imdata');

p_t=get(handles.edit4,'String');
p2=str2num(p_t{1,1});

p_c=get(handles.edit3,'String');
p1=str2num(p_c{1,1});

imagem=imdata.imagem.CBASE{1,imdata.sliderValue};

nimagem=((double(imagem)).^p1)/(255^(p1-1));

mask=nimagem<=p2;




% Final
axes(handles.axesFinal)

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

imshow((nimagem));


axes(handles.axesMask)
%imshow(uint8(mask)*255);

h=gcf;
set(h,'toolbar','figure');
set(h,'menubar','figure');

imshow(uint8(double(imagem).*mask));

imdata.filtro.FIL{1,imdata.sliderValue}=mask;

assignin('base','imdata',imdata);
