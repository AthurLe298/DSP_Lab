// [yn, yorigin] = advance(xn, xorigin, k)
// y(n) = x(n+k), k>0  
function [yn, yorigin] = advance(xn, xorigin, k)
    yn = xn;
    yorigin = xorigin + k;

    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;

    subplot(2,1,1); stemplot(nx, xn, "x(n)");
    subplot(2,1,2); stemplot(ny, yn, "y(n) = x(n+" + string(k) + ")");
endfunction
