function found = targetWords(words, wordsSize, targetO, targetP)

ortho={};
phono={};

    for i = 1:wordsSize
        pword=words(i,2); % phonology
        pword=table2array(pword);
        pword=pword{1,:};
        pword=strsplit(pword,'.'); %break up letters, becomes cell array

        oword=words(i,1); %orthography
        oword=table2array(oword);
        oword=oword{1,:};

        
        if(sum(ismember(targetO,oword))==2 && ismember(targetP,pword)) 
             phono=[phono,words{i,2}];    
             ortho=[ortho,words{i,1}];
        end 
        
        
    end
    
    found=table(ortho.',phono.');
    

end

