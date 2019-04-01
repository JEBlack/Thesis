function block = createBlock(set1,set2)

phono=[];
ortho=[];

for i = 1:72
    el=randi(12);
    if(round(rand))
        phono=[phono,set1{el,2}];    
        ortho=[ortho,set1{el,1}];
    else
        phono=[phono,set2{el,2}];    
        ortho=[ortho,set2{el,1}];
    end
end 

block=table(ortho.',phono.');
block=table(block);
    
end

