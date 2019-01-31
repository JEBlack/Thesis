function cleaned = cleanUp(words)
%Removes unwanted words from a table
%   Deletes any words that are vowel-initial or vowel-final, as well as any
%   words with three consonants in a cluster.

%   Assumes words is a table with two columns, the first orthography and
%   the second phonology. 

%   Returns a table of cleaned words; first column is orthography and the 
%   second is phonology


vowels=["IY","IH","EH","AE","AA","AO","OW","UH","UW","AH","ER","AW","EY","OY","AY"];
ovowels=['a','e','i','o','u','y'];

ortho={};
phono={};
for i=1:size(words,1) 
    
    pword=words(i,2); % phonology
    pword=table2array(pword);
    pword=pword{1,:};
    pword=strsplit(pword,'.'); %break up letters, becomes cell array
    
    oword=words(i,1); %orthography
    oword=table2array(oword);
    oword=oword{1,:};
     
    
    %exclude phonologies
    if(ismember(pword{1},vowels) || ismember(pword{length(pword)},vowels) || (length(pword)==5 && ~ismember(pword{3},vowels)) || length(pword)>5) 
        continue
    end
       
    
    %exclude orthographies, vowel initial/final, longer than 6
    if(ismember(oword(1),ovowels) || ismember(oword(length(oword)),ovowels) || length(oword)>6 || length(oword)<3) 
        continue
    end
    
    % other illegal orthographies: if 5 is vowel, then 4 must be vowel. If
    % 2 is vowel, then 4 cannot be vowel
    if(length(oword)>=5)
        if((ismember(oword(5),ovowels) && ~ismember(oword(4),ovowels)) || (ismember(oword(2),ovowels) && ismember(oword(4),ovowels)))
            continue
        end 
        %no three consonant clusters
        if((~ismember(oword(3),ovowels) && ~ismember(oword(2),ovowels)) || (~ismember(oword(length(oword)-1),ovowels) && ~ismember(oword(length(oword)-2),ovowels)))
            continue
        end 
        %only two vowels
        if((ismember(oword(2),ovowels) && ismember(oword(3),ovowels) && ismember(oword(4),ovowels)) || (ismember(oword(3),ovowels) && ismember(oword(4),ovowels) && ismember(oword(5),ovowels)))
            continue
        end 
            
    end 
    
 
    
    %orthography should be lowercase
    ortho=[ortho,lower(words{i,1})]; 
    phono=[phono,words{i,2}];
end
    

cleaned=table(ortho.',phono.');


end

