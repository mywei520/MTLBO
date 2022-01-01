function [gbest,fitnessgbest,yy,shuju,x,s,mt]=CSA(fobj,lb,ub,dim,Population,Max_iteration,m)
shuju = ones(1,m);
t3=ones(1,m);
for n =1:m
t1=clock;
AP = 0.1;
L =2;
x=initialization(Population,dim,ub,lb);
for i = 1:Population
    CSA_fitness(i) = fobj(x(i,:));     
end
[~, New_xindex] = sort(CSA_fitness, 'ascend');
count = New_xindex(1);
mem = x;
fitness = CSA_fitness;
for t = 1:Max_iteration
    num=ceil(Population*rand(1,Population));
    for i=1:Population
        r2 = rand;
        if r2>=AP
            xnew(i,:) = x(i,:)+ L * rand * (mem(num(i),:) - x(i,:));
        else
            xnew=initialization(Population,dim,ub,lb);
        end
        if xnew(i,:) > ub & xnew(i,:) < lb
            xnew(i,:) = mem(i,:);
        end
        CSA_fitness(i) = fobj(xnew(i,:));
    end
    for i = 1:Population
        if xnew(i,:) >= lb & xnew(i,:) <= ub
            x(i,:) = xnew(i,:);
            if CSA_fitness(i) < fitness(i)
                mem(i,:) = xnew(i,:);          
                fitness(i) = CSA_fitness(i);    
            end
        end 
    end
    [~, index] = sort(fitness, 'ascend');
    count = index(1);
    fitnessgbest= min(fitness);
    yy(t)= fitnessgbest;
end
gbest = mem(count,:);
t2=clock;
t3(n)=etime(t2,t1);
shuju(n)= fitnessgbest;
end
mt=mean(t3,2);
x=mean(shuju,2);
s=std(shuju);



















