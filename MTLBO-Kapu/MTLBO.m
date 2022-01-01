function [bestfitness,bestpos,fgbest]=MTLBO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
f = NaN(SearchAgents_no,1);  
fgbest = NaN(Max_iter+1,1);
X0=initializationNew(SearchAgents_no,dim,ub,lb);
pop = X0;
for i=1:SearchAgents_no
        f(i)=fobj(pop(i,:));
end 
    fgbest(1)=min(f);
for j=1:Max_iter
        pop_m = mean(pop);            
        [~,ind] = min(f);           
        pop_t = pop(ind,:);           
        w=0.4+(0.9-0.4)*log10(1+10*j/Max_iter);
        r1=2-(2*j)/Max_iter;
    for i=1:SearchAgents_no
        pop_new=w*pop(i,:)+rand(1, dim).*(pop_t-round(1+rand*(2-1)*pop_m));
        if rand<0.5
            pop_new=pop(i,:)+r1*sin(rand*2*pi)*abs(rand*2*pop_t-pop(i,:));
        else if rand>0.5
            pop_new=pop(i,:)+r1*cos(rand*2*pi)*abs(rand*2*pop_t-pop(i,:));
            end
        end
        pop_new= min(ub, pop_new);      
        pop_new= max(lb, pop_new);       
        fnew=fobj(pop_new);
        if fnew<f(i)
            pop(i,:)=pop_new;
            f(i) = fnew;            
        end
        k=randi([1 SearchAgents_no],1,1);
        while k==i
            k=randi([1 SearchAgents_no],1,1);
        end
        if f(i)<f(k)
            pop_new=w*pop(i,:)+rand(1, dim).*(pop(i,:)-pop(k,:));
        else if f(i)>f(k)
            pop_new=w*pop(i,:)+rand(1, dim).*(pop(k,:)-pop(i,:));
            end
        end
        
        if rand<0.5
            pop_new=pop(i,:)+r1*sin(rand*2*pi)*abs(rand*2*pop_t-pop(i,:));
        else if rand>0.5
            pop_new=pop(i,:)+r1*cos(rand*2*pi)*abs(rand*2*pop_t-pop(i,:));
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
        fgbest(j+1)=min(f);
end
[bestfitness,ind] = min(f);
bestpos = pop(ind,:);
end
