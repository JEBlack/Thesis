function rep = fOrth(word)
%Converts the orthographic representation of a word to a local binary
%representation
%   Outputs a 1x156 vector, with 26 spaces for each of 6 letters

    vowels=['a','e','i','o','u','y'];

    rep=zeros(1,156);
    %rep(:,1:156)=-1;
    if(isa(word,'table'))
         word=table2array(word);
         word=word{1,:};
    end
    ascii=double(word)-96;
    rep(:,ascii(1))=1; %consonant always first
    if(ismember(word(2),vowels))
        rep(:,52+ascii(2))=1; %no initial consonant cluster
        if(ismember(word(3),vowels))
            rep(:,78+ascii(3))=1; %second vowel
            rep(:,104+ascii(4))=1;
            if(length(word)==5)
                rep(:,130+ascii(5))=1; %final consonant cluster
            end
        else
            rep(:,104+ascii(3))=1; %no second vowel
            if(length(word)==4)
                rep(:,130+ascii(4))=1; %final consonant cluster
            end
        end
    else
        rep(:,26+ascii(2))=1; %initial consonant cluster
        rep(:,52+ascii(3))=1;
        if(ismember(word(4),vowels))
            rep(:,78+ascii(4))=1; %second vowel
            rep(:,104+ascii(5))=1; %first consonant
            if(length(word)==6)
                rep(:,130+ascii(6))=1; %final cluster
            end
        else
            rep(:,104+ascii(4))=1; %no second vowel
            if(length(word)==5)
                rep(:,130+ascii(5))=1;%final cluster
            end
        end     
    end
    
end

