function [lb,ub,dim,fobj] = multimodalVariableDim(F)
dim = 30;
switch F
        
    %Rastrigin
    case 'F12'
        fobj = @F12;
        lb=-5.12;
        ub=5.12;
        
    %Alpine N. 1
    case 'F13'
        fobj = @F13;
        lb=-10;
        ub=10;
    %Xin-She Yang
    case 'F14'
        fobj = @F14;
        lb=-5;
        ub=5;
            %Griewank
    case 'F15'
        fobj = @F15;
        lb=-100;
        ub=100;
                
    %Quartic Noise
    case 'F16'
        fobj = @F16;
        lb=-1.28;
        ub=1.28;
        
    %Periodic
    case 'F17'
        fobj = @F17;
        lb=-10;
        ub=10;
    %Ackley
    case 'F18'
        fobj = @F18;
        lb=-32;
        ub=32;
        
    case 'F19'
        fobj = @F19;
        lb =-100;
        ub =100;
    case 'F20'
        fobj = @F20;
        lb=-100;
        ub=100;
end

end



% F12 - Rastrigin
function o = F12(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

% F13 - Alpine N. 1
function o = F13(x)
     o = sum(abs(x .* sin(x) + 0.1 * x), 2);
end

% F14 - Xin-She Yang
function o = F14(x)
    n = size(x, 2);
    o = 0;
    for i = 1:n
        o = o + rand * (abs(x(:, i)) .^ i);
    end
end

% F15 - Griewank
function o = F15(x)
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

% F16 - Quartic Noise
function o = F16(x)
dim=size(x,2);
o=sum([1:dim].*(x.^4))+rand;
end

% F17 - Periodic
function o = F17(x)
    sin2x = sin(x) .^ 2;
    sumx2 = sum(x .^2, 2);
    o = 1 + sum(sin2x, 2) -0.1 * exp(-sumx2);
end

% F18 - Ackley
function o = F18(x)
    n = size(x, 2);
    ninverse = 1 / n;
    sum1 = sum(x .^ 2, 2);
	sum2 = sum(cos(2 * pi * x), 2);
    
    o = 20 + exp(1) - (20 * exp(-0.2 * sqrt( ninverse * sum1))) - exp( ninverse * sum2);
end

function o = F19(x)
dim=size(x,2);
o=sum(((10^6).^(((1:dim)-1)/(dim-1))).*x(1:dim).^2);
end

function o = F20(x)
dim=size(x,2);
sum_1=0;
sum_2=0;
sum_3=0;
for i=1:dim
    sum_1=sum_1+x(i).^2;
    sum_2=sum_2+(0.5*i*x(i)).^2;
    sum_3=sum_3+(0.5*i*x(i)).^4;
end
o=sum_1+sum_2+sum_3;
end
