// [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
//  y(n) = x1(n) + x2(n)
function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    n1 = (1:length(x1n)) - x1origin;
    n2 = (1:length(x2n)) - x2origin;

    n_min = min(n1(1), n2(1));
    n_max = max(n1($), n2($));
    ny = n_min:n_max;

    y1 = zeros(1, length(ny));
    y2 = zeros(1, length(ny));
    y1(n1 - n_min + 1) = x1n;   
    y2(n2 - n_min + 1) = x2n;

    yn = y1 + y2;
    yorigin = 1 - n_min;         

    subplot(3,1,1); stemplot(n1, x1n, "x1(n)");
    subplot(3,1,2); stemplot(n2, x2n, "x2(n)");
    subplot(3,1,3); stemplot(ny, yn,  "y(n) = x1(n) + x2(n)");
endfunction
