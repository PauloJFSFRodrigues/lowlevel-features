 function [imdata] = CalcParC(imdata)
%CALCPARC Summary of this function goes here
%   Detailed explanation goes here
    
%     e=0;
    f=0;
    g=0;

if imdata.maskon == 0

    
    for index=1:imdata.controlindex
%         a=imdata.imagem.ORI{1,index};
        b=imdata.imagem.ESC{1,index};
        c=imdata.imagem.LCO{1,index};
        
        
%         imdata.ParC.ORI(1,index)=mean(mean(a));
        imdata.ParC.ESC(1,index)=mean(mean(b));
        imdata.ParC.LCO(1,index)=mean(mean(c));
        
%         e=e+imdata.ParC.ORI(1,index);
        f=f+imdata.ParC.ESC(1,index);
        g=g+imdata.ParC.LCO(1,index);
        
    end
    
%     imdata.ParC.GlobalORI=e/imdata.controlindex;
    imdata.ParC.GlobalESC=f/imdata.controlindex;
    imdata.ParC.GlobalLCO=g/imdata.controlindex;
    imdata.ParC.Check=1;
    
else

    
    for index=1:imdata.controlindex
        
%         a=imdata.imagem.ORI{1,index};
        b=imdata.imagem.ESC{1,index};
        c=imdata.imagem.LCO{1,index};
        n=imdata.filtro.FIL{1,index};
        k=b.*n;
        p=c.*n;
        
        
        d=sum(sum(imdata.filtro.FIL{1,index}));
        
        
%         imdata.ParC.ORI(1,index)=mean(mean(a));
        imdata.ParC.ESC(1,index)=sum(sum(k))/d;
        imdata.ParC.LCO(1,index)=sum(sum(p))/d;
        
%         e=e+imdata.ParC.ORI(1,index);
        f=f+imdata.ParC.ESC(1,index);
        g=g+imdata.ParC.LCO(1,index);
        
    end
    
%     imdata.ParC.GlobalORI=e/imdata.controlindex;
    imdata.ParC.GlobalESC=f/imdata.controlindex;
    imdata.ParC.GlobalLCO=g/imdata.controlindex;
    imdata.ParC.Check=1;
    
end


assignin('base','imdata',imdata);

