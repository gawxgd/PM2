function xVect = zad2implicitEulerY(x0,t,y,R)
    xn = zeros(length(t),1);
    xn(1) = x0;
    rx = R(1);
    rxy = R(2);
    rxx = R(3);
    for i=2:length(t)
        tn = t(i) - t(i - 1);
        [x1, x2] = findRoots([rxx * tn, rx * tn + rxy * y(i) * tn...
            - 1, xn(i-1)]);
        xn(i) = max(x1,x2);
    end
    xVect = xn;