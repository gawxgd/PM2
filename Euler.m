function xVect = Euler(x0,t,y,R)
    xn = zeros(length(t));
    xn(1) = x0;
    [rx,rxy,rxx] = deal([R(1),R(2),R(3)]);
    f = @(x,y) rx * x + rxy * x * y + rxx * x * x;
    for i=2:length(t)
        tn = t(i) - t(i - 1);
        xn(i) = xn(i-1) + f(xn(i-1),y(i-1)) * tn;
    end
    
