function [value, word] = chooseWord(oword,pword,func)
%Chooses the word from a set of words that vary by the medial vowel. 
%   Returns the word whose distributed representation is closest to the
%   output representation, as computed by cosine similarity.

%   Can call by referencing word table, for example:
%   [chooseVowel(words(580,1),words(580,2))], or by manually entering a
%   spelling and a phonology, which must use IPHOD glyphs, for example:
%   [chooseVowel('cat','K.AE.T')]

%   Inputs: oword is the orthographic representation, which will act as
%   input into the model. pword is the target phonological representation
%   word output
%   contains the phonological representation of the chosen word. The value
%   output gives the logical 1/0 whether the guessed word matches the
%   target.

    global W1
    global W2
    global biasW
    global subsetSize

    maxcos=0;
    maxi=0;

    if(isa(oword,'table'))
         oword=table2array(oword);
         oword=oword{1,:};
    end
    
    if(isa(pword,'table'))
         pword=table2array(pword);
         pword=pword{1,:};
    end

    orep=fOrth(oword);
    hid=newlogistic(orep*W1);
    O=newlogistic(hid*W2)+biasW; %output of model
    
    [subset,rep]=func(pword); %construct subset
    

    
    %Calculate cosine similarity between output and each word in subset
    for i=1:subsetSize
        sub1=sqrt(sum(O.^2)); 
        sub2=sqrt(sum(subset(i,:).^2));
        cossim=sum(O.*subset(i,:))/(sub1*sub2);

        if(cossim>maxcos) 
            maxcos=cossim;
            maxi=i;
        end
    end
     if(maxi==0) %if no word was similar above 0
        word='-';
     else
         word= (rep(maxi,:));
     end
     
     value=isequal(word,{pword});
        
end

