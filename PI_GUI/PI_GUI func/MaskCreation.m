function mask = MaskCreation(imagem, Cestimado)
%MASKCREATION Summary of this function goes here
%   Detailed explanation goes here

imdata=evalin('base', 'imdata');


[l,c,n]=size(imagem);

if n==3
    %imagem=rgb2gray(imagem);
    
    v=mean(mean(imagem));
    z=find(v==min(v));
    imagem=imagem(:,:,z);
    
end


mask1=imagem>=Cestimado;  % a mascara distingue a partir de um valor de referência (fundo)




% figure
% imshow(mask1)
% title('M1')


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
        
        if somaij >=8 && mask1(i,j)==0
            mask2(i,j)=1;
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

mask=uint8(~mask2);

%figure; imshow(mask.*imagem)

imdata.filtro.FIL{1,1}=mask;

assignin('base','imdata',imdata);

end

