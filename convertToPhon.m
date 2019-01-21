
% Main file for converting symbolic phonologies to phonological feature
% arrays

clear;

global phonRep
phonRep=readtable('phonRep.xlsx');
global words
words=readtable('newWords.xlsx');

words=cleanUp(words); %remove any words that don't fit the criteria

% Some different options for representations...

% Represented in a large array
% The words are concatinated onto each other, adding to the right
% New word every 11 columns.
% Was this what we talked about last week?

repArrayRight=[];
for i=1:200
    repArrayRight=[repArrayRight,fPhon(words(i,2))];
end

% represented in a container, key is char array of ortho, value is array of
% phonological features
% access orthography array with repMap.keys
% cannot iterate through values without using the key.

repMap=containers.Map('keytype','char','ValueType','any'); 
for i=1:200 
    repMap(char(words{i,1}))=fPhon(words(i,2));
end

% represented in a 3d array. Each page is the feature representations for a
% single word
    % iterate through words with repArray(:,:,index)
    % Might be useful if we want to access certain features easily-- ex. access
    % all sonorant representations with repArray(1,:,:).
repArray=fPhon(words(1,2));
for i=2:200
    repArray(:,:,i)=fPhon(words(i,2));
end

    