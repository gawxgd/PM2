dane = readtable("dane16.csv");
tDane = double(dane.t);
syms x y t
% wartości uzyskana w zadaniu 3
AllParams = [475.8032,12.0826,-0.1077,-0.0029,98.4847,...
    -8.6214,0.0530,-0.0024];
xParams = AllParams(1:4);
yParams = AllParams(5:end);

x1 = xParams(1);
y1 = yParams(1);
rx = xParams(2);
rxy = xParams(3);
rxx = xParams(4);
ry = yParams(2);
ryx = yParams(3);
ryy = yParams(4);
eq1 = 0 == rx * x + rxy * x * y + rxx * x * x;
eq2 = 0 == ry * y + ryx * x * y + ryy * y * y;
sol = solve([eq1,eq2],[x,y]);
sol.x
sol.y
