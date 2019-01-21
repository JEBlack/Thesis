function cleaned = cleanUp(words)
%Cleans up list of words
%   Deletes any words that are vowel-initial or vowel-final, as well as any
%   words with three consonants in a cluster.

%   Assumes words is a table with two columns, the first orthography and
%   the second phonology. 

%   Returns a table of cleaned words; first column is orthography and the 
%   second is phonology


vowels=["IY","IH","EH","AE","AA","AO","OW","UH","UW","AH","ER","AW","EY","OY","AY"];

ortho={};
phono={};
for i=1:size(words,1) 
    word=words(i,2); % we care about the properties of the phonology
    word=table2array(word);
    word=word{1,:};
    
    word=strsplit(word,'.'); %break up letters, becomes cell array
    
    %exclude illegal words
    if(ismember(word{1},vowels) || ismember(word{length(word)},vowels) || length(word)>5) 
        continue
    end

    ortho=[ortho,words{i,1}]; 
    phono=[phono,words{i,2}];
end
    

cleaned=table(ortho.',phono.');


end

