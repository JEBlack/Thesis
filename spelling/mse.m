function meanMSE = mse(W1, W2, biasW,wordsSize,words,phonRep, vRep)
%Calculate the mean of the mse of all words in the set. 
    
%      global words
%      global wordsSize
    
    totalMSE=[];
    
    
    for idx = 1:wordsSize
        letters=words(idx,1); %input and target
        letters=fOrth(letters);
        target=words(idx,2);
        target=fPhon(target, phonRep,vRep);
        
        %calculate output
        hid=newlogistic(letters*W1);
        phon=newlogistic(hid*W2+biasW);
        
        totalMSE=[totalMSE mean((target-phon).^2)];
    end
    
    meanMSE=mean(totalMSE);
    
end 

