
function varargout = PI_GUI(varargin)
%% PI_GUI M-file for PI_GUI.fig
%      PI_GUI, by itself, creates a new PI_GUI or raises the existing
%      singleton*.
%
%      H = PI_GUI returns the handle to a new PI_GUI or the handle to
%      the existing singleton*.
%
%      PI_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PI_GUI.M with the given input arguments.
%
%      PI_GUI('Property','Value',...) creates a new PI_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PI_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PI_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PI_GUI

% Last Modified by GUIDE v2.5 13-Feb-2020 16:56:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PI_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @PI_GUI_OutputFcn, ...
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


% --- Executes just before PI_GUI is made visible.



function PI_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
%% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PI_GUI (see VARARGIN)

% Choose default command line output for PI_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

if exist('imdata', 'var')==1
    imdata=evalin('base', 'imdata');
    imatribui(imdata, handles, imdata.sliderValue);
else
    
    % inicialização da estrutura de dados
    imdata =    struct(  'imagem',      struct( 'ORI',{''},...              'Armazenar imagem original
                                                'ESC',{''},...              
                                                'CBASE',{''},...
                                                'LCO',{''},... 
                                                'tamanho',[0;0],...
                                                'LinhasColunas',[0;0]),...
                         'ParC',        struct( 'ORI',[0 0],...
                                                'ESC',[0 0],...
                                                'LCO',[0 0],...
                                                'GlobalORI', {''},...
                                                'GlobalESC', {''},...
                                                'GlobalLCO', {''},...
                                                'Check',0,...
                                                'EST1',['']),...
                         'SYSTEM',      struc(  'ax1',(''),...
                                                'ax2',(''),...
                                                'ax3',(''),...
                                                'hx1',(''),...
                                                'hx2',(''),...
                                                'hx3',(''),...
                                                'hx4',(''),...
                                                't1',(''),...
                                                't2',(''),...
                                                't3',(''),...
                                                't4',(''),...
                                                't5',(''),...
                                                't6',(''),...
                                                't7',(''),...
                                                't8',(''),...
                                                's1',('')),...
                         'filtro',      struct( 'FIL',{''},...
                                                'filename',{''},...
                                                'pathname',{''},...
                                                'fullname',{''}),...                                                
                         'STATS',       struct( 'Limage',{''},...
                                                'std',[0],...
                                                'stdstd',0,...
                                                'mstd',0,...
                                                'zim',('')),...
                         'Check',0,...
                         'hist',{''},...
                         'filename',{''},...
                         'pathname',{''},...
                         'fullname',{''},...
                         'controlindex',0,...
                         'maskon',0,...
                         'sliderValue',1);
    
    assignin('base','imdata',imdata);
end

% UIWAIT makes PI_GUI wait for user response (see UIRESUME)
% uiwait(handles.PI_GUI);



% --- Outputs from this function are returned to the command line.
function varargout = PI_GUI_OutputFcn(hObject, eventdata, handles)
%% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
%% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% ----------- CALLBACKS -----------------------







% --------------------------------------------------------------------
function ImagemCarregar_Callback(hObject, eventdata, handles)
%% hObject    handle to ImagemCarregar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Carrega uma ou múltiplas imagens a partir de uma interface de
% carregamento PI_GUIcarrega

imdata = PI_GUIcarrega(evalin('base','imdata'));


if imdata.controlindex > 1
    set(handles.slider1,'Min',1);
    set(handles.slider1,'Max',imdata.controlindex);
    set(handles.slider1,'SliderStep',[1/(imdata.controlindex-1) 1/(imdata.controlindex-1)])
    set(handles.slider1,'Visible','on');
end


%% handles dos objetos
imdata.SYSTEM.ax1=handles.imaxesORI;
imdata.SYSTEM.ax2=handles.imaxesESC;
imdata.SYSTEM.ax3=handles.imaxesLCO;
imdata.SYSTEM.hx1=handles.Haxes;
imdata.SYSTEM.hx2=handles.Eaxes;
imdata.SYSTEM.hx3=handles.Laxes;
imdata.SYSTEM.hx4=handles.histaxes;
imdata.SYSTEM.t1=handles.text16;        %C Global originais
imdata.SYSTEM.t2=handles.text17;        %C Global escolhidas
imdata.SYSTEM.t3=handles.text18;        %C Global luminacia corrigida
imdata.SYSTEM.t4=handles.text22;        %C imagem original
imdata.SYSTEM.t5=handles.text23;        %C imagem escolhida
imdata.SYSTEM.t6=handles.text24;        %C imagem luminancia corrigida
imdata.SYSTEM.t7=handles.text25;
imdata.SYSTEM.s1=handles.slider1;
%%

assignin('base','imdata',imdata);

slvalue=get(handles.slider1,'Value');

imatribui(imdata, handles, slvalue);


% --------------------------------------------------------------------
function Fechar_Callback(hObject, eventdata, handles)
%% hObject    handle to Fechar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clearStr='clear all';
evalin('base',clearStr);

delete(handles.PI_GUI);



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
%% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%slider atualiza a informação de todos os objetos para o indice definido

imdata=evalin('base','imdata');
imdata.sliderValue = round(get(handles.slider1,'Value'))

axes(handles.imaxesORI);
imshow(imdata.imagem.ORI{1,imdata.sliderValue});
axes(handles.imaxesESC);
imshow(imdata.imagem.ESC{1,imdata.sliderValue});
axes(handles.imaxesLCO);
imshow(imdata.imagem.LCO{1,imdata.sliderValue});

% mostraH(imdata, handles,imdata.sliderValue)

if imdata.ParC.Check == 1
    mostrahist(imdata, handles, imdata.sliderValue)
end

imatribui(imdata, handles, imdata.sliderValue);

assignin('base','imdata',imdata);



% --------------------------------------------------------------------

function Ajustar_Callback(hObject, eventdata, handles)
%% hObject    handle to Ajustar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% calcula os parametros de cinzento


imdata=evalin('base','imdata');

index = imdata.controlindex(1,1);

if imdata.maskon==0  %não tem mascara
    for idx=1:index
        fig1 = imdata.imagem.ESC{1,idx};
        corr = imdata.ParC.GlobalESC - imdata.ParC.ESC(1,idx);
        imdata.imagem.LCO{1,idx} = fig1 + corr;
        
    end
else %existe uma mascara aplicada
    
    for idx1=1:index
        fig1 = imdata.imagem.ESC{1,idx1};
        corr = imdata.ParC.GlobalESC - imdata.ParC.ESC(1,idx1);
        imdata.imagem.LCO{1,idx1} = fig1 + corr;
        a= imdata.filtro.FIL{1,idx1};
        b=imdata.imagem.LCO{1,idx1};
        b(a == 0)=imdata.ParC.GlobalESC;
        imdata.imagem.LCO{1,idx1}=b;
        b(a == 0)=uint8(imdata.ParC.GlobalESC);
        imdata.imagem.LCO{2,idx1}=b;
    end
    
end



imdata=CalcParC(imdata);
mostrahist(imdata, handles, get(handles.slider1,'Value'));

Value = get(handles.slider1,'Value');
axes(handles.imaxesLCO);
imshow(imdata.imagem.LCO{1,Value});

imatribui(imdata, handles, Value);



for i=1:index
    
    % calculo do contraste das imagens
    [l,c]=size(imdata.imagem.LCO{1,i});
    i
    count=0;
    for i1=1:l
        for i2=1:c
            if(imdata.filtro.FIL{1,i}(i1,i2)==1)
                count=count+1;
                gg(count)=imdata.imagem.LCO{1,i}(i1,i2);
            end
        end
    end
    
    assignin('base','gg',gg);
    
    imdata.STATS.Limage{1,i}=double(gg);
    
    assignin('base','imdata',imdata);
    
%     if(i==1)
%         imdata.STATS.Limage=transpose(gg);
%     else
%         imdata.STATS.Limage(:,i)=transpose(gg);
%     end
    
    
end

for i=1:index
imdata.STATS.std(i)=std(imdata.STATS.Limage{1,i});

end
    assignin('base','imdata',imdata);
    
    

imdata.STATS.stdstd=std(imdata.STATS.std);
imdata.STATS.mstd=mean(imdata.STATS.std);
imdata.STATS.zim=(imdata.STATS.std-imdata.STATS.mstd)/imdata.STATS.stdstd;

figure;
plot(imdata.STATS.zim);
fim=1


assignin('base','imdata',imdata);

% --------------------------------------------------------------------





% --------------------------------------------------------------------
function Calcular_Callback(hObject, eventdata, handles)
%% hObject    handle to Calcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function GravaImagens_Callback(hObject, eventdata, handles)
%% hObject    handle to GravaImagens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata=evalin('base','imdata');
imdata.newpathname={''};

v=[];
diffpoint=[];
for i=1:imdata.controlindex-1
    
    R(i)=strcmp(imdata.pathname{1,i},imdata.pathname{1,i+1});
    R1(i)=i;
    R2(i)=i+1;
    
    if R(i)==0
        diffpoint=[diffpoint i];
    end
    
    
end

R1(diffpoint);
R2(diffpoint);

assignin('base','diffpoint',diffpoint);

if ~isempty(diffpoint)

    a=imdata.pathname{1,R1(diffpoint)};
    b=imdata.pathname{1,R2(diffpoint)};
    
    l1=length(a);
    l2=length(b);
    
    for l=1:min(l1,l2)
        if a(1,l)==b(1,l)
        else
            v=[v l];
        end
    end
    
    c=strfind(a,'\');
    m=abs(c-v(1));
    ind=find(m==min(m));
    
    newpathname1=a(1,c(ind):l1);
    newpathname2=b(1,c(ind):l2);
    
    for i=1:imdata.controlindex
        
        teststr1= imdata.pathname{1,i};
        
        if strcmp(teststr1, a)
            imdata.newpathname{1,i}=newpathname1;
            
        else
            imdata.newpathname{1,i}=newpathname2;
        end
    end
end



for i=1:imdata.controlindex
    a = imdata.imagem.LCO{2,i};
    filename = imdata.filename{1,i};
    
    if isempty(diffpoint)
        new='\';
        
    else    
    new = imdata.newpathname{1,i};
    end
    
    outpath = ['D:\Dropbox\MATHLAB.Dropbox\Copy_of_Processador de imagem\Final', new]
    
    
    exist(outpath, 'dir')
    
    if ~exist(outpath, 'dir')
        mkdir(outpath);
    end
    
    outname = [outpath filename];
    imwrite(a, outname);
    
end
T=table(transpose(imdata.filename), transpose(imdata.STATS.std), transpose(imdata.STATS.zim), transpose(imdata.ParC.LCO),'VariableNames',{'file','std','zim','cinza'});

outname2=['D:\Dropbox\MATHLAB.Dropbox\Copy_of_Processador de imagem\RESULTADOS\' 'stats_output.xls'];
writetable(T, outname2);






% --------------------------------------------------------------------
function Escolher_Callback(hObject, eventdata, handles)
% hObject    handle to Escolher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

IMselec;


% --------------------------------------------------------------------
function FiltroCarregar_Callback(hObject, eventdata, handles)
% hObject    handle to FiltroCarregar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata=evalin('base','imdata');

%   CARREGAR um filtro comum a todas as imagens
[filename, pathname]=uigetfile ('*.png');

fullname=strcat(pathname,filename);

for index1=1:imdata.controlindex
    imdata.filtro.filename{1,index1}=filename;
    imdata.filtro.pathname{1,index1}=pathname;
    imdata.filtro.fulname{1,index1}=fullname;
    
    a=uint8(imread(filename));
    imdata.filtro.FIL{1,index1}=a;
    b=imdata.imagem.ESC{1,index1};
    
    imdata.imagem.ESC{1,index1} = b .*a;
    imdata.imagem.LCO{1,index1} = b .*a;
    
end


imdata.maskon=1;
assignin('base', 'imdata', imdata);




imatribui(imdata, handles, imdata.sliderValue);


% --------------------------------------------------------------------
function GravaProjeto_Callback(hObject, eventdata, handles)
% hObject    handle to GravaProjeto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function FiltroCriar_Callback(hObject, eventdata, handles)
%% hObject    handle to FiltroCriar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% imdata=evalin('base','imdata');
% 
% for index2=1:imdata.controlindex
%     
%     imagem=imdata.imagem.ORI{1,index2};
%     
%     [~,~,n]=size(imagem); % determinação do tamanho da matriz
%     
%     
%     if n==3
%         
%         
%         S=sum(sum(imagem));
%         x=find(S==min(S));
% 
%         imaD=imagem(:,:,x);
%         imagemG=rgb2gray(imagem);
%     else
%         imaD=imagem;
%         imagemG=imagem;
%     end
%     
%     Cestimado=mean(mean(imaD));  % a mascara distingue a partir de um valor de referência (fundo)
%     imdata.ParC.EST1(index2)=Cestimado;
%     
% %     mask=MaskCreation(imagemG, Cestimado);
% 
% mask=MaskCreation(imagem, Cestimado);
%     
%     
%     imdata.filtro.FIL{1,index2}=mask;
%     
%     %    b=imdata.imagem.ESC{1,index2};
%     %
% %        imdata.imagem.ESC{1,index2} = imagemG .* mask;
% %        imdata.imagem.LCO{1,index2} = imagemG .* mask;
%     
% end
% 
% 
% imdata.maskon=1;
% assignin('base', 'imdata', imdata);
% 
% 
% imatribui(imdata, handles, imdata.sliderValue);
% 
% disp ('Fim')

%% nova imagem criar fundo vermelho

imdata=evalin('base','imdata');

for index2=1:imdata.controlindex
    
    imagem=imdata.imagem.ORI{1,index2};
    
    [l,c,n]=size(imagem); % determinação do tamanho da matriz
    
    
    if n==3
        
        
        imagemG=rgb2gray(imagem);
    else
        
        imagemG=imagem;
    end
    
    CORcat=zeros(l,c);
    
    
    % categorização com base na cor
    COR_R = imagem(:,:,1);
    COR_G = imagem(:,:,2);
    COR_B = imagem(:,:,3);
    
    
    for i=1:l
        for j=1:c
            if COR_R(i,j)>140 && COR_G(i,j)<90 && COR_B(i,j)<90
                CORcat(i,j)=1;
            end
        end
    end
    
    
    
    mask=uint8(~CORcat);
    
    
    imdata.filtro.FIL{1,index2}=mask;
    
    %    b=imdata.imagem.ESC{1,index2};
    %
    %        imdata.imagem.ESC{1,index2} = imagemG .* mask;
    %        imdata.imagem.LCO{1,index2} = imagemG .* mask;
    
end


imdata.maskon=1;
assignin('base', 'imdata', imdata);


imatribui(imdata, handles, imdata.sliderValue);

disp ('Fim')
%
%% ____FIM__________





% --------------------------------------------------------------------
function corrigir_Callback(hObject, eventdata, handles)
% hObject    handle to corrigir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


MaskEditor();


% --------------------------------------------------------------------
function CentrarRedimensionar_Callback(hObject, eventdata, handles)
% hObject    handle to CentrarRedimensionar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata=evalin('base','imdata');


%% Ajustar tamanho pelas áreas de interesse

for idx2=1:imdata.controlindex
    imdata.filtro.area(idx2)=sqrt(sum(sum(imdata.filtro.FIL{1,idx2})));
    assignin('base','imdata',imdata);
end

ref=max(imdata.filtro.area);

for idx3=1:imdata.controlindex
    
        
    imdata.filtro.FIL{1,idx3}=imresize(imdata.filtro.FIL{1,idx3},ref/imdata.filtro.area(idx3));
    
    imdata.imagem.ESC{1,idx3}=imresize(imdata.imagem.ESC{1,idx3},ref/imdata.filtro.area(idx3));
    imdata.imagem.LCO{1,idx3}=imresize(imdata.imagem.LCO{1,idx3},ref/imdata.filtro.area(idx3));
    imdata.imagem.CBASE{1,idx3}=imresize(imdata.imagem.CBASE{1,idx3},ref/imdata.filtro.area(idx3));
    
    imdata.imagem.tamanho(:,idx3)=transpose(size(imdata.imagem.ESC{1,idx3}));
    
    
    assignin('base','imdata',imdata);
end




% Marcação do ponto de alinhamento das imagens
figure;

for idx=1:imdata.controlindex
    imshow(imdata.imagem.ESC{1,idx});
    [c,l]=ginput(1);
    
    imdata.imagem.LinhasColunas(1,idx)=floor(l);
    imdata.imagem.LinhasColunas(2,idx)=floor(c);

    assignin('base','imdata',imdata);
end

close(gcf);




%% Uniformizar tela

z=max(max(imdata.imagem.tamanho));

z1=floor(z*1.5);

ns=uint8(zeros(z1));
ns(:,:)=255;
imdata.imagem.ns=ns;
ns(:,:)=0;

imdata.filtro.ns=ns;

tam=floor(z1/2)

for idx1=1:imdata.controlindex

    im1=imdata.imagem.ns;
    
   im1(tam-imdata.imagem.LinhasColunas(1,idx1)+1:tam-imdata.imagem.LinhasColunas(1,idx1)+imdata.imagem.tamanho(1,idx1),...
       tam-imdata.imagem.LinhasColunas(2,idx1)+1:tam-imdata.imagem.LinhasColunas(2,idx1)+imdata.imagem.tamanho(2,idx1))=imdata.imagem.CBASE{1,idx1};
   
    im2=imdata.filtro.ns;
    
   im2(tam-imdata.imagem.LinhasColunas(1,idx1)+1:tam-imdata.imagem.LinhasColunas(1,idx1)+imdata.imagem.tamanho(1,idx1),...
       tam-imdata.imagem.LinhasColunas(2,idx1)+1:tam-imdata.imagem.LinhasColunas(2,idx1)+imdata.imagem.tamanho(2,idx1))=imdata.filtro.FIL{1,idx1};
    
    
    imdata.imagem.CBASE{1,idx1}=im1;
    imdata.imagem.ESC{1,idx1}=im1;
    imdata.imagem.LCO{1,idx1}=im1;
    
    imdata.filtro.FIL{1,idx1}=im2;
    
     assignin('base','imdata',imdata);
end


% --------------------------------------------------------------------
function Cortar_Callback(hObject, eventdata, handles)
% hObject    handle to Cortar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imdata=evalin('base','imdata');
a=0;
for idx=1:imdata.controlindex
    a=a+imdata.filtro.FIL{1,idx};
    
end

f1=figure;
imshow(a*255)
r=getrect(f1);
r=floor(r);
close(f1);

for idx2=1:imdata.controlindex

    imdata.imagem.CBASE{1,idx2}=imdata.imagem.CBASE{1,idx2}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.imagem.ESC{1,idx2}=imdata.imagem.ESC{1,idx2}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.imagem.LCO{1,idx2}=imdata.imagem.LCO{1,idx2}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.filtro.FIL{1,idx2}=imdata.filtro.FIL{1,idx2}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    


    
end

assignin('base','imdata',imdata);


% --------------------------------------------------------------------
function Cortar_imag_Callback(hObject, eventdata, handles)
% hObject    handle to Cortar_imag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


imdata=evalin('base','imdata');


for idx=1:imdata.controlindex
    f1=figure;
    imshow(imdata.imagem.ORI{1,idx})
    r=getrect(f1);
    r=floor(r);
    
    
    imdata.imagem.CBASE{1,idx}=imdata.imagem.CBASE{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.imagem.ESC{1,idx}=imdata.imagem.ESC{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    imdata.imagem.LCO{1,idx}=imdata.imagem.LCO{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    
    if imdata.maskon==1
    imdata.filtro.FIL{1,idx}=imdata.filtro.FIL{1,idx}(r(2):r(2)+r(4),r(1):r(1)+r(3));
    end
    
    close(f1);
    
end

assignin('base','imdata',imdata);






