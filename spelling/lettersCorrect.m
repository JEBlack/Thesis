function correct = lettersCorrect(word,target)
%Calculates the number of phoneme the model guessed correctly. 
    %cosine similarity between each phoneme in output and each possible
    %phoneme

    %global phonRep
%     
%     phonRep=readtable('phonRep.xlsx')

    %create letter reps
    
    %letters=zeros(26,26);
    letters(1:26,1:26)=-1;
    
    for i=1:26
        letters(i,i)=1;
    end 
   
    
    %split into letters
    word = [word(1:26); word(27:52); word(53:78); word(79:104); word(105:130);word(131:156)]';
    target= [target(1:26); target(27:52); target(53:78); target(79:104); target(105:130); target(131:156)]';
    
    correct=zeros(1,6);
    
    %for each sound
    for slot= 1:6
        
        %guessed sound
        letter=word(:,slot);
        
        %calculate maximum cosine similarity
        maxi=0;
        maxcos=0;
        for i = 1:26
        
            sub1=sqrt(sum(letter.^2)); 
            sub2=sqrt(sum(letters(:,i).^2));
            cossim=sum(letter.*letters(:,i))/(sub1*sub2);

            if(cossim>maxcos) %new most similar letter
                maxcos=cossim;
                maxi=i;
            end
        end
        
        if(maxi==0)  %check the zero vector if cossim never above 0
            if(zeros(26,1)==target(:,slot))
                correct(slot)=1; %if actually 0 vector, count as correct
            else
                %do nothing
            end 
        else %check if guess matches target sound
            if(letters(:,maxi)==target(:,slot)) %if phoneme matches the target phoneme, count as correct
                correct(slot)=1;
            else
            	%do nothing
            end 
        end 
        
    end
    
        
 
end

