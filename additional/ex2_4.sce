// Source: additional/ex2_4.sce
mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);

n = -2:2;
x = [2 3 4 5 6];

// Time-reversed signal x(-n)
xr = x($:-1:1);

// Even and odd components
xe = 0.5 * (x + xr);
xo = 0.5 * (x - xr);

figure(1); clf();
subplot(2, 2, 1); stemplot(n, x, "Original signal x(n)");
subplot(2, 2, 2); stemplot(n, xr, "Time-reversed signal x(-n)");
subplot(2, 2, 3); stemplot(n, xe, "Even component xe(n)");
subplot(2, 2, 4); stemplot(n, xo, "Odd component xo(n)");
savefig("add_ex2_4");
