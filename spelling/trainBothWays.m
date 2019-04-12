%Spell and Read

clear;

if isempty(gcp('nocreate'))
    %no pool
    parpool(16);  %tells the number of cores (CPUs) you want to use.
else
    %do nothing
end


tSize=1000; % number of words in training set

phonRep=readtable('phonRep.xlsx');

vRep = readtable('vRep.xlsx');
cRep = readtable('cRep.xlsx');

    
% Construct training set



words=readtable('trainingOrthoPhono.xlsx');
words=cleanUp(words); % remove any words that don't fit the criteria

wordsSize=size(words); % size of word set
wordsSize=wordsSize(1);

%construct training type set

x=[];

for i=0:20
    for j=1:5
        y=zeros(1,300);
        y(1:15*i)=1;
        x=[x;y];
    end
end

%currlearning=x;

[m,n]=size(x);
b=x;

for i= 1:m
    b(i,:)=b(i,randperm(300));
end

interleaved=b;

c=zeros(105,300);

for i= 1:m
    c(i,:)=sort(x(i,:));
end 

currlearning=c;



results=zeros(105,11);



parfor m=1:105
    
    disp(m)
    


% Free Parameters


        n=.01; % learning rate
        alpha= 0.9; % momentum term
        numOut=60; % number of output nodes, phon
        numIn=156; % number of input nodes, ortho 
        numHid=200; % number of hidden nodes
        tSize=1000; % number of words in training set

        a = -0.25; %range of values for initial weights
        b = 0.25;


        %rng(1) %random number seed
        
        
        idxs=randi([1,wordsSize],[1,tSize]); % words to be added to training set
        T=words(idxs,:); % create training set with random words

 % Bound parameters 

    
    % initialize all weight matrices
        W1 = (b-a).*rand(numIn,numHid) + a; 
        W2 = (b-a).*rand(numHid,numOut) + a;  
        biasW=zeros(1,60);

    %initialize deltas for momentum
        deltaW2=0; 
        deltaW1=0;
        
 

% ------------------------------------------------------------------

     
    for i=1:(300-sum(currlearning(m,:)))
        
        if(currlearning(m,i)==0)
            
            for k=1:tSize
           

                %read

                idx=randi([1 tSize],1,1); %pick a random word from training set
                letters=fOrth(T(idx,1)); %input is the orthography
                target=fPhon(T(idx,2),phonRep,vRep); %target is the phonology


                hid=newlogistic(letters*W1); %calculate hidden units
                phon=newlogistic(hid*W2);


                %Backward Pass

                % hid to out
                momentumW2=alpha*deltaW2;
                errOut=(target-phon).*logistic(hid*W2).*(1-logistic(hid*W2)).*2; 
                deltaW2=n*(hid'*errOut);
                W2=W2+deltaW2+momentumW2; 

 
                % in to hid
                momentumW1=alpha*deltaW1;
                errHid=(errOut*W2').*logistic(letters*W1).*(1-logistic(letters*W1)).*2; %where errout*W2' is the difference between target and the actual
                deltaW1=n*(letters'*errHid);
                W1=W1+deltaW1+momentumW1; 
            end
                        
        else
            %spell

            for k=1:tSize
                
                % Forward Pass
                idx=randi([1 tSize],1,1); %pick a random word from training set

                phon=fPhon(T(idx,2),phonRep,vRep); %input is the phonology
                target=fOrth(T(idx,1)); %target is the orthography


                hid=newlogistic(W2*phon')'; %calculate hidden units, 200x1
                letters=newlogistic(hid*W1'); %156x1

                %Backward Pass

                % hid to out
                momentumW1=alpha*deltaW1;
                errOut=(target-letters).*logistic(hid*W1').*(1-logistic(hid*W1')).*2; 
                deltaW1=n*(errOut'*hid);
                W1=W1+deltaW1+momentumW1;


                % in to hid
                momentumW2=alpha*deltaW2;
                errHid=(errOut*W1).*logistic(phon*W2').*(1-logistic(phon*W2')).*2; %where errout*W2' is the difference between target and the actual
                deltaW2=n*(phon'*errHid)';
                W2=W2+deltaW2+momentumW2; 

            end
        end
    end
 



[setCorrectletter, numCorrectletter]= lettersCorrectDriver(W1,W2,biasW,wordsSize,words, phonRep, vRep, 0);

[setCorrectphon, numCorrectphon]= phonemesCorrectDriver(W1,W2,biasW,wordsSize,words, phonRep, vRep);


mseletters = spellingmse(W1, W2, biasW, wordsSize, words, phonRep, vRep,0);
msephon=mse(W1, W2, biasW, wordsSize, words, phonRep, vRep);

results(m,:)=[(300-sum(currlearning(m,:))), setCorrectletter(1), setCorrectletter(3), setCorrectletter(4), numCorrectletter, mseletters, setCorrectphon(1), setCorrectphon(3), setCorrectphon(4), numCorrectphon, msephon];


end 