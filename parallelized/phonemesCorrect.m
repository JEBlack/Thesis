function correct = phonemesCorrect(word,target,phonRep)
%Calculates the number of phoneme the model guessed correctly. 
    %cosine similarity between each phoneme in output and each possible
    %phoneme

    %global phonRep
%     
%     phonRep=readtable('phonRep.xlsx');
    
    phonemes=table2cell(phonRep);
    phonemes=cell2mat(phonemes(:,2:40));
    numPhons=size(phonemes);
    numPhons=numPhons(2);
    
    %split into phonemes
    word = [word(1:12); word(13:24); word(25:36); word(37:48); word(49:60)]';
    target= [target(1:12); target(13:24); target(25:36); target(37:48); target(49:60)]';
    
    correct=zeros(1,5);
    
    %for each sound
    for phon = 1:5
        
        %guessed sound
        sound=word(:,phon);
        
        %calculate maximum cosine similarity
        maxi=0;
        maxcos=0;
        for i = 1:numPhons
        
            sub1=sqrt(sum(sound.^2)); 
            sub2=sqrt(sum(phonemes(:,i).^2));
            cossim=sum(sound.*phonemes(:,i))/(sub1*sub2);

            if(cossim>maxcos) %new most similar phoneme
                maxcos=cossim;
                maxi=i;
            end
        end
        
        if(maxi==0)  %check the zero vector if cossim never above 0
            if(zeros(12,1)==target(:,phon))
                correct(phon)=1; %if actually 0 vector, count as correct
            else
                %do nothing
            end 
        else %check if guess matches target sound
            if(phonemes(:,maxi)==target(:,phon)) %if phoneme matches the target phoneme, count as correct
                correct(phon)=1;
            else
            	%do nothing
            end 
        end 
        
    end
    
        
    end 
    


