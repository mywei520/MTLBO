function [lb,ub,dim,fobj] = FixedDim(F)
switch F      
    case 'F21'
        fobj = @F21;
        lb=-5;
        ub=5;
        dim=2;
    case 'F22'
        fobj = @F22;
        lb=-100;
        ub=100;
        dim=2;
    case 'F23'
        fobj = @F23;
        lb=-10;
        ub=10;
        dim=2;  
    case 'F24'
        fobj = @F24;
        lb=0;
        ub=10;
        dim=2;
end

end

function o = F21(x)
o=x(1)^2+x(2)^2+25*((sin(x(1)))^2+(sin(x(2)))^2);
end

function o = F22(x)
o=x(1)^2+2*x(2)^2-0.3*cos(3*pi*x(1))*cos(4*pi*x(2))+0.3;
end

function o = F23(x)
o=0.26*(x(1)^2+x(2)^2) - 0.48*x(1)*x(2);
end

function o = F24(x)
o=100*(x(2)-x(1)^3)^2+(1-x(1)^2);
end



