function rep = fPhon(word)
%Converts a word to its phonological representation

%   Can call with input as a table or as a char array, eg. fPhon(words(1,2))
%   or fPhon('B.EH.G').

%   Returns a 6x11 array of phonological features

%   Coding scheme derived from Harm & Seidenburg 1999.

    global phonRep
    
    %local variables
    vowels=["IY","IH","EH","AE","AA","AO","OW","UH","UW","AH","ER","AW","EY","OY","AY"];
     
     if(isa(word,'table'))
         word=table2array(word);
         word=word{1,:};
     end
     
    word=strsplit(word,'.'); %break up letters, becomes cell array

    
    rep=zeros(6,11); %representation is a 6x11 array
    
    %vowel-center representations
    rep(1,:)=table2array(phonRep(:,word{1})); %consonant always first
    if(ismember(word{2},vowels))
        rep(3,:)=table2array(phonRep(:,word{2})); %no initial consonant cluster
        if(ismember(word{3},vowels))
            rep(4,:)=table2array(phonRep(:,word{3})); %second vowel
            rep(5,:)=table2array(phonRep(:,word{4}));
            if(length(word)==5)
                rep(6,:)=table2array(phonRep(:,word{5})); %final consonant cluster
            end
        else
            rep(5,:)=table2array(phonRep(:,word{3})); %no second vowel
            if(length(word)==4)
                rep(6,:)=table2array(phonRep(:,word{4})); %final consonant cluster
            end
        end
    else
        rep(2,:)=table2array(phonRep(:,word{2})); %initial consonant cluster
        rep(3,:)=table2array(phonRep(:,word{3}));
        if(ismember(word{4},vowels))
            rep(4,:)=table2array(phonRep(:,word{4})); %second vowel
            rep(5,:)=table2array(phonRep(:,word{5}));
            if(length(word)==6)
                rep(6,:)=table2array(phonRep(:,word{6})); %final cluster
            end
        else
            rep(5,:)=table2array(phonRep(:,word{4})); %no second vowel
            if(length(word)==5)
                rep(6,:)=table2array(phonRep(:,word{5}));%final cluster
            end
        end     
    end

end

