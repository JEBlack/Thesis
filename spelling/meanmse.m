function meanMSE = meanmse(W1, W2, biasW)
%Calculate the mean of the mse of all words in the set. 
    
     global words
     global wordsSize
    
    totalMSE=[];
    
    for idx = 1:wordsSize
        i=words(idx,1); %input and target
        i=fOrth(i);
        target=words(idx,2);
        target=fPhon(target);
        
        %calculate output
        hid=newlogistic(i*W1);
        out=newlogistic(hid*W2+biasW);
        
        totalMSE=[totalMSE mean((target-out).^2)];
    end
    
    meanMSE=mean(totalMSE);
    
end 

