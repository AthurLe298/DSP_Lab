mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);

// x(n) from Fig. P2.2 :  x(n) = {1, 1^, 1, 1, 1/2, 1/2},  n = -1..4
deff('y = xf(n)', 'y = bool2s(n >= -1 & n <= 2) + 0.5*bool2s(n >= 3 & n <= 4)');
deff('y = uf(n)', 'y = bool2s(n >= 0)');     // unit step
deff('y = df(n)', 'y = bool2s(n == 0)');     // unit impulse

n = -7:7;
x  = xf(n);

ya = xf(n - 2);                  // (a) x(n-2)
yb = xf(4 - n);                  // (b) x(4-n)
yc = xf(n + 2);                  // (c) x(n+2)
yd = xf(n) .* uf(2 - n);         // (d) x(n)u(2-n)
ye = xf(n - 1) .* df(n - 3);     // (e) x(n-1)delta(n-3)
yf = xf(n.^2);                   // (f) x(n^2)
xe = 0.5*(xf(n) + xf(-n));       // (g) even part
xo = 0.5*(xf(n) - xf(-n));       // (h) odd part

// Figure 1: index shifts and reversal, stacked on one n-axis
figure(1); clf();
f = gcf(); f.axes_size = [610 760];     // taller window for the 4 stacked plots
subplot(4,1,1); stemplot(n, x,  "x(n)  (Fig. P2.2)");
subplot(4,1,2); stemplot(n, ya, "(a) x(n-2) : delay by 2");
subplot(4,1,3); stemplot(n, yc, "(c) x(n+2) : advance by 2");
subplot(4,1,4); stemplot(n, yb, "(b) x(4-n) : fold, then delay by 4");
savefig("add_ex2_2_shift");

// Figure 2: products with u(n), delta(n) and the squared index
figure(2); clf();
f = gcf(); f.axes_size = [610 600];
subplot(3,1,1); stemplot(n, yd, "(d) x(n)u(2-n) : u(2-n) keeps n <= 2");
subplot(3,1,2); stemplot(n, ye, "(e) x(n-1)delta(n-3) = x(2)delta(n-3)");
subplot(3,1,3); stemplot(n, yf, "(f) x(n^2) : only n^2 = 0, 1, 4 hit the support");
savefig("add_ex2_2_prod");

// Figure 3: even / odd decomposition and its reconstruction
figure(3); clf();
subplot(2,2,1); stemplot(n, x,       "x(n)");
subplot(2,2,2); stemplot(n, xe + xo, "check: xe(n) + xo(n)");
subplot(2,2,3); stemplot(n, xe,      "(g) xe(n) = [x(n) + x(-n)]/2");
subplot(2,2,4); stemplot(n, xo,      "(h) xo(n) = [x(n) - x(-n)]/2");
savefig("add_ex2_2_evenodd");

// non-zero samples of every result
names = ["(a)", "(b)", "(c)", "(d)", "(e)", "(f)", "(g)", "(h)"];
Y = [ya; yb; yc; yd; ye; yf; xe; xo];
for i = 1:8
    k = find(Y(i,:) <> 0);
    mprintf("  %s n = %s\n      y = %s\n", names(i), strcat(string(n(k)), " "), strcat(string(Y(i,k)), " "));
end
mprintf("  max|xe + xo - x| = %g,  max|xe(n) - xe(-n)| = %g,  max|xo(n) + xo(-n)| = %g\n", ..
        max(abs(xe + xo - x)), max(abs(xe - xe($:-1:1))), max(abs(xo + xo($:-1:1))));
