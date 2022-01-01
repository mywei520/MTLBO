function [bestpos,bestfitness,yy,shuju,x,s,mt]=TLBO(fobj,lb,ub,dim,Population,Max_iteration,m)
shuju = ones(1,m);
t = ones(1,m);
for n=1:m
t1=clock;
f = NaN(Population,1);                     
yy = NaN(Max_iteration,1);          
pop=initialization(Population,dim,ub,lb);
for i=1:Population
    f(i)=fobj(pop(i,:));
end 
fgbest=min(f);
for j=1:Max_iteration
     pop_m = mean(pop);
    [~,ind] = min(f);
    pop_t = pop(ind,:);
    for i=1:Population
        pop_new=pop(i,:)+rand(1, dim).*(pop_t-round(1+rand*(2-1)*pop_m));
        pop_new= min(ub, pop_new);       
        pop_new= max(lb, pop_new);       
        fnew=fobj(pop_new);
        if fnew<f(i)
            pop(i,:)=pop_new;
            f(i) = fnew;            
        end
    end
    for i=1:Population
        k=randi([1 Population],1,1);
        while k==i
            k=randi([1 Population],1,1);
        end
        if f(i)<f(k)
            pop_new=pop(i,:)+rand(1, dim).*(pop(i,:)-pop(k,:));
        else if f(i)>f(k)
            pop_new=pop(i,:)+rand(1, dim).*(pop(k,:)-pop(i,:));
            end
        end
        pop_new= min(ub, pop_new);       
        pop_new= max(lb, pop_new);             
        fnew=fobj(pop_new);
        if fnew<f(i)
            pop(i,:)=pop_new;
            f(i) = fnew; 
        end
    end   
    for i=1:Population
        f(i)=fobj(pop(i,:));
        if f(i)<fgbest
            fgbest=f(i);
        end
    end
    yy(j)=fgbest; 
end
[bestfitness,ind] = min(f);
bestpos = pop(ind,:);
shuju(n) = bestfitness;
t2=clock;
t(n)=etime(t2,t1);
end
mt=mean(t,2);
x=mean(shuju,2);
s=std(shuju);
end

