function phonology = freadP(rep)
%translates the distributed phono representation into a readable one
%   not working yet

phonology=[];


idx1=find(.5<=rep);
rep(idx1)=1;
idxN=find(rep<=-.5);
rep(idxN)=-1;
idx=[idx1 idxN];
N =1:56;
idx0= setdiff(N,idx);
rep(idx0)=0;



    %letter 1
    idx=find(cRep==rep(:,1:11));
    letter=char(idx(1)+96);
    phonology=[phonology,letter];

    %letter 2
    idx=find(rep(:,27:52)==1);
    if(~isempty(idx))
        letter=char(idx(1)+96);
        phonology=[phonology,letter];
    end 

    %letter 3
    idx=find(rep(:,53:78)==1);
    if(~isempty(idx))
        letter=char(idx(1)+96);
        phonology=[phonology,letter];
    end

    %letter 4
    idx=find(rep(:,79:104)==1);
    if(~isempty(idx))
        letter=char(idx(1)+96);
        phonology=[phonology,letter];
    end

    %letter 5
    idx=find(rep(:,105:130)==1);
    if(~isempty(idx))
        letter=char(idx(1)+96);
        phonology=[phonology,letter];
    end

    %letter 6
    idx=find(rep(:,131:156)==1);
    if(~isempty(idx))
        letter=char(idx(1)+96);
        phonology=[phonology,letter];
    end


end

