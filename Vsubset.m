function [subset, rep] = Vsubset(pword)
%Returns a subset of 8 words that vary from input word only by the medial vowel

%   Input: 'pword' is the local phonological representation of a word. Can either be
%   called directly from the words table, for example:
%   Psubset(words(580,2)), or a representation can be manually entered, 
%   using IPHOD glyphs, for example: Psubset('K.AE.T')

%   Outputs: 'subset' contains an 8x60 array with a distributed phonological
%   representation of a word in each row.
%   'rep' contains an 8x6 array of local glyphs (readable) 


    global vRep
    global subsetSize
    
    
    if(isa(pword,'table'))
         pword=table2array(pword);
         pword=pword{1,:};
     end
    
    
    
    vowels=vRep(:,2:16);
    sounds=strsplit(pword, '.');
    v=ismember(sounds,vowels.Properties.VariableNames); %either 2 or 3
    
    newVowels=removevars(vowels,sounds(v));
    vowelnames=newVowels.Properties.VariableNames;
    s=size(vowelnames);
    idx=randperm(s(2));
    
    
    original=fPhon(pword);
    subset=original;
    for i=1:subsetSize-1
        newWord=original;
        %disp(vowelnames(idx(i)))
        newWord(:,25:36)=table2array(vowels(:,table2array(vowelnames(idx(i)))));
        subset=[subset;newWord];
    end
    
    
    rep={pword};
    for i=1:subsetSize-1
        newWord=sounds;
        newWord(:,v)=vowelnames(idx(i));
        newWord={strjoin(newWord,'.')};
        rep=[rep;newWord];
    end
    
    %randomly order the sets
    order=randperm(size(subset,1));
    subset=subset(order,:); 
    rep=rep(order,:);
    

end

