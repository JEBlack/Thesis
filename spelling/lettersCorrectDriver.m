function [setCorrect,averageCorrect] = lettersCorrectDriver(W1,W2,biasW,wordsSize,words,phonRep,vRep)
%Driver function for number of phonemes correct
%   Applied phonemesCorrect() to every word in set and return average #
%   correct per word
    
    totalCorrect=zeros(wordsSize,6);
    for idx = 1:wordsSize %check every word
        
        i=words(idx,2); %input and target
        i=fPhon(i,phonRep,vRep);
        target=words(idx,1);
        target=fOrth(target);

        
        %calculate output
        hid=newlogistic(i*W1); 
        out=newlogistic(hid*W2+biasW);
        
        totalCorrect(idx,:)=lettersCorrect(out, target);
        
    end
    setCorrect=sum(totalCorrect)./wordsSize;
    
    averageCorrect=sum(totalCorrect,'all')/wordsSize;
    
end



