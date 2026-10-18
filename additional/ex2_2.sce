mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/delay.sci", -1);
exec("lab3/advance.sci", -1);
exec("lab3/fold.sci", -1);
exec("lab3/add.sci", -1);
exec("lab3/multi.sci", -1);

figure(1); clf();

// x(n) from Fig. P2.2 :  x(n) = {1, 1^, 1, 1, 1/2, 1/2}
xn = [1 1 1 1 0.5 0.5];
xorigin = 2;

// common plotting axis; a signal is placed on it by adding the zero signal on m
n = -7:7;
morigin = 1 - n(1);
function v = onaxis(yn, yorigin, m)
    v = add(yn, yorigin, zeros(1, length(m)), 1 - m(1));
endfunction

// (a)-(c) 
[an, ao] = delay(xn, xorigin, 2);                // (a) x(n-2)
[cn, co] = advance(xn, xorigin, 2);              // (c) x(n+2)
[fn, fo] = fold(xn, xorigin);                    // x(-n)
[bn, bo] = delay(fn, fo, 4);                     // (b) x(-(n-4)) = x(4-n)

// (d) x(n)u(2-n): multiply by the window u(2-n), built on the axis n
[wn, wo] = multi(xn, xorigin, bool2s(2 - n >= 0), morigin);

// (e) x(n-1)delta(n-3): delay by 1, then multiply by delta(n-3)
[x1n, x1o] = delay(xn, xorigin, 1);
[en, eo]   = multi(x1n, x1o, bool2s(n - 3 == 0), morigin);

// (f) x(n^2): no Lab 3 operation squares the index, so read x at n^2 directly
nx = (1:length(xn)) - xorigin;
yf = zeros(n);
for i = 1:length(n)
    k = find(nx == n(i)^2);
    if k <> [] then yf(i) = xn(k); end
end

// (g),(h) even and odd parts: fold, then add x(n) +/- x(-n) and halve
[sn, so] = add(xn, xorigin, fn, fo);             // x(n) + x(-n)
[qn, qo] = add(xn, xorigin, -fn, fo);            // x(n) - x(-n)

x  = onaxis(xn, xorigin, n);
ya = onaxis(an, ao, n);   yb = onaxis(bn, bo, n);   yc = onaxis(cn, co, n);
yd = onaxis(wn, wo, n);   ye = onaxis(en, eo, n);
xe = 0.5*onaxis(sn, so, n);
xo = 0.5*onaxis(qn, qo, n);

// independent check: substitute the transformed index into the definition
deff('y = xf(n)', 'y = bool2s(n >= -1 & n <= 2) + 0.5*bool2s(n >= 3 & n <= 4)');
ref = [xf(n-2); xf(4-n); xf(n+2); xf(n).*bool2s(n <= 2); xf(n-1).*bool2s(n == 3); ..
       xf(n.^2); 0.5*(xf(n) + xf(-n)); 0.5*(xf(n) - xf(-n))];
Y = [ya; yb; yc; yd; ye; yf; xe; xo];

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

// samples of x(n) and results (a)-(h)
nx = (1:length(xn)) - xorigin;
mprintf("  x(n) n = %s\n       y = %s\n", strcat(string(nx), " "), strcat(string(xn), " "));
names = ["(a)", "(b)", "(c)", "(d)", "(e)", "(f)", "(g)", "(h)"];
for i = 1:8
    if i == 8 then
        // (h) odd component: print full range spanned by decomposition, not skipping zeros
        k = min(find(Y(i,:) <> 0)) : max(find(Y(i,:) <> 0));
    else
        k = find(Y(i,:) <> 0);
    end
    mprintf("  %s n = %s\n      y = %s\n", names(i), strcat(string(n(k)), " "), strcat(string(Y(i,k)), " "));
end
mprintf("  max|Lab 3 functions - direct substitution| = %g\n", max(abs(Y - ref)));
mprintf("  max|xe + xo - x| = %g,  max|xe(n) - xe(-n)| = %g,  max|xo(n) + xo(-n)| = %g\n", ..
        max(abs(xe + xo - x)), max(abs(xe - xe($:-1:1))), max(abs(xo + xo($:-1:1))));
