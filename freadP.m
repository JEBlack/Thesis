function phonology = freadP(rep)
%translates the distributed phono representation into a readable one
%   not working yet

    global vRep
    global cRep
    phonology=[];
    
   
    PhonRep=[cRep(:,2:25),vRep(:,2:16)];
    names=PhonRep.Properties.VariableNames;
    PhonRep=table2array(PhonRep);
    PhonRep=[zeros(12,1),PhonRep];
    

    ncol=size(PhonRep);
    ncol=ncol(2);
    

    idxpos=find(rep<0.1);
    idxneg=find(rep>-0.1);
    idx=intersect(idxpos,idxneg);
    rep(idx)=0;
    
    
    %pick out letters 
    
    for i=1:5
        range=rep(:,(((i-1)*12)+1):(i*12));
        maxcos=0;
        maxj=0;
        %disp('---------------------')
%         if(range==zeros(1,12))
%             continue
%         end
        for j=1:ncol 
            B=PhonRep(:,j);
            sub1=sum(range.^2);
            sub2=sum(B.^2);
            cossim=sum(range*B)/(sub1*sub2);
            
            %disp(r)
            %disp(j)
            if( cossim>maxcos) 
                maxcos=cossim;
                maxj=j;
                %disp('changed max')
                %disp(names(maxj))
            end
        end
          if(maxj==0)
              continue
          end
        disp(maxcos)
        phonology=[phonology,names(maxj),"."];
    end 
    
    phonology=strjoin(phonology);
    
    


end

