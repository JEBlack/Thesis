

function rep = fOldPhon(word)
%Converts a word to its phonological representation
%   Can call with input as a table or as a char array, eg. fPhon(words(1,3)
%   or fPhon('bay').
%   Coding scheme derived from Harm & Seidenburg 1999.

    
    %local variables
    phonRep=readtable('phonRep.xlsx');
    vowels=['i','I','E','e','A','c','O','q','U','u','V','R','a'];
    
    %if table, convert
    if(isa(word,'table')) 
        word=table2array(word);
    end
    
    word=char(word); %break up letters
    rep=zeros(6,11); %representation is a 6x11 array
    
    %vowel-center representations
    rep(1,:)=table2array(phonRep(:,word(1))); %consonant always first
    if(ismember(word(2),vowels))
        rep(3,:)=table2array(phonRep(:,word(2))); %no initial consonant cluster
        if(ismember(word(3),vowels))
            rep(4,:)=table2array(phonRep(:,word(3))); %second vowel
            rep(5,:)=table2array(phonRep(:,word(4)));
            if(length(word)==5)
                rep(6,:)=table2array(phonRep(:,word(5))); %final consonant cluster
            end
        else
            rep(5,:)=table2array(phonRep(:,word(3))); %no second vowel
            if(length(word)==4)
                rep(6,:)=table2array(phonRep(:,word(4))); %final consonant cluster
            end
        end
    else
        rep(2,:)=table2array(phonRep(:,word(2))); %initial consonant cluster
        rep(3,:)=table2array(phonRep(:,word(3)));
        if(ismember(word(4),vowels))
            rep(4,:)=table2array(phonRep(:,word(4))); %second vowel
            rep(5,:)=table2array(phonRep(:,word(5)));
            if(length(word)==6)
                rep(6,:)=table2array(phonRep(:,word(6))); %final cluster
            end
        else
            rep(5,:)=table2array(phonRep(:,word(4))); %no second vowel
            if(length(word)==5)
                rep(6,:)=table2array(phonRep(:,word(5)));%final cluster
            end
        end     
    end



end

