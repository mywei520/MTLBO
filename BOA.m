function [gbest,fitnessgbest,yy,shuju,x,s,mt]=BOA(fobj,lb,ub,dim,Population,Max_iteration,m)
shuju = ones(1,m);
t = ones(1,m);
for n =1:m   
t1=clock;
p=0.8;                  
power_exponent=0.1;
sensory_modality=0.01;
 x=initialization(Population,dim,ub,lb);
for i = 1 : Population
    BOAFitness(i) = fobj(x(i,:));
end
[~, index] = sort(BOAFitness, 'ascend');
count = index(1);
for iter = 1 : Max_iteration
    for i = 1 : Population
        Fnew = fobj(x(i,:));
        FP = (sensory_modality * ((abs(Fnew)) ^ power_exponent));
        if rand < p
            dis = rand * rand * x(count,:) - x(i,:);
            xnew(i,:) = x(i,:) + dis * FP;
        else
            epsilon = rand;
            JK = randperm(Population);
            dis = epsilon * epsilon * x(JK(1),:) - x(JK(2),:);
            xnew(i,:) = x(i,:) + dis * FP;
        end
         xnew(i,:)= min(ub, xnew(i,:));
         xnew(i,:)= max(lb,  xnew(i,:));    
        NewBOAFitness(i) = fobj(xnew(i,:));
        if NewBOAFitness(i) < BOAFitness(i)
            x(i,:) = xnew(i,:);
            BOAFitness(i) = NewBOAFitness(i);
        end
        [~, index1] = sort(BOAFitness, 'ascend');
        count = index1(1);
    end
    sensory_modality = sensory_modality_NEW(sensory_modality, iter);
    fitnessgbest= min(BOAFitness);
    yy(iter)=fitnessgbest;
end
gbest = x(count,:);
t2=clock;
t(n)=etime(t2,t1);
shuju(n)=fitnessgbest;
end
mt=mean(t,2);
x=mean(shuju,2);
s=std(shuju);