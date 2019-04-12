function meanMSE = spellingmse(W1, W2, biasW, wordsSize, words, phonRep, vRep,direction)
%Calculate the mean of the mse of all words in the set. 
%SPELLING
    
%      global words
%      global wordsSize
    
    totalMSE=[];

%    vRep = readtable('vRep.xlsx');
%    cRep = readtable('cRep.xlsx');

if(direction==0) %reading model
    
        for idx = 1:wordsSize
        phon=words(idx,2); %input and target
        phon=fPhon(phon,phonRep,vRep);
        target=words(idx,1);
        target=fOrth(target);

        
        %calculate output


         hid=newlogistic(W2*phon')'; %calculate hidden units, 200x1
         letters=newlogistic(hid*W1'); %156x1
    
         totalMSE=[totalMSE mean((target-letters).^2)];
        end
else
    
    for idx = 1:wordsSize
        phon=words(idx,2); %input and target
        phon=fPhon(phon,phonRep,vRep);
        target=words(idx,1);
        target=fOrth(target);
        
        %calculate output
        hid=newlogistic(phon*W1);
        letters=newlogistic(hid*W2+biasW);
        
        totalMSE=[totalMSE mean((target-letters).^2)];
    end
    
    
    
end 

meanMSE=mean(totalMSE);
end

