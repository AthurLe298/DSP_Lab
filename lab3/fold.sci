// [yn, yorigin] = fold(xn, xorigin)
// y(n) = x(-n)  (folding / time reversal)

function [yn, yorigin] = fold(xn, xorigin)
    nx = (1:length(xn)) - xorigin;  
    ny = -nx($:-1:1);                
    yn = xn($:-1:1);                 
    yorigin = 1 - ny(1);

    subplot(2,1,1); stemplot(nx, xn, "x(n)");
    subplot(2,1,2); stemplot(ny, yn, "y(n) = x(-n)");
endfunction
