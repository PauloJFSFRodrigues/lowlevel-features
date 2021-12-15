a=cdata;

figure;
imshow(a);
%% formação da mascara

% a=en;

[l,c,n]=size(b) % determinação do tamanho da matriz


if n==3
    b=rgb2gray(b);
end

mask1=a>=190;   % a mascara distingue a partir de um valor de referência (fundo)

figure;
imshow(mask1);

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

 figure;
 imshow(mask2);
 figure
 f=b.*uint8(~mask2);
  f(f==0)=155;
 imshow(f);
 
 %%
 mask1=mask2;

 for i=3:l-3
    for j=3:c-3
        somaij = ...
        mask1(i-2,j-2) + mask1(i-1,j-2) + mask1(i,j-2) + mask1(i+1,j-2) + mask1(i+2,j-2) + ...
        mask1(i-2,j-1) + mask1(i-1,j-1) + mask1(i,j-1) + mask1(i+1,j-1) + mask1(i+2,j-1) + ...
        mask1(i-2,j)   + mask1(i-1,j)   + mask1(i,j)   + mask1(i+1,j)   + mask1(i+2,j)   + ...
        mask1(i-2,j+1) + mask1(i-1,j+1) + mask1(i,j+1) + mask1(i+1,j+1) + mask1(i+2,j+1) + ...
        mask1(i-2,j+2) + mask1(i-1,j+2) + mask1(i,j+2) + mask1(i+1,j+2) + mask1(i+2,j+2);
    
     if somaij >=11 && mask1(i,j)==0
         mask2(i,j)=1;
     end          
          
    end
 end

%  figure;
%  imshow(mask2);
%  
%   figure;
%  imshow(mask2);
%  figure
 f=b.*uint8(~mask2);
 f(f==0)=155;
 imshow(f);
 
%  d=mask2-mask1;
%  figure
%  imshow(uint8(d)*255)
 
 %%
 % depois de tratamento automático pode ser necessário usar ajustes manuais
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
 
  [m,n]=size(mask2);
  
   if lf>m
     lf=m;
   end
 
     if cf>n
     cf=n;
     end
 
 % aplicação das alterações
 mask2(li:lf,ci:cf)=0;
 imshow(mask2);

 
 
 %%
 
figure 
imshow(x057_0_C1(:,:,1))
figure
imshow(x057_0_C1(:,:,2))
figure
imshow(x057_0_C1(:,:,3))
 
 
 
