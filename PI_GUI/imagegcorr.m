clear; clc;
%   SCRIPT PARA AJUSTE DE LUMINÂNCIAS DE DIVERSAS IMAGENS
%   by Paulo Rodrigues

%   CARREGAR AS IMAGENS
[filename, pathname]=uigetfile ('*.bmp','MultiSelect','on');

state=iscell(filename);
s=size(filename);

if state == 0
    % só uma imagem
    fname=strcat(pathname,filename);
    index=1;
    A{index}=imread(fname);
else
    % várias imagens
    for index=1:s(2)
        fname = strcat(pathname,filename{index});
        A{index}=imread(fname);
    end
    
end


%   ANALISAR IMAGENS
for index2=1:1:index
    h=hist(A{index2},0:1:255);
    B{index2}=sum(h,2);
end