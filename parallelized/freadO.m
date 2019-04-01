function spelling = freadO(rep)
%Translates the orthographic representation of a word to its spelling
%   

    spelling=[];
    
%     idx=find(rep<=.98);
%     rep(idx)=0;


    %letter 1
    range=rep(:,1:26);
    idx=find(range==max(range));
    letter=char(idx(1)+96);
    spelling=[spelling,letter];

    %letter 2
    range=rep(:,27:52);
    idx=find(range==max(range));
    if(range(idx(1))~=0)
        letter=char(idx(1)+96);
        spelling=[spelling,letter];
    end 

    %letter 3
    range=rep(:,53:78);
    idx=find(range==max(range));
    if(range(idx(1))~=0)
        letter=char(idx(1)+96);
        spelling=[spelling,letter];
    end

    %letter 4
    range=rep(:,79:104);
    idx=find(range==max(range));
    if(range(idx(1))~=0)
        letter=char(idx(1)+96);
        spelling=[spelling,letter];
    end

    %letter 5
    range=rep(:,105:130);
    idx=find(range==max(range));
    if(range(idx(1))~=0)
        letter=char(idx(1)+96);
        spelling=[spelling,letter];
    end

    %letter 6
    range=rep(:,131:156);
    idx=find(range==max(range));
    if(range(idx(1))~=0)
        letter=char(idx(1)+96);
        spelling=[spelling,letter];
    end


end

