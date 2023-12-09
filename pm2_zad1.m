clear
dane = readtable("dane16.csv");
tDane = double(dane.t);
xDane = double(dane.x);
yDane = double(dane.y);
N = length(tDane);
rx = linspace(0,40,5);
ry = linspace(-1,0,5);
rxx = linspace(-0.1,0,5);
x0 = linspace(100,1000,5);
combs = combinations(x0,rx,ry,rxx);
combs = table2array(combs);
sols = zeros(length(rx),1);
sols(1) = Solve(combs(1,1),combs(1,2),combs(1,3),combs(1,4),...
    N,xDane,yDane,tDane);
% mini = sols(1);
% minIndex = 1;
for i=2:length(rx)
    sols(i) = Solve(combs(i,1),combs(i,2),combs(i,3),combs(i,4),...
        N,xDane,yDane,tDane);
    % if(sols(i)<mini)
    %     mini = sols(i);
    %     minIndex = i;
    % end
end
sols
sols = sols(~isnan(sols));
mini = min(sols);
miniIndex = find(sols==mini);
startvalues = [combs(miniIndex,1),combs(miniIndex,2),combs(miniIndex,3),...
    combs(miniIndex,4)];
solve = @(x) Solve(x(1),x(2),x(3),x(4),N,xDane,yDane,tDane);
result = fminsearch(solve,startvalues)
solve(startvalues)
function solution = Solve(x0,rx,rxy,rxx,N,xDane,yDane,tDane)
    xEstimate = zeros(N,1);
    xEstimate(1) = x0;
    fx = @(x,y) rx .* x + rxy .* x .* y + rxx .* x .* x;
    for i=2:N
        deltaTn = tDane(i) - tDane(i-1);
        xEstimate(i) = xEstimate(i-1) + fx(xEstimate(i-1),yDane(i-1))...
            .* deltaTn;
    end
    sum  = 0;
    for i=1:N
        przy = xEstimate(i);
        dok = xDane(i);
        sum = sum + (xEstimate(i)-xDane(i)).^2;
    end
    %Jx = @(xn) cumsum((xEstimate - xDane) .^ 2);
    %sol = Jx(xEstimate(end));
    solution = sum;
end

