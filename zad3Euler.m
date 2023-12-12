clear
% Wczytanie danych
dane = readtable("dane16.csv");
tDane = double(dane.t);
xDane = double(dane.x);
yDane = double(dane.y);
% Początkowe Parametry
rx = linspace(0,40,20);
ry = linspace(-1,0,10);
rxx = linspace(-0.1,0,20);
x0 = linspace(100,1000,50);

ry2 = linspace(-40,0,20);
ryx = linspace(0,1,10);
ryy = linspace(-0.1,0,20);
y0 = linspace(10,200,50);

combs = combinations(x0,rx,ry,rxx);
combs = table2array(combs);

combs2 = combinations(y0,ry2,ryx,ryy);
combs2 = table2array(combs2);
% Funkckcja do minimalizacji
Jx = @(xEuler) sum((xEuler - xDane).^2);
Jx2 = @(xEuler) sum((xEuler - yDane).^2);
sols = zeros(length(rx),1);
sols2 = zeros(length(ry2),1);
for i=1:length(combs)
    sols(i) = Jx(zad1Euler(combs(i,1),tDane,yDane,combs(i,2:end)));
    sols2(i) = Jx2(zad1Euler(combs2(i,1),tDane,xDane,combs2(i,2:end)));
end
minimum = min(sols);
Rminimum = combs(sols == minimum,:);
tempFunc = @(x) Jx(zad1Euler(x(1),tDane,yDane,x(2:end)));
opt_PopX = fminsearch(tempFunc,Rminimum);

minimum2 = min(sols2);
Rminimum2 = combs2(sols2 == minimum2,:);
tempFunc2 = @(x) Jx2(zad1Euler(x(1),tDane,xDane,x(2:end)));
opt_PopY = fminsearch(tempFunc2,Rminimum2);

JxAll = @(Est) sum(sum((Est - [xDane,yDane]).^2));
AllParams = [opt_PopX,opt_PopY];

minimizeFunc = @(x) JxAll(EulerSolver(x,tDane));
options = optimset('fminsearch');
options.MaxIter = 4000;
options.MaxFunEvals = 5000;
optAll = fminsearch(minimizeFunc,AllParams,options)
Est = EulerSolver(optAll,tDane);
figure(1)
plot(tDane,Est(:,1))
hold on
plot(tDane,xDane)
title("Wykres populacji x")
legend("populacja przybliżona","populacja dokładna")

figure(2)
plot(tDane,Est(:,2))
hold on
plot(tDane,yDane)
title("Wykres populacji y")
legend("populacja przybliżona","populacja dokładna")

function Est = EulerSolver(allParams,tDane)
        h = 0.001;
        t = min(tDane):h:max(tDane);
        xO = allParams(1:4); 
        yO = allParams(5:end);
        fx = @(x, y) xO(2) * x + xO(3) * x * y + xO(4) * x * x;
        fy = @(x, y) yO(2) * y + yO(3) * y * x + yO(4) * y * y;
        xEst = zeros(length(tDane),1);
        xEst(1) = xO(1);
        yEst = zeros(length(tDane),1); 
        yEst(1) = yO(1);
        for i = 2:length(t)
            tn = t(i) - t(i-1);
            xEst(i) = xEst(i-1) + fx(xEst(i-1), yEst(i-1)) * tn;
            yEst(i) = yEst(i-1) + fy(xEst(i-1), yEst(i-1)) * tn;
        end % for
        xEst = interp1(t, xEst, tDane);
        yEst = interp1(t, yEst, tDane);
        Est = [xEst,yEst];
    end
  
