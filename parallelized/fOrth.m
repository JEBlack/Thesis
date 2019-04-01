function rep = fOrth(word)
%Converts the orthographic representation of a word to a local binary
%representation. 
%   Outputs a 1x156 vector, with 26 spaces for each of 6 letters
%   Each letter represented by 26 nodes. One of those nodes represents one
%   of the letters of the alphabet. Placement is determined by ascii
%   values. The node which represents the appropriate letter is 'on' (set
%   to 1) and all others are 'off' (set to -1).
%   Nodes in letter slots which are not used by the word are set to all
%   zeros. For example, the second consonant slot in 'cat' would consist of
%   26 zeros.

    vowels=['a','e','i','o','u','y'];

    rep=zeros(1,156);
    rep(:,1:156)=-1;
    
    if(isa(word,'table'))
         word=table2array(word);
         word=word{1,:};
    end
    
    ascii=double(word)-96; 
    
    rep(:,ascii(1))=1; %first consonant, slot1 
    if(ismember(word(2),vowels))
        rep(1,27:52)=0;%no initial consonant cluster, 0s in slot2
        rep(:,52+ascii(2))=1; %vowel, slot 3
        if(ismember(word(3),vowels))
            rep(:,78+ascii(3))=1; %second vowel slot 4
            rep(:,104+ascii(4))=1; %consonant, slot 5
            if(length(word)==5)
                rep(:,130+ascii(5))=1; %final consonant cluster, slot 6
            else
                rep(:,131:156)=0; %no cluster, zeros in slot 6
            end

        else
            rep(:,78:104)=0; %no second vowel, 0s in slot 4
            rep(:,104+ascii(3))=1; %consonant in slot 5
            if(length(word)==4)
                rep(:,130+ascii(4))=1; %final consonant cluster
            else 
                rep(:,131:156)=0; %no cluster, zeros in slot 6
            end
        end
    else
        rep(:,26+ascii(2))=1; %initial consonant cluster
        rep(:,52+ascii(3))=1; %first vowel
        if(ismember(word(4),vowels))
            rep(:,78+ascii(4))=1; %second vowel
            rep(:,104+ascii(5))=1; %first consonant
            if(length(word)==6)
                rep(:,130+ascii(6))=1; %final cluster
            else
                rep(:,131:156)=0; %no cluster, zeros in slot 6
            end
        else
            rep(:,78:104)=0; %no second vowel, 0s in slot 4
            rep(:,104+ascii(4))=1; %consonant in slot 5
            if(length(word)==5)
                rep(:,130+ascii(5))=1;%final cluster, c in slot 6
            else
                rep(:,131:156)=0; %no cluster, zeros in slot 6
            end
        end     
    end
end

