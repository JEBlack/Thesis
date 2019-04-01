function [blockedC, blockedNC, interleaved] = constructTraining(words,wordsSize)

setsize=12;

ea=targetWords(words, wordsSize, 'ea', 'IY');
    idx=randperm(height(ea),setsize);
    eas=ea(idx,:);
oa=targetWords(words, wordsSize, 'oa', 'OW');
    idx=randperm(height(oa),setsize);
    oas=oa(idx,:);
oi=targetWords(words, wordsSize, 'oi', 'OY');
    idx=randperm(height(oi),setsize);
    ois=oi(idx,:);
ai=targetWords(words, wordsSize, 'ai', 'EY');
    idx=randperm(height(ai),setsize);
    ais=ai(idx,:);
oo=targetWords(words, wordsSize, 'oo', 'UW');
    idx=randperm(height(oo),setsize);
    oos=oo(idx,:);
ou=targetWords(words, wordsSize, 'ou', 'AW');
    idx=randperm(height(ou),setsize);
    ous=ou(idx,:);

blocksC=[{ois,oos},{eas,ais},{oas,ous},{ois,ais},{eas,oas},{ous,oos}];
blocksNC=[{ois,eas},{ais,oos},{ous,oas},{ois,oas},{ais,ous},{eas,oos}];    
    

%blockedC
els=[1,3,5,7,9,11];
order=els(randperm(length(els)));
blockedC=[];
for i = 1:6
    set1=blocksC(order(i));
    set2=blocksC(order(i)+1);
    block=table2array(createBlock(set1{1},set2{1}));
    blockedC=[blockedC;block];
end

%blockedNC
order=els(randperm(length(els)));
blockedNC=[];
for i = 1:6
    set1=blocksNC(order(i));
    set2=blocksNC(order(i)+1);
    block=table2array(createBlock(set1{1},set2{1}));
    blockedNC=[blockedNC;block];
end


interleaved=[];

    


end

