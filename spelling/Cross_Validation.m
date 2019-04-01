%network

clear;

if isempty(gcp('nocreate'))
    %no pool
    parpool(15);  %tells the number of cores (CPUs) you want to use.
else
    %do nothing
end

global phonRep
global cRep
global vRep
global tSize
global words

tSize=1000; % number of words in training set


numHids = [50, 100, 156, 200, 250];
lrates = [.001, .005, .01, .02];
alphas = [0, 0.85, .9, .95];
initials = [.01, .1, .3];


paramset = [ ];
 
for hu  = 1:5
    for mome = 1:4
        for lrate = 1:4
            for initial = 1:3
                for rep = 1:5
                paramset= [paramset; numHids(hu), alphas(mome), lrates(lrate), initials(initial)];
                end
            end 
        end         
    end
end



phonRep=readtable('phonRep.xlsx');

vRep = readtable('vRep.xlsx');
cRep = readtable('cRep.xlsx');

    
% Construct training set



words=readtable('trainingOrthoPhono.xlsx');
words=cleanUp(words); % remove any words that don't fit the criteria

wordSize=size(words); % size of word set

idxs=randi([1,wordSize(1)],[1,tSize]); % words to be added to training set
T=words(idxs,:); % create training set with random words




results=zeros(1200,8);

parfor m=1:1200

% Free Parameters
        params=paramset(m,:);

        n = params(3); % learning rate
        alpha = params(2); % momentum term
        numOut=60; % number of output nodes, phon
        numIn=156; % number of input nodes, ortho 
        numHid= params(1); % number of hidden nodes


        a = params(4); %range of values for initial weights
        a= -a;
        b = params(4);

        rng(1) %random number seed
        

 % Bound parameters 
        
%     global vRep
%     global cRep
%     global W1
%     global W2
%     global biasW
%     global words


    
    % initialize all weight matrices
        W1 = (b-a).*rand(numIn,numHid) + a; 
        W2 = (b-a).*rand(numHid,numOut) + a; 
        biasW = (b-a).*rand(1,numOut) + a; 

    %initialize deltas for momentum
        deltaW2=0; 
        deltaBias=0;
        deltaW1=0;

    %initialize change for mean sq errors
        prev=0; 

% ------------------------------------------------------------------

     
     
for i=1:15
    for j=1:tSize

        % Forward Pass
        idx=randi([1 tSize],1,1); %pick a random word from training set
        I=fOrth(T(idx,1)); %input is the orthography
        target=fPhon(T(idx,2)); %target is the phonology


        hid=newlogistic(I*W1); %calculate hidden units
        O=newlogistic(hid*W2)+biasW;
        

        %Backward Pass
        
        % hid to out
        momentumW2=alpha*deltaW2;
        errOut=(target-O).*logistic(hid*W2).*(1-logistic(hid*W2)).*2; 
        deltaW2=n*(hid'*errOut);
        W2=W2+deltaW2+momentumW2; 

         % bias to out
         momentumBias=alpha*deltaBias;
         errBias=(target-O).*logistic(biasW).*(1-logistic(biasW)).*2; 
         deltaBias=n*(1.*errBias);
         biasW=biasW+deltaBias+momentumBias; 
        
        
%         d=target-O; 
%         biasW=biasW+n*(d.'*1).';

        % in to hid
        momentumW1=alpha*deltaW1;
        errHid=(err.out*W2').*logistic(I*W1).*(1-logistic(I*W1)).*2; %where errout*W2' is the difference between target and the actual
        deltaW1=n*(I'*errHid);
        W1=W1+deltaW1+momentumW1; 

        r = corrcoef(target,O);

    end

    %plot error
    range=find(results(:,1)==i);
    diff=mean(results(range,4));
    scatter(i,diff,'k','filled')
    drawnow 
    disp(prev-diff) % display difference from mean(MSE) for i-1
    prev=diff;
end
end 

