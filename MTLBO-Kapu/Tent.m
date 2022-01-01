function [x] = Tent(Max_iter)
 x(1)=rand;
 a = 0.5;
 for i=1:Max_iter-1
     if x(i)<a
         x(i+1)=x(i)*2;
     end
     if x(i)>=a
         x(i+1)=(1-x(i))*2;
     end
 end
 end