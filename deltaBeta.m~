clear;

global vRep
global cRep
global W

vRep=readtable('vRep.xlsx');
cRep=readtable('cRep.xlsx');



words=readtable('trainingOrthoPhono.xlsx');

words=cleanUp(words); %remove any words that don't fit the criteria

s=size(words);
idxs=randi([1,s(1)],[1,1000]);

T=words(idxs,:);


results = [];

numOut=56; %number of output nodes
numIn=156; %number of input nodes 
n=.05; %learning rate




%training the weights


a = 0;
b = 0.2;
W = (b-a).*rand(numIn,numOut) + a; %weights randomly generated between 0 and 0.2



for i=1:10
    for idx=1:1000
        element=T(idx,1); %input is the orthography
        act=fOrth(element);

        O=act*W; %calculate outputs
        target=fPhon(words(idx,2));

        d=target-O; 
        W=W+n*(d.'*act).';
        
    end
end 



