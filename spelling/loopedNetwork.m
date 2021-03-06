%delta rule network

clear;



        

 % Bound parameters 
        
    global phonRep
    global vRep
    global cRep
    global W1
    global W2
    global biasW
    global words
    global wordsSize

    phonRep=readtable('phonRep.xlsx');
    vRep=readtable('vRep.xlsx');
    cRep=readtable('cRep.xlsx');

    
        %clean up
        
        tSize=1000;
    
        words=readtable('trainingOrthoPhono.xlsx');
        words=cleanUp(words); % remove any words that don't fit the criteria

        wordsSize=size(words); % size of word set
        wordsSize=wordsSize(1);

        
        
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
                paramset= [paramset; lrates(lrate), alphas(mome), numHids(hu), initials(initial)];
                end
            end 
        end         
    end
end        

disp('paramset constructed')


results=zeros(1200,9);

mkdir testdata
        


for count = 1:1200
                    
        params=paramset(count,:);

        disp(count)
        disp(params)

        n = params(1); % learning rate
        alpha = params(2); % momentum term
        numOut=60; % number of output nodes, phon
        numIn=156; % number of input nodes, ortho 
        numHid= params(3); % number of hidden nodes


        a = params(4); %range of values for initial weights
        a= -a;
        b = params(4);

        %rng(1) %random number seed

        %construct training set
        idxs=randi([1,wordsSize],[1,tSize]); % words to be added to training set
        T=words(idxs,:); % create training set with random words

        disp('training set constructed')



        % initialize all weight matrices
        W1 = (b-a).*rand(numIn,numHid) + a; 
        W2 = (b-a).*rand(numHid,numOut) + a; 
        biasW = (b-a).*rand(1,numOut) + a; 

        %initialize deltas for momentum
        delta.w2=0; 
        delta.bias=0;
        delta.w1=0;

        %initialize change for mean sq errors
        prev=0; 

        disp('network set up, training started')



% ------------------------------------------------------------------



        for i=1:200
            for j=1:tSize

                % Forward Pass
                idx=randi([1 tSize],1,1); %pick a random word from training set
                I=fOrth(T(idx,1)); %input is the orthography
                target=fPhon(T(idx,2)); %target is the phonology


                hid=newlogistic(I*W1); %calculate hidden units
                O=newlogistic(hid*W2+biasW);


                %Backward Pass

                % hid to out
                momentum.w2=alpha*delta.w2;
                err.out=(target-O).*logistic(hid*W2).*(1-logistic(hid*W2)).*2; 
                delta.w2=n*(hid'*err.out);
                W2=W2+delta.w2+momentum.w2; 

                % bias to out
                momentum.bias=alpha*delta.bias;
                err.bias=(target-O).*logistic(biasW).*(1-logistic(biasW)).*2; 
                delta.bias=n*(1.*err.bias);
                biasW=biasW+delta.bias+momentum.bias; 


                d=target-O; 
                biasW=biasW+n*(d.'*1).';

                % in to hid
                momentum.w1=alpha*delta.w1;
                err.hid=(err.out*W2').*logistic(I*W1).*(1-logistic(I*W1)).*2; %where errout*W2' is the difference between target and the actual
                delta.w1=n*(I'*err.hid);
                W1=W1+delta.w1+momentum.w1;
            end 

        end

        %[percent, chooseResults]=chooseWordDriver();
        [setCorrect, numCorrect]= phonemesCorrectDriver(W1,W2,biasW);

        mse = meanmse(W1, W2, biasW);

        results(count,:)=[params(1), params(1), params(3), params(4), setCorrect(1), setCorrect(3), setCorrect(4), numCorrect, mse];

        %disp(results)
end

           






