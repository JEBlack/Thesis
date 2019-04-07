function meanMSE = spellingmse(W1, W2, biasW, wordsSize, words, phonRep, vRep)
%Calculate the mean of the mse of all words in the set. 
%SPELLING
    
%      global words
%      global wordsSize
    
    totalMSE=[];

%    vRep = readtable('vRep.xlsx');
%    cRep = readtable('cRep.xlsx');
    
    for idx = 1:wordsSize
        i=words(idx,2); %input and target
        i=fPhon(i,phonRep,vRep);
        target=words(idx,1);
        target=fOrth(target);
        
        %calculate output
        hid=newlogistic(i*W1);
        out=newlogistic(hid*W2+biasW);
        
        totalMSE=[totalMSE mean((target-out).^2)];
    end
    
    meanMSE=mean(totalMSE);
    
end 

