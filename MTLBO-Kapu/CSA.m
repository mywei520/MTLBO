function [Alpha_score,Alpha_pos,Convergence_curve]=CSA(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
AP = 0.1;
L =2;
x=initialization(SearchAgents_no,dim,ub,lb);
for i = 1:SearchAgents_no
    CSA_fitness(i) = fobj(x(i,:));     
end
[~, New_xindex] = sort(CSA_fitness, 'ascend');
count = New_xindex(1);
mem = x;
fitness = CSA_fitness;
for t = 1:Max_iter
    num=ceil(SearchAgents_no*rand(1,SearchAgents_no));  
    for i=1:SearchAgents_no
        r2 = rand;
        if r2>=AP
            xnew(i,:) = x(i,:)+ L * rand * (mem(num(i),:) - x(i,:)); 
        else
            for j = 1:dim
                xnew(i,:)=lb + (ub - lb) .* rand;
            end
        end
        xnew(i,:) = min(ub, xnew(i,:));      
        xnew(i,:) = max(lb, xnew(i,:));      
        CSA_fitness(i) = fobj(xnew(i,:));    
    end
    for i = 1:SearchAgents_no
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

    Alpha_score= min(fitness);
    Convergence_curve(t)= Alpha_score;
end
Alpha_pos = mem(count,:);
end




















