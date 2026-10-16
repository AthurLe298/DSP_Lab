mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);

// x(n) = 1 + n/3 for -3 <= n <= -1,  1 for 0 <= n <= 3,  0 elsewhere
deff('y = xf(n)', 'y = (1 + n/3).*bool2s(n >= -3 & n <= -1) + bool2s(n >= 0 & n <= 3)');

// (a) values of x(n) on its support
n = -3:3;
x = xf(n);                       // [0 1/3 2/3 1 1 1 1]

// (b)1  fold, then delay by 4
n_f  = -n($:-1:1);   x_f  = x($:-1:1);     // x(-n)   : fold
n_b1 = n_f + 4;      y_b1 = x_f;           // x(-(n-4)) = x(-n+4) : delay by 4

// (b)2  delay by 4, then fold
n_d  = n + 4;        x_d  = x;             // x(n-4)  : delay by 4
n_b2 = -n_d($:-1:1); y_b2 = x_d($:-1:1);   // x(-n-4) : fold

// place every result on one common axis so the shifts are comparable
m = -8:8;
function yp = onaxis(m, nk, yk)
    yp = zeros(1, length(m));
    yp(m >= nk(1) & m <= nk($)) = yk;
endfunction

xp   = onaxis(m, n,    x);
xfp  = onaxis(m, n_f,  x_f);
b1p  = onaxis(m, n_b1, y_b1);
xdp  = onaxis(m, n_d,  x_d);
b2p  = onaxis(m, n_b2, y_b2);

// (c) x(-n+4) evaluated directly from the definition of x(n)
c = xf(-m + 4);

// (e) x(n) = 1/3 delta(n+2) + 2/3 delta(n+1) + u(n) - u(n-4)
xe = (1/3)*bool2s(m == -2) + (2/3)*bool2s(m == -1) + bool2s(m >= 0) - bool2s(m >= 4);

figure(1); clf();
subplot(3,2,1); stemplot(m, xp,  "(a) x(n)");
subplot(3,2,2); stemplot(m, c,   "(c) x(-n+4), from the definition");
subplot(3,2,3); stemplot(m, xfp, "(b)1 step 1: fold -> x(-n)");
subplot(3,2,4); stemplot(m, b1p, "(b)1 step 2: delay 4 -> x(-n+4)");
subplot(3,2,5); stemplot(m, xdp, "(b)2 step 1: delay 4 -> x(n-4)");
subplot(3,2,6); stemplot(m, b2p, "(b)2 step 2: fold -> x(-n-4)");
savefig("add_ex2_1");

disp("  (a) x(n), n = -3..3:");  disp(x);
mprintf("  (b)1 support n = %d..%d,  (b)2 support n = %d..%d\n", n_b1(1), n_b1($), n_b2(1), n_b2($));
mprintf("  (d) max|(b)1 - (c)| = %g   max|(b)2 - (c)| = %g\n", max(abs(b1p - c)), max(abs(b2p - c)));
mprintf("  (e) max|x(n) - delta/u expression| = %g\n", max(abs(xf(m) - xe)));
