function [Alpha_score,Alpha_pos,Convergence_curve]=TLBO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
t1=clock;
Positions=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);
fit=zeros(1,SearchAgents_no);
for i=1:SearchAgents_no
    fit(i)=fobj(Positions(i,:));
end
Alpha_score=min(fit);

for j=1:Max_iter
    popmean=sum(Positions)/SearchAgents_no;
    [bestfitness,bestindex]=min(fit);
    popteacher=fobj(Positions(bestindex,:));
    for i=1:SearchAgents_no
        popnew=Positions(i,:)+rand*(popteacher-round(1+rand*(2-1)*popmean));
        popnew = min(ub, popnew);      
        popnew = max(lb, popnew);       
        if fobj(popnew)<fit(i)
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
        if fobj(popnew)<fit(i)
            Positions(i,:)=popnew;
        end
    end
    %%*******************************************************************%%
    for i=1:SearchAgents_no
        fit(i)=fobj(Positions(i,:));
        if fit(i)<Alpha_score
            Alpha_pos=Positions(i,:);
            Alpha_score=fit(i);
        end
        Alpha_pos=Positions(find(min(Alpha_score)),:);
    end  
    Convergence_curve(j)=Alpha_score;
end
t2=clock;
t=etime(t2,t1);

