// [yn, yorigin] = delay(xn, xorigin, k)
// y(n) = x(n-k), k>0  (shift to the right)

function [yn, yorigin] = delay(xn, xorigin, k)
    nx = (1:length(xn)) - xorigin;  
    ny = nx + k;                     
    yn = xn;
    yorigin = 1 - ny(1);             

    subplot(2,1,1); stemplot(nx, xn, "x(n)");
    subplot(2,1,2); stemplot(ny, yn, "y(n) = x(n-" + string(k) + ")");
endfunction
