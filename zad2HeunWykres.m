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
    sols(i) = Jx(Heun(combs(i,1),tDane,yDane,combs(i,2:end)));
    sols2(i) = Jx2(Heun(combs2(i,1),tDane,xDane,combs2(i,2:end)));
end
minimum = min(sols);
Rminimum = combs(sols == minimum,:);
tempFunc = @(x) Jx(Heun(x(1),tDane,yDane,x(2:end)));
opt_PopX = fminsearch(tempFunc,Rminimum)

minimum2 = min(sols2);
Rminimum2 = combs2(sols2 == minimum2,:);
tempFunc2 = @(x) Jx2(Heun(x(1),tDane,xDane,x(2:end)));
opt_PopY = fminsearch(tempFunc2,Rminimum2)

figure(1)
plot(tDane,Heun(opt_PopX(1),tDane,yDane,opt_PopX(1,2:end)))
hold on
plot(tDane,xDane)
title("Wykres populacji x jawny Heun")
legend("populacja przybliżona","populacja dokładna")

figure(2)
plot(tDane,Heun(opt_PopY(1),tDane,xDane,opt_PopY(1,2:end)))
hold on
plot(tDane,yDane)
title("Wykres populacji y jawny Heun")
legend("populacja przybliżona","populacja dokładna")