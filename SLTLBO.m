function [gbest,bestfitness,fbest,shuju,x,s,mt]=SLTLBO(fobj,lb,ub,dim,Population,Max_iteration,m)
shuju = ones(1,m);
t = ones(1,m);
for n=1:m
t1=clock;
fitness = NaN(Population,1);           
fbest = NaN(Max_iteration,1);           
 pop=initialization(Population,dim,ub,lb);
for i=1:Population
    fitness(i)=fobj(pop(i,:)); 
end 
    fbest(1)=min(fitness);    
for j=1:Max_iteration
    pop_m=mean(pop);
    [~,bestindex]=min(fitness);
    [~,worstindex]=max(fitness);
    pop_t=pop(bestindex,:);       
    pop_w=pop(worstindex,:);    
    for i=1:Population
        pop_new=pop(i,:)+rand(1,dim).*(pop_t-round(1+rand*(2-1)*pop_m));
        pop_new= min(ub, pop_new);      
        pop_new= max(lb, pop_new);              
        fitness_new=fobj(pop_new);
        if fitness_new<fitness(i)
            pop(i,:)=pop_new;
            fitness(i)=fitness_new;
        end
        k=randi([1 Population],1,1);
        while k==i
            k=randi([1 Population],1,1);
        end
        if fobj(pop(i,:))<fobj(pop(k,:))
            pop_new=pop(i,:)+rand(1,dim).*(pop(i,:)-pop(k,:));
        else if fobj(pop(i,:))>fobj(pop(k,:));
                pop_new=pop(i,:)+rand(1,dim).*(pop(k,:)-pop(i,:));
            end
        end
        pop_new= min(ub, pop_new);       
        pop_new= max(lb, pop_new);     
        fitness_new=fobj(pop_new);
        if fitness_new<fitness(i)
            pop(i,:)=pop_new;
            fitness(i)=fitness_new;
        end
        pop_new=pop(i,:)+rand(1,dim).*(pop_t-pop(i,:))-rand(1,dim).*(pop_w-pop(i,:));
        pop_new= min(ub, pop_new);   
        pop_new= max(lb, pop_new);  
        fitness_new=fobj(pop_new);
        if fitness_new<fitness(i)
            pop(i,:)=pop_new;
            fitness(i)=fitness_new;
        end
        pop_new=normrnd(pop(i,:),abs(pop_t-pop(i,:)));      
        pop_new= min(ub, pop_new);       
        pop_new= max(lb, pop_new);         
        fitness_new=fobj(pop_new);
        if fobj(pop_new)<fitness(i)
            pop(i,:)=pop_new;
            fitness(i)=fitness_new;
        end
    end
         fbest(j+1)=min(fitness);
end
[bestfitness,ind] = min(fitness);
gbest = pop(ind,:);
shuju(n) = bestfitness;
t2=clock;
t(n)=etime(t2,t1);
end
mt=mean(t,2);
x=mean(shuju,2);
s=std(shuju);
end

