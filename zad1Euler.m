function xVect = zad1Euler(x0,t,y,R)
    xn = zeros(length(t),1);
    xn(1) = x0;
    rx = R(1);
    rxy = R(2);
    rxx = R(3);
    f = @(x,y) rx * x + rxy * x * y + rxx * x * x;
    for i=2:length(t)
        tn = t(i) - t(i - 1);
        xn(i) = xn(i-1) + f(xn(i-1),y(i-1)) * tn;
    end
    xVect = xn;
