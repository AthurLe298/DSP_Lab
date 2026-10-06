// [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
// y(n) = x(n) * h(n)  
function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    yn = convol(xn, hn);
    yorigin = xorigin + horigin - 1;

    nx = (1:length(xn)) - xorigin;
    nh = (1:length(hn)) - horigin;
    ny = (1:length(yn)) - yorigin;

    subplot(3,1,1); stemplot(nx, xn, "x(n)");
    subplot(3,1,2); stemplot(nh, hn, "h(n)");
    subplot(3,1,3); stemplot(ny, yn, "y(n) = x(n) * h(n)");
endfunction
