function rep = fPhon(word)
%Converts a word to its phonological representation

%   Can call with input as a table or as a char array, eg. fPhon(words(1,2))
%   or fPhon('B.EH.G').

%   Returns a 1x56 vector of phonological features. Any slot that is not
%   used by the word is set to all zeros.

%   Coding scheme derived from Harm & Seidenburg 1999.

    vRep = readtable('vRep.xlsx');
    cRep = readtable('cRep.xlsx');

    
    vowels= vRep.Properties.VariableNames;
    %vowels=['IY', 'IH', 'EH', 'AE', 'AA', 'AO', 'OW', 'UH', 'UW', 'AH', 'ER', 'AW', 'EY', 'OY', 'AY'];
    
    
     if(isa(word,'table'))
         word=table2array(word);
         word=word{1,:};
     end
     
    word=strsplit(word,'.'); %break up letters, becomes cell array

    
    rep=zeros(1,60); %representation is a 1x58 vector
    %rep(:,1:56)=-1;
    
    %vowel-center representations
    rep(1:12)=table2array(cRep(:,word{1})); %consonant always first
    if(ismember(word{2},vowels))
        rep(25:36)=table2array(vRep(:,word{2})); %no initial consonant cluster, v
        rep(37:48)=table2array(cRep(:,word{3})); %c
            if(length(word)==4)
                rep(49:60)=table2array(cRep(:,word{4})); %final consonant cluster
            end
        
    else
        rep(13:24)=table2array(cRep(:,word{2})); %initial consonant cluster, c
        rep(25:36)=table2array(vRep(:,word{3})); % v
        rep(37:48)=table2array(cRep(:,word{4})); %c
        if(length(word)==5)
            rep(49:60)=table2array(cRep(:,word{5})); %final cluster
        end
       
    end     

end

