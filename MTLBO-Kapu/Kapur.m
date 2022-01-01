function [g] = Kapur(I,thresh)
thresh = floor(thresh);
thresh = sort(thresh);
[r,c]=size(I);
 n=max(size(thresh));
 p=imhist(I)./(r*c);
 w=size(1,n+1);
 HH=size(1,n+1);
 if(n==1)
     w(1)=sum(p(1:thresh));
     H=-(p(1:thresh)./w(1)).*log(p(1:thresh)./w(1));
     H(isnan(H))=0;
     HH(1)=sum(H);
     w(2)=sum(p(thresh+1:end));
     H=-(p(thresh+1:end)./w(2)).*log(p(thresh+1:end)./w(2));
     H(isnan(H))=0;
     HH(2)=sum(H);     
 else
     for i=1:n+1
         if(i==1)
             w(i)=sum(p(1:thresh(i)));
             H=-(p(1:thresh)./w(i)).*log(p(1:thresh)./w(i));
             H(isnan(H))=0;
             HH(i)=sum(H);
         elseif(i==n+1)
              w(i)=sum(p(thresh(i-1):end));
               H=-(p(thresh(i-1):end)./w(i)).*log(p(thresh(i-1):end)./w(i));
               H(isnan(H))=0;
               HH(i)=sum(H);
         else
             w(i)=sum(p(thresh(i-1):thresh(i)));
              H=-(p(thresh(i-1):thresh(i))./w(i)).*log(p(thresh(i-1):thresh(i))./w(i));
              H(isnan(H))=0;
              HH(i)=sum(H);
         end
     end
 end
g=sum(HH);
end

