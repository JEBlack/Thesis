function [subset, rep] = finalSubset(pword)
%Returns a subset of 8 words that vary from input word only by the final
%consonant

%   Input: 'pword' is the local phonological representation of a word. Can either be
%   called directly from the words table, for example:
%   Psubset(words(580,2)), or a representation can be manually entered, 
%   using IPHOD glyphs, for example: Psubset('K.AE.T')

%   Outputs: 'subset' contains an 8x60 array with a distributed phonological
%   representation of a word in each row.
%   'rep' contains an 8x6 array of local glyphs (readable) 


    global cRep
    global subsetSize
    
    
    if(isa(pword,'table'))
         pword=table2array(pword);
         pword=pword{1,:};
     end
    
    
    
    consonants=cRep(:,2:25);
    sounds=strsplit(pword, '.');
    c=5;
    
    newCon=removevars(consonants,sounds(length(sounds)));
    connames=newCon.Properties.VariableNames;
    s=size(connames);
    idx=randperm(s(2));
    
    
    original=fPhon(pword);
    if original(:,49:60)==0
        c=4;
    end 
    
    subset=original;
    for i=1:subsetSize-1
        newWord=original;
        %disp(vowelnames(idx(i)))
        newWord(:,(((c-1)*12)+1):(c*12))=table2array(consonants(:,table2array(connames(idx(i)))));
        subset=[subset;newWord];
    end
    
    rep={pword};
    %rep(1,1:length(pword))=pword;
    for i=1:subsetSize-1
        newWord=sounds;
        newWord(:,length(sounds))=connames(idx(i));
        newWord={strjoin(newWord,'.')};
        rep=[rep;newWord];
    end
    
    %randomly order the sets
    order=randperm(size(subset,1));
    subset=subset(order,:); 
    rep=rep(order,:);
    

end