mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/delay.sci", -1);
exec("lab3/fold.sci", -1);
exec("lab3/add.sci", -1);

// x(n) = 1 + n/3 for -3 <= n <= -1,  1 for 0 <= n <= 3,  0 elsewhere
deff('y = xf(n)', 'y = (1 + n/3).*bool2s(n >= -3 & n <= -1) + bool2s(n >= 0 & n <= 3)');
figure(1); clf();

// (a) x(n) 
xn = xf(-3:3);                   // [0 1/3 2/3 1 1 1 1]
xorigin = 4;                    

// (b)1  fold, then delay by 4
[fn,  forigin]  = fold(xn, xorigin);           // x(-n)
[b1n, b1origin] = delay(fn, forigin, 4);       // x(-(n-4)) = x(-n+4)

// (b)2  delay by 4, then fold
[dn,  dorigin]  = delay(xn, xorigin, 4);       // x(n-4)
[b2n, b2origin] = fold(dn, dorigin);           // x(-n-4)

// put every result on one common axis m by adding the zero signal on m
m = -8:8;
function v = onaxis(yn, yorigin, m)
    v = add(yn, yorigin, zeros(1, length(m)), 1 - m(1));
endfunction

xp  = onaxis(xn,  xorigin,  m);
fp  = onaxis(fn,  forigin,  m);
b1p = onaxis(b1n, b1origin, m);
dp  = onaxis(dn,  dorigin,  m);
b2p = onaxis(b2n, b2origin, m);

// (c) x(-n+4) evaluated directly from the definition of x(n)
c = xf(-m + 4);

// (e) x(n) = 1/3 delta(n+2) + 2/3 delta(n+1) + u(n) - u(n-4)
xe = (1/3)*bool2s(m == -2) + (2/3)*bool2s(m == -1) + bool2s(m >= 0) - bool2s(m >= 4);

figure(1); clf();
subplot(3,2,1); stemplot(m, xp,  "(a) x(n)");
subplot(3,2,2); stemplot(m, c,   "(c) x(-n+4), from the definition");
subplot(3,2,3); stemplot(m, fp,  "(b)1 fold -> x(-n)");
subplot(3,2,4); stemplot(m, b1p, "(b)1 then delay 4 -> x(-n+4)");
subplot(3,2,5); stemplot(m, dp,  "(b)2 delay 4 -> x(n-4)");
subplot(3,2,6); stemplot(m, b2p, "(b)2 then fold -> x(-n-4)");
savefig("add_ex2_1");

disp("  (a) x(n), n = -3..3:");  disp(xn);
mprintf("  (b)1 yorigin = %d (n = %d..%d),  (b)2 yorigin = %d (n = %d..%d)\n", ..
        b1origin, 1 - b1origin, length(b1n) - b1origin, b2origin, 1 - b2origin, length(b2n) - b2origin);
mprintf("  (d) max|(b)1 - (c)| = %g   max|(b)2 - (c)| = %g\n", max(abs(b1p - c)), max(abs(b2p - c)));
mprintf("  (e) max|x(n) - delta/u expression| = %g\n", max(abs(xf(m) - xe)));
