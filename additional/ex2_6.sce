mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/delay.sci", -1);
exec("lab3/add.sci", -1);
exec("lab3/convolution.sci", -1);

// Common plotting axis n = -7:7; onaxis aligns a signal onto axis n using add
n = -7:7;
function v = onaxis(yn, yorigin, m)
    v = add(yn, yorigin, zeros(1, length(m)), 1 - m(1));
endfunction

// Input signal x(n) = 1 for 0 <= n <= 3
xn = [1 1 1 1];
xorigin = 1;

// =========================================================================
// Part (b): System y(n) = x(n^2)
// =========================================================================
yn = [1 1 1];
yorigin = 2; // non-zero for n in {-1, 0, 1}

// (3) y'_2(n) = y(n - 2) using delay
[y2pn, y2porigin] = delay(yn, yorigin, 2);

// (4) x_2(n) = x(n - 2) using delay
[x2n, x2origin] = delay(xn, xorigin, 2);

// (5) y_2(n) = T[x_2(n)] = x_2(n^2): non-zero for n in {-2, 2}
y2n = [1 0 0 0 1];
y2origin = 3;

// (6) Difference y_2(n) - y'_2(n) using add
[diff_b, diff_b_origin] = add(y2n, y2origin, -y2pn, y2porigin);

// Project signals onto common display axis n = -7:7
xp   = onaxis(xn, xorigin, n);
yp   = onaxis(yn, yorigin, n);
y2pp = onaxis(y2pn, y2porigin, n);
x2p  = onaxis(x2n, x2origin, n);
y2p  = onaxis(y2n, y2origin, n);
diff_bp = onaxis(diff_b, diff_b_origin, n);

figure(1); clf();
subplot(3, 2, 1); stemplot(n, xp, "(1) Input signal x(n)");
subplot(3, 2, 2); stemplot(n, yp, "(2) Output signal y(n) = x(n^2)");
subplot(3, 2, 3); stemplot(n, y2pp, "(3) y''_2(n) = y(n-2) : output shifted by 2");
subplot(3, 2, 4); stemplot(n, x2p, "(4) x_2(n) = x(n-2) : input shifted by 2");
subplot(3, 2, 5); stemplot(n, y2p, "(5) Output signal y_2(n) = x(n^2-2)");
subplot(3, 2, 6); stemplot(n, diff_bp, "(6) Difference y_2(n) - y''_2(n) <> 0");
savefig("add_ex2_6_b");

mprintf("Exercise 2.6 (b): System y(n) = x(n^2)\n");
mprintf("  y_2(n) non-zero at n = %s\n", strcat(string(n(find(y2p <> 0))), " "));
mprintf("  y(n-2) non-zero at n = %s\n", strcat(string(n(find(y2pp <> 0))), " "));
mprintf("  max|y_2(n) - y(n-2)| = %g -> Time-variant\n\n", max(abs(diff_bp)));

// =========================================================================
// Part (c): System y(n) = x(n) - x(n - 1)
// =========================================================================
// Impulse response of the difference system: h(n) = delta(n) - delta(n-1)
hn = [1 -1];
horigin = 1;

// (2) Output y(n) = x(n) * h(n) using convolution
[yn, yorigin] = convolution(xn, xorigin, hn, horigin);

// (3) y'_2(n) = y(n - 2) using delay
[y2pn, y2porigin] = delay(yn, yorigin, 2);

// (4) x_2(n) = x(n - 2) using delay
[x2n, x2origin] = delay(xn, xorigin, 2);

// (5) y_2(n) = T[x_2(n)] = x_2(n) * h(n) using convolution
[y2n, y2origin] = convolution(x2n, x2origin, hn, horigin);

// (6) Difference y_2(n) - y'_2(n) using add
[diff_c, diff_c_origin] = add(y2n, y2origin, -y2pn, y2porigin);

// Project signals onto common display axis n = -7:7
xp   = onaxis(xn, xorigin, n);
yp   = onaxis(yn, yorigin, n);
y2pp = onaxis(y2pn, y2porigin, n);
x2p  = onaxis(x2n, x2origin, n);
y2p  = onaxis(y2n, y2origin, n);
diff_cp = onaxis(diff_c, diff_c_origin, n);

figure(2); clf();
subplot(3, 2, 1); stemplot(n, xp, "(1) Input signal x(n)");
subplot(3, 2, 2); stemplot(n, yp, "(2) Output signal y(n) = x(n) - x(n-1)");
subplot(3, 2, 3); stemplot(n, y2pp, "(3) y''_2(n) = y(n-2) : output shifted by 2");
subplot(3, 2, 4); stemplot(n, x2p, "(4) x_2(n) = x(n-2) : input shifted by 2");
subplot(3, 2, 5); stemplot(n, y2p, "(5) y_2(n) = T[x_2(n)] : response to shifted input");
subplot(3, 2, 6); stemplot(n, diff_cp, "(6) Difference y_2(n) - y''_2(n) = 0");
savefig("add_ex2_6_c");

mprintf("Exercise 2.6 (c): System y(n) = x(n) - x(n-1)\n");
mprintf("  max|y_2(n) - y(n-2)| = %g -> No difference at k = 2, but cannot conclude the time-invariant property\n\n", max(abs(diff_cp)));

// =========================================================================
// Part (d): System y(n) = n * x(n)
// =========================================================================
// (2) Output y(n) = n * x(n) for n = 0:3 => y = [0 1 2 3]
yn = [0 1 2 3];
yorigin = 1;

// (3) y'_2(n) = y(n - 2) using delay
[y2pn, y2porigin] = delay(yn, yorigin, 2);

// (4) x_2(n) = x(n - 2) using delay
[x2n, x2origin] = delay(xn, xorigin, 2);

// (5) y_2(n) = T[x_2(n)] = n * x_2(n): x_2 is non-zero for n = 2:5 => y_2 = [2 3 4 5]
y2n = [2 3 4 5];
y2origin = x2origin;

// (6) Difference y_2(n) - y'_2(n) using add
[diff_d, diff_d_origin] = add(y2n, y2origin, -y2pn, y2porigin);

// Project signals onto common display axis n = -7:7
xp   = onaxis(xn, xorigin, n);
yp   = onaxis(yn, yorigin, n);
y2pp = onaxis(y2pn, y2porigin, n);
x2p  = onaxis(x2n, x2origin, n);
y2p  = onaxis(y2n, y2origin, n);
diff_dp = onaxis(diff_d, diff_d_origin, n);

figure(3); clf();
subplot(3, 2, 1); stemplot(n, xp, "(1) Input signal x(n)");
subplot(3, 2, 2); stemplot(n, yp, "(2) Output signal y(n) = nx(n)");
subplot(3, 2, 3); stemplot(n, y2pp, "(3) y''_2(n) = y(n-2) : output shifted by 2");
subplot(3, 2, 4); stemplot(n, x2p, "(4) x_2(n) = x(n-2) : input shifted by 2");
subplot(3, 2, 5); stemplot(n, y2p, "(5) y_2(n) = T[x_2(n)] : response to shifted input");
subplot(3, 2, 6); stemplot(n, diff_dp, "(6) Difference y_2(n) - y''_2(n) <> 0");
savefig("add_ex2_6_d");

mprintf("Exercise 2.6 (d): System y(n) = n * x(n)\n");
mprintf("  y_2(n) non-zero values at n = 2..5: %s\n", strcat(string(y2p(find(diff_dp <> 0))), " "));
mprintf("  y(n-2) non-zero values at n = 2..5: %s\n", strcat(string(y2pp(find(diff_dp <> 0))), " "));
mprintf("  max|y_2(n) - y(n-2)| = %g -> Time-variant\n", max(abs(diff_dp)));
