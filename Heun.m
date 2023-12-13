function vect = HeunX(x0,t,ydok,R)
    xn = zeros(length(t),1);
    xn(1) = x0;
    rx = R(1);
    rxy = R(2);
    rxx = R(3);
    f = @(x,y) rx * x + rxy * x * y + rxx * x * x;
    
    for i=2:length(t)
        tn = t(i) - t(i - 1);
        param = xn(i-1) + f(xn(i-1),ydok(i-1)) * tn;
        xn(i) = xn(i-1) + 1 / 2 * tn * ...
            (f(xn(i-1),ydok(i-1)) + f(param,ydok(i)));
    end
    vect = xn;
    