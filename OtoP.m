function phonology = OtoP(orep)
%uses weights to convert orthography to phonology

    global W1
    global W2
    global biasW

    I=fOrth(orep);
    hid=newlogistic(I*W1);
    O=newlogistic(hid*W2+biasW);
    phonology=freadP(O);
    
end

