function yVect = zad1EulerY(y0,t,x,R)
    yn = zeros(length(t),1);
    yn(1) = y0;
    ry = R(1);
    ryx = R(2);
    ryy = R(3);
    f = @(x,y) ry * y + ryx * x * y + ryy * y * y;
    for i=2:length(t)
        tn = t(i) - t(i - 1);
        yn(i) = yn(i-1) + f(x(i-1),yn(i-1)) * tn;
    end
    yVect = yn;
