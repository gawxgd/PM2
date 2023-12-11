function [x1, x2] = findRoots(f)
        % funkcja rozwiązująca równanie kwadratowe
        a = f(1); b = f(2); c = f(3);
        delta = b^2 - 4*a*c;
        if delta < 0
            x1 = NaN;
            x2 = NaN;
            return;
        end
        x1 = (-b - sign(b)*sqrt(delta)) / (2*a);
        x2 = c / (a * x1);
    