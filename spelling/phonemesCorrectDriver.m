function [setCorrect,averageCorrect] = phonemesCorrectDriver(W1,W2,biasW,wordsSize,words,phonRep,vRep)
%Driver function for number of phonemes correct
%   Applied phonemesCorrect() to every word in set and return average #
%   correct per word

%     global words
%     global wordsSize


%    vRep = readtable('vRep.xlsx');
%    cRep = readtable('cRep.xlsx');
    
%    phonRep=readtable('phonRep.xlsx');
    
    totalCorrect=zeros(wordsSize,5);
    for idx = 1:wordsSize %check every word
        
        i=words(idx,1); %input and target
        i=fOrth(i);
        target=words(idx,2);
        target=fPhon(target,phonRep,vRep);
        
        %calculate output
        hid=newlogistic(i*W1); 
        out=newlogistic(hid*W2+biasW);
        
        totalCorrect(idx,:)=phonemesCorrect(out, target, phonRep);
        
    end
    setCorrect=sum(totalCorrect)./wordsSize;
    
    averageCorrect=sum(totalCorrect,'all')/wordsSize;
    
end

