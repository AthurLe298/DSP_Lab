// [yn, yorigin] = fold(xn, xorigin)
// y(n) = x(-n)  (folding / time reversal)
function [yn, yorigin] = fold(xn, xorigin)
    yn = xn($:-1:1);
    yorigin = length(xn) - xorigin + 1;

    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;

    subplot(2,1,1); stemplot(nx, xn, "x(n)");
    subplot(2,1,2); stemplot(ny, yn, "y(n) = x(-n)");
endfunction
