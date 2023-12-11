function gowno = zad2(x0,t,yDane,R)
    rx = R(1);
    rxy = R(2);
    rxx = R(3);
    f = @(x,y,tn,xPrev) xPrev + ...
            (rx * tn + rxy * y * tn - 1) * x + (rxx * tn) * x^2;
    x(1) = x0;
    for i = 2:length(t)
        tn = t(i) - t(i-1);
        xPrev = x(i-1);
        fToSolve = @(x) f(x,yDane(i),tn,xPrev);
        x(i) = fzero(fToSolve,0);
    end
    gowno = x;
       