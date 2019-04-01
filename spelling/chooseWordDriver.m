
function [percent,chooseResults] = chooseWordDriver()

%Choose word test. Given a spelling, the model chooses a phonological representation from a
%subset of words, which differ only by a single sound. Results are
%stored in 'chooseResults' table. Number correct on each loop is plotted. Percent
%correct is printed. 


global words
global wordsSize
global subsetSize

subsetSize=8;

func=@Vsubset;
%func=@initialSubset;
%func=@finalSubset;

% 
% scatter(0,0)
% drawnow
% hold on

count=0;

chooseResults  = cell2table(cell(0,7), 'VariableNames', {'i', 'percentCorrect', 'count','value', 'given', 'expected', 'orth'});
wordsSize=size(words);
wordsSize=wordsSize(1);


for i=1:200
    idx=randi([1 wordsSize],1,1);
    orth=words(idx,1);
    phon=words(idx,2);
    [value,word]=chooseWord(orth,phon,func);
    if value==true
        count=count+1;
    end 
    out={i, ((count/i)*100), count, value, word, table2cell(phon), table2cell(orth)};
    chooseResults=[chooseResults; out];
    
    
%     scatter(i,count,'k','filled')
%     drawnow
    
end 

percent=(count/i)*100; %percent correct
    
end 




    