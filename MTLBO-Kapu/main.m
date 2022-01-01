clear all 
clc
rng('default')
I = imread('Foxes.jpg');
SearchAgents_no=50;
Max_iteration=500; 
dim = 5;
lb = ones(1,dim); 
ub = 255.*ones(1,dim);
fobj =@(thresh)fun(I,thresh);
 [Best_score,Best_pos,GWO_cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
 [Best_score1,Best_pos1,TLBO_cg_curve]=TLBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
 [Best_score2,Best_pos2,MTLBO_cg_curve]=MTLBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
 [Best_score3,Best_pos3,SLTLBO_cg_curve]=SLTLBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
 [Best_score4,Best_pos4,CSA_cg_curve]=CSA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
Best_Thresh = Best_pos;
[Iout]=YuZhiplot(I,Best_Thresh);
figure(1)
imshow(Iout,[]);
Best_Thresh = Best_pos1;
[Iout]=YuZhiplot(I,Best_Thresh);
figure(2)
imshow(Iout,[]);
Best_Thresh = Best_pos2;
[Iout]=YuZhiplot(I,Best_Thresh);
figure(3)
imshow(Iout,[]);
Best_Thresh = Best_pos3;
[Iout]=YuZhiplot(I,Best_Thresh);
figure(4)
imshow(Iout,[]);
Best_Thresh = Best_pos4;
[Iout]=YuZhiplot(I,Best_Thresh);
figure(5)
imshow(Iout,[]);

figure(6)
plot(-(TLBO_cg_curve),'c','LineWidth',1.5)
hold on;
plot(-(MTLBO_cg_curve),'b','LineWidth',1.5)
hold on;
plot(-(SLTLBO_cg_curve),'m','LineWidth',1.5)
hold on;
plot(-(CSA_cg_curve),'Color','r','linewidth',1.5)
hold on;
plot(-(GWO_cg_curve),'k','LineWidth',1.5)
hold on;
xlabel('Iteration');
ylabel('Best score obtained so far');
axis([0,500,21.5,22])
grid off 
box on
legend('TLBO','MTLBO','SLTLBO','CSA','GWO')
display(['The optimal threshold obtained by TLBO algorithm is : ', num2str(floor(Best_pos1))]);
display(['The inter-class variance value of TLBO is : ', num2str(Best_score1)]);
display(['The optimal threshold obtained by MTLBO algorithm is : ', num2str(floor(Best_pos2))]);
display(['The inter-class variance value of MTLBO is : ', num2str(Best_score2)]);
display(['The optimal threshold obtained by SLTLBO algorithm is: ', num2str(floor(Best_pos3))]);
display(['The inter-class variance value of SLTLBO is : ', num2str(Best_score3)]);
display(['The optimal threshold obtained by CSA algorithm is : ', num2str(floor(Best_pos4))]);
display(['The inter-class variance value of CSA is : ', num2str(Best_score4)]);
display(['The optimal threshold obtained by GWO algorithm is : ', num2str(floor(Best_pos))]);
display(['The inter-class variance value of GWO is : ', num2str(Best_score)]);

