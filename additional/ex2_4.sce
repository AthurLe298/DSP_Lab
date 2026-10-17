mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/fold.sci", -1);
exec("lab3/add.sci", -1);

figure(1); clf();

n = -2:2;
x = [2 3 4 5 6];
xorigin = 3;


[xr, xrorigin] = fold(x, xorigin);

[s, sorigin] = add(x, xorigin,  xr, xrorigin);   // x(n) + x(-n)
[d, dorigin] = add(x, xorigin, -xr, xrorigin);   // x(n) - x(-n)
xe = 0.5 * s;
xo = 0.5 * d;

figure(1); clf();
subplot(3, 2, 1); stemplot(n, x, "Original signal x(n)");
subplot(3, 2, 2); stemplot(n, xr, "Time-reversed signal x(-n)");
subplot(3, 2, 3); stemplot(n, xe, "Even component xe(n)");
subplot(3, 2, 4); stemplot(n, xo, "Odd component xo(n)");
subplot(3, 2, 5); stemplot(n, x - (xe + xo), "Difference plot x(n) - [xe(n) + xo(n)]");
savefig("add_ex2_4");

mprintf("  max|x(n) - [xe(n) + xo(n)]| = %g\n", max(abs(x - (xe + xo))));
