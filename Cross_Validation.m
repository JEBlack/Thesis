%Cross-Validation for free parameters in network

%delta rule network

clear;


% Free Parameters

        n=.005; % learning rate
        alpha= 0.9; % momentum term
        numOut=60; % number of output nodes, phon
        numIn=156; % number of input nodes, ortho 
        numHid=50; % number of hidden nodes
        tSize=1000; % number of words in training set

        lrates=[0.05, 0.01, 0.008, 0.005, 0.001];
        alphas=[0, 0.1, 0.3, 0.5, 0.7];
        numHids=[50, 60, 70, 80, 100];
        
        colors=['b','k','r','g','c','m'];

        a = -.2; %range of values for initializing weights
        b = 0.2;

        rng(1) %random number seed
        

 % Bound parameters 
        
    global vRep
    global cRep
    global W1
    global W2
    global biasW

    vRep=readtable('vRep.xlsx');
    cRep=readtable('cRep.xlsx');

    words=readtable('trainingOrthoPhono.xlsx');
    words=cleanUp(words); % remove any words that don't fit the criteria

    wordSize=size(words); % size of word set

    idxs=randi([1,wordSize(1)],[1,tSize]); % words to be added to training set
    T=words(idxs,:); % create training set with random words
   
    
%training the weights

scatter(.01,.01)
drawnow
hold on

results = zeros(100*1000,4);


    
    W1 = (b-a).*rand(numIn,numHid) + a; % initialize all weight matrices
    W2 = (b-a).*rand(numHid,numOut) + a; 
    biasW = (b-a).*rand(1,numOut) + a; 

    delta.w2=0; %initialize deltas for momentum
    delta.bias=0;
    delta.w1=0;

    prev=0; %initialize change for mean sq errors
     
     
    for i=1:100
        for j=1:1000
            
            idx=randi([1 tSize],1,1); %pick a random word from training set
            I=fOrth(T(idx,1)); %input is the orthography
            target=fPhon(T(idx,2)); %target is the phonology


            hid=newlogistic(I*W1); %calculate hidden units
            O=newlogistic(hid*W2+biasW);

            %W2 delta, hid to out
            momentum.w2=alpha*delta.w2;
            err.out=(target-O).*logistic(hid*W2).*(1-logistic(hid*W2)).*2; 
            delta.w2=n*(hid'*err.out);
            W2=W2+delta.w2+momentum.w2; %W+n*I*errout

            %bias weights delta, bias to out
            momentum.bias=alpha*delta.bias;
            err.bias=(target-O).*logistic(biasW).*(1-logistic(biasW)).*2; 
            delta.bias=n*(1.*err.bias);
            biasW=biasW+delta.bias+momentum.bias; 

            %W1 delta, in to hid
            momentum.w1=alpha*delta.w1;
            err.hid=(err.out*W2').*logistic(I*W1).*(1-logistic(I*W1)).*2; %where errout*W2' is the difference between target and the actual
            delta.w1=n*(I'*err.hid);
            W1=W1+delta.w1+momentum.w1; 

            r = corrcoef(target,O);
            results = [results; i, idx, r(2,1), mean( (target-O).^2)];


        end
        %plot error
        range=find(results(:,1)==i);
        diff=mean(results(range,4));
        %scatter(i,diff,colors(c),'filled')
        scatter(i,diff,'k','filled')
        drawnow 
        disp(prev-diff) % display difference from mean(MSE) for i-1
        prev=diff;
    end 
 
 
