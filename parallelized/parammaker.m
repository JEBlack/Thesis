x=[];

for i=0:20
    for j=1:5
        y=zeros(1,300);
        y(1:15*i)=1;
        x=[x;y];
    end
end

spellFirst=x;

[m,n]=size(x);
b=x;

c=zeros(105,300);

for i= 1:m
    b(i,:)=b(i,randperm(300));
end

shuffled=b;

for i= 1:m
    c(i,:)=sort(x(i,:));
end 

readFirst=c;
