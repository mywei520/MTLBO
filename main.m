clc
clear
m=30;
Population=30; 
Max_iteration=1000; 
%benchmarksType = 1 for Unimodal Variable-Dim
%benchmarksType = 2 for multimodalVariableDim
%benchmarksType = 3 for Fixed-Dim
benchmarksType = 1;
if benchmarksType == 1
    maxFunc = 11;
elseif benchmarksType == 2
    maxFunc = 10;
elseif benchmarksType == 3
    maxFunc = 4;
else
    exit;
end
Function_name=strcat('F',num2str(1));
    if benchmarksType == 1
        [lb,ub,dim,fobj]=unimodalVariableDim(Function_name);
    elseif benchmarksType == 2
        [lb,ub,dim,fobj]=multimodalVariableDim(Function_name);
    elseif benchmarksType == 3
        [lb,ub,dim,fobj]=FixedDim(Function_name);
    end  
%%***********************************************************************%%
[bestpos,bestfitness1,fgbest,shuju1,M1,s1,mt1]=TLBO(fobj,lb,ub,dim,Population,Max_iteration,m);
[gbest2,bestfitness2,fbest,shuju2,M2,s2,mt2] = MTLBO(fobj,lb,ub,dim,Population,Max_iteration,m);
[gbest3,fitnessgbest3,yy3,shuju3,M3,s3,mt3]=BOA(fobj,lb,ub,dim,Population,Max_iteration,m);
[gbest4,fitnessgbest4,yy4,shuju4,M4,s4,mt4]=CSA(fobj,lb,ub,dim,Population,Max_iteration,m);
[gbest5,bestfitness5,fbest5,shuju5,M5,s5,mt5]=SLTLBO(fobj,lb,ub,dim,Population,Max_iteration,m);
[gbest6,bestfitness6,fbest6,shuju6,M6,s6,mt6]=GWO(fobj,lb,ub,dim,Population,Max_iteration,m);
[gbest7,bestfitness7,fbest7,shuju7,M7,s7,mt7]=WOA(fobj,lb,ub,dim,Population,Max_iteration,m);
for iter = 1 : 30
    x1(iter,1) = shuju1(iter);
    x2(iter,1) = shuju2(iter);
    x3(iter,1) = shuju3(iter);
    x4(iter,1) = shuju4(iter);
    x5(iter,1) = shuju5(iter);
    x6(iter,1) = shuju6(iter);
    x7(iter,1) = shuju7(iter);
end

figure;
plot(log10(fgbest),'r','LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
plot(log10(fbest),'--b','LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
plot(log10(yy3),':y','LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
plot(log10(yy4),'-.g','LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
plot(log10(fbest5),'LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
plot(log10(fbest6),'LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
plot(log10(fbest7),'LineWidth',1.5)
hold on;
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
axis tight
grid off
box on
legend('TLBO','MTLBO','BOA','CSA','SLTLBO','GWO','WOA')
figure;
boxplot([x1,x2,x3,x4,x5,x6,x7],'Notch','on','Labels',{'TLBO','MTLBO','BOA','CSA','SLTLBO','GWO','WOA'})
xlabel('Algorithms')
ylabel('Fitness value')
 display(['The global optimal value of TLBO is : ', num2str(min(shuju1))]);
 display(['The global optimal value of MTLBO is : ', num2str(min(shuju2))]);
 display(['The global optimal value of BOA is : ', num2str(min(shuju3))]);
 display(['The global optimal value of CSA is : ', num2str(min(shuju4))]);
 display(['The global optimal value of STLBOis : ', num2str(min(shuju5))]);
 display(['The global optimal value of GWO is: ', num2str(min(shuju6))]);
 display(['The global optimal value of WOA is : ', num2str(min(shuju7))]);
 
 display(['The global worst value of TLBO is: ', num2str(max(shuju1))]);
 display(['The global worst value of MTLBO is : ', num2str(max(shuju2))]);
 display(['The global worst value of BOA is : ', num2str(max(shuju3))]);
 display(['The global worst value of CSA is: ', num2str(max(shuju4))]);
 display(['The global worst value of STLBO is : ', num2str(max(shuju5))]);
 display(['The global worst value of GWO is: ', num2str(max(shuju6))]);
 display(['The global worst value of WOA is : ', num2str(max(shuju7))]);
 
 display(['The running time of TLBO is : ', num2str(mt1)]);
 display(['The running time of MTLBO is : ', num2str(mt2)]);
 display(['The running time of BOA is : ', num2str(mt3)]);
 display(['The running time of CSA is : ', num2str(mt4)]);
 display(['The running time of STLBO is : ', num2str(mt5)]);
 display(['The running time of GWO is : ', num2str(mt6)]);
 display(['The running time of WOA is : ', num2str(mt7)]);



