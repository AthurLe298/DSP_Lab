// [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
// y(n) = x(n) * h(n)  (linear convolution)

function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    nx = (1:length(xn)) - xorigin;
    nh = (1:length(hn)) - horigin;
    ny = (nx(1) + nh(1)) : (nx($) + nh($));
    yn = convol(xn, hn);
    yorigin = 1 - ny(1);

    subplot(3,1,1); stemplot(nx, xn, "x(n)");
    subplot(3,1,2); stemplot(nh, hn, "h(n)");
    subplot(3,1,3); stemplot(ny, yn, "y(n) = x(n) * h(n)");
endfunction
