function [lb,ub,dim,fobj] = unimodalVariableDim(F)
dim = 30;
switch F
    %Sphere
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        
    %Powell Sum
    case 'F2'
        fobj = @F2;
        lb=-1;
        ub=1;
        
    %Schwefel's 2.20
    case 'F3'
        fobj = @F3;
        lb=-100;
        ub=100;
        
    %Schwefel's 2.21
    case 'F4'
        fobj = @F4;
        lb=-100;
        ub=100;
        
    %Step
    case 'F5'
        fobj = @F5;
        lb=-100;
        ub=100;
        
    %Schwefel's 2.22
    case 'F6'
        fobj = @F6;
        lb=-100;
        ub=100;
        
    %Schwefel's 2.23
    case 'F7'
        fobj = @F7;
        lb=-10;
        ub=10;
        
    %Brown
    case 'F8'
        fobj = @F8;
        lb=-1;
        ub=4;
        
    %Dixon and Price
    case 'F9'
        fobj = @F9;
        lb=-10;
        ub=10;
        
    %Powell Singular
    case 'F10'
        fobj = @F10;
        lb=-4;
        ub=5;
        
    %Sum Squares
    case 'F11'
        fobj = @F11;
        lb=-10;
        ub=10;
end
end
% F1 - Sphere
function o = F1(x)
o=sum(x.^2);
end
% F2 - Powell Sum
function o = F2(x)
n = size(x, 2);
absx = abs(x);
    
o = 0;
for i = 1:n
	o = o + (absx(:, i) .^ (i + 1));
end
end
% F3 - Schwefel 2.20
function o = F3(x)
	o = sum(abs(x), 2);
end
% F4 - Schwefel 2.21
function o = F4(x)
    o = max(abs(x), [], 2);
end
% F5 - Step
function o = F5(x)
    o=sum(abs((x+.5)).^2);
end
% F6 - Schwefel's 2.22
function o = F6(x)
o=sum(abs(x))+prod(abs(x));
end
% F7 - Schwefel's 2.23
function o = F7(x)
o=sum(x .^10, 2);
end
% F8 - Brown
function o = F8(x)
dim=size(x,2);
o = 0;
for i = 1:dim-1
    xi1 = x(i+1)^2+1;
    xi = x(i)^2+1;
    o = o + (x(i)^2)^xi1 + (x(i+1)^2)^xi;
end
end
% F9 - Dixon & Price
function o = F9(x)
x1 = x(1);
d = length(x);
term1 = (x1-1)^2;
sum = 0;
for ii = 2:d
	xi = x(ii);
	xold = x(ii-1);
	new = ii * (2*xi^2 - xold)^2;
	sum = sum + new;
end
o = term1 + sum;
end
% F10 - Powell Singular
function o = F10(x)
d = length(x);
sum = 0;
for ii = 1:(d/4)
	term1 = (x(4*ii-3) + 10*x(4*ii-2))^2;
	term2 = 5 * (x(4*ii-1) - x(4*ii))^2;
	term3 = (x(4*ii-2) - 2*x(4*ii-1))^4;
	term4 = 10 * (x(4*ii-3) - x(4*ii))^4;
	sum = sum + term1 + term2 + term3 + term4;
end
o = sum;
end
% F11 - Sum Squares
function o = F11(x)
n = length(x);
s = 0;
for j = 1:n  
    s=s+j*x(j)^2; 
end
o = s;
end
