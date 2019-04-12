function [setCorrect,averageCorrect] = lettersCorrectDriver(W1,W2,biasW,wordsSize,words,phonRep,vRep,direction)
%Driver function for number of phonemes correct
%   Applied phonemesCorrect() to every word in set and return average #
%   correct per word
%   direction refers to the direction of the original model: direction=0
%   when model goes from letters to phonology, direction=1 when model foes
%   from phonology to letters

totalCorrect=zeros(wordsSize,6);

if(direction==0)
    

    for idx = 1:wordsSize %check every word
        
        phon=words(idx,2); %input and target
        phon=fPhon(phon,phonRep,vRep);
        target=words(idx,1);
        target=fOrth(target);

        
        %calculate output


         hid=newlogistic(W2*phon')'; %calculate hidden units, 200x1
         letters=newlogistic(hid*W1'); %156x1


        totalCorrect(idx,:)=lettersCorrect(letters, target);
        
    end
        
else %spelling
    
    for idx = 1:wordsSize %check every word
        
        phon=words(idx,2); %input and target
        phon=fPhon(phon,phonRep,vRep);
        target=words(idx,1);
        target=fOrth(target);

        
        %calculate output
        hid=newlogistic(phon*W1); 
        out=newlogistic(hid*W2+biasW);
        
        totalCorrect(idx,:)=lettersCorrect(out, target);
    end


    
    
end

    setCorrect=sum(totalCorrect)./wordsSize;
    
    averageCorrect=sum(totalCorrect,'all')/wordsSize;
end


