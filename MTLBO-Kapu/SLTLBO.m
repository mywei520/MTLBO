function [Alpha_score,Alpha_pos,Convergence_curve]=SLTLBO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
t1=clock;
Positions=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);
fitness=zeros(1,SearchAgents_no);
for i=1:SearchAgents_no
    fitness(i)=fobj(Positions(i,:));
end
Alpha_score=min(fitness);
for j=1:Max_iter
    popmean=sum(Positions)/SearchAgents_no;
    [bestfitness,bestindex]=min(fitness);
    [worstfitness,worstindex]=max(fitness);
    popteacher=fobj(Positions(bestindex,:));
    worststudent=fobj(Positions(worstindex,:));
    for i=1:SearchAgents_no
        popnew=Positions(i,:)+rand*(popteacher-round(1+rand*(2-1)*popmean));
        popnew = min(ub, popnew);      
        popnew = max(lb, popnew);       
        if fobj(popnew)<fitness(i)
            Positions(i,:)=popnew;
        end
    end
    for i=1:SearchAgents_no
        k=randi([1,10],1,1);
        while k==i
            k=randi([1,10],1,1);
        end
        if fobj(Positions(i,:))<fobj(Positions(k,:))
            popnew=Positions(i,:)+rand*(Positions(i,:)-Positions(k,:));
        else if fobj(Positions(i,:))>fobj(Positions(k,:))
                popnew=Positions(i,:)+rand*(Positions(k,:)-Positions(i,:));
            end
        end
        popnew = min(ub, popnew);       
        popnew = max(lb, popnew);      
        
        if fobj(popnew)<fitness(i)
            Positions(i,:)=popnew;
        end
    end
    for i=1:SearchAgents_no
        popnew=Positions(i,:)+rand*(popteacher-Positions(i,:))-rand*(worststudent-Positions(i,:));
        popnew = min(ub, popnew);      
        popnew = max(lb, popnew);       
        if fobj(popnew)<fitness(i)
            Positions(i,:)=popnew;
        end
    end
    for i=1:SearchAgents_no
        popnew=normrnd(Positions(i,:),abs(popteacher-Positions(i,:)));
        popnew = min(ub, popnew);       
        popnew = max(lb, popnew);      
        if fobj(popnew)<fitness(i)
            Positions(i,:)=popnew;
        end
    end
    for i=1:SearchAgents_no
        fitness(i)=fobj(Positions(i,:));
        if fitness(i)<Alpha_score
            Alpha_pos=Positions(i,:);
            Alpha_score=fitness(i);
        end
        Alpha_pos=Positions(find(min(Alpha_score)),:);
    end
    Convergence_curve(j)=Alpha_score;
end  
t2=clock;
t=etime(t2,t1);
end

