function mostraH( imdata, handles, Value )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here




axes(imdata.SYSTEM.hx1);
histogram(imdata.imagem.ORI{1,Value},[0:1:255]);

axes(imdata.SYSTEM.hx2);
histogram(imdata.imagem.ESC{1,Value},256);

axes(imdata.SYSTEM.hx3);
histogram(imdata.imagem.LCO{1,Value},256);

end

