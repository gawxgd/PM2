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

minimizeFunc = @(x) JxAll(odeSolver(x,tDane));
options = optimset('fminsearch');
options.MaxIter = 4000;
options.MaxFunEvals = 5000;
[optAll,fVal] = fminsearch(minimizeFunc,AllParams,options)
Est = odeSolver(optAll,tDane);

figure(1)
ax = gca;
ax.FontSize = 16;
plot(tDane,Est(:,1))
hold on
plot(tDane,xDane')
title("Wykres populacji x ode45")
legend("populacja przybliżona","populacja dokładna")
xlabel("t - czas")
ylabel("liczność populacji")

figure(2)
ax = gca;
ax.FontSize = 16;

plot(tDane,Est(:,2))
hold on
plot(tDane,yDane)
title("Wykres populacji y ode45")
legend("populacja przybliżona","populacja dokładna")
xlabel("t - czas")
ylabel("liczność populacji")

function Est = odeSolver(AllParams,tDane)
    optX = AllParams(1:4);
    optY = AllParams(5:end);
    startVal = [optX(1), optY(1)];
    URRZ = @(t,y) [optX(2) * y(1) + optX(3) * y(1) * y(2) + ...
        optX(4) * y(1) * y(1); optY(2) * y(2) + optY(3)...
        * y(1) * y(2) + optY(4) * y(2) * y(2)];
    [t,y] = ode45(URRZ,[0 3],startVal); 
    xEst = interp1(t, y(:,1),tDane);
    yEst = interp1(t, y(:,2),tDane);
    Est = [xEst,yEst];
    
end


