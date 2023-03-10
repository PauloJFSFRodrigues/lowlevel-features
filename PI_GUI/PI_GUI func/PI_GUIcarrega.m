
function [imdata] = PI_GUIcarrega( imdata)
%PI_GUICARREGA Summary of this function goes here
%   Detailed explanation goes here


%indicação da última posição utilizada (novas imagens serão acrescentadas a
%partir deste ponto
index1=imdata.controlindex;


%   CARREGAR AS IMAGENS
[filename, pathname]=uigetfile (...
    {'*.png; *.jpg; *.tif; *.bmp','Imagens (*.png, *jpg, *.tif, *.bmp)'} ,'MultiSelect','on');

if isequal(filename,0)
    disp('Não foram selecionados ficheiros')

else
    
    if iscell(filename)
        %carrega várias imagens
        n=size(filename,2);
        for index = 1:n
            fullname=strcat(pathname,filename{index});
            
            imdata.filename{1,index+index1}=filename{index};
            a=imread(filename{index});
               % a=imresize(a,.25);
            imdata.fullname{1,index+index1}=fullname;
            imdata.pathname{1,index+index1}=pathname;
            
            if size(a,3)==3
                b=rgb2gray(a); % se a imagem é rgb converte em grayscale
                
            else
                b=a;
       
            end
            
            imdata.imagem.ORI{1,index+index1}=a;
            imdata.imagem.ESC{1,index+index1}=imadjust(b); % ajuste básico da intensidade da imagem
            imdata.imagem.LCO{1,index+index1}=imadjust(b);
            imdata.imagem.CBASE{1,index+index1}=imadjust(b);
            imdata.ParC.EST1(1, index+index1)=0;
            
            imdata.imagem.tamanho(:,index+index1)=transpose(size(b));
            
            imdata.controlindex=index1+n;
        end
        
        
    else
        %carrega 1 imagem
        fullname=strcat(pathname,filename);
        
        imdata.filename{1,index1+1}=filename;
        a=imread(filename);
            % a=imresize(a,.25);
        imdata.fullname{1,index1+1}=fullname;
        imdata.pathname{1,index1+1}=pathname;
        
        if size(a,3)==3
            b=rgb2gray(a);

        else
            b=a;

        end
        
        imdata.imagem.ORI{1,index1+1}=a;
        imdata.imagem.ESC{1,index1+1}=imadjust(b);
        imdata.imagem.LCO{1,index1+1}=imadjust(b);
        imdata.imagem.CBASE{1,index1+1}=imadjust(b);
         imdata.ParC.EST1(1, index1+1)=0;
        
        imdata.imagem.tamanho(:,index1+1)=transpose(size(b));
        
        imdata.controlindex=index1+1;
        
    end
end

