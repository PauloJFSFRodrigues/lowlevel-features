function  imatribui(imdata, handles, slvalue);
%IMATRIBUI Summary of this function goes here
%   Detailed explanation goes here

axes(imdata.SYSTEM.ax1);
imshow(imdata.imagem.ORI{1,slvalue})
axes(imdata.SYSTEM.ax2);
imshow(imdata.imagem.ESC{1,slvalue})
axes(imdata.SYSTEM.ax3);
imshow(imdata.imagem.LCO{1,slvalue})

imdata=CalcParC(imdata);
mostrahist(imdata, handles, slvalue);
mostraH(imdata, handles, slvalue);

% set(imdata.SYSTEM.t1,'String',imdata.ParC.GlobalORI);
set(imdata.SYSTEM.t2,'String',imdata.ParC.GlobalESC);
set(imdata.SYSTEM.t3,'String',imdata.ParC.GlobalLCO);

% set(imdata.SYSTEM.t4,'String',imdata.ParC.ORI(1,slvalue));
set(imdata.SYSTEM.t5,'String',imdata.ParC.ESC(1,slvalue));
set(imdata.SYSTEM.t6,'String',imdata.ParC.LCO(1,slvalue));

set(imdata.SYSTEM.t7,'String',slvalue);
set(imdata.SYSTEM.s1,'Value',slvalue);



end
