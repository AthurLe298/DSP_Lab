mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);

// Part (b): System y(n) = x(n^2)
n = -7:7;
x = bool2s((n >= 0) & (n <= 3));
y = bool2s((n.^2 >= 0) & (n.^2 <= 3));
y2p = bool2s(((n - 2).^2 >= 0) & ((n - 2).^2 <= 3));
x_2 = bool2s((n - 2 >= 0) & (n - 2 <= 3));
y_2 = bool2s((n.^2 - 2 >= 0) & (n.^2 - 2 <= 3));

figure(1); clf();
subplot(3, 2, 1); stemplot(n, x, "(1) Input signal x(n)");
subplot(3, 2, 2); stemplot(n, y, "(2) Output signal y(n) = x(n^2)");
subplot(3, 2, 3); stemplot(n, y2p, "(3) y''_2(n) = y(n-2) : output shifted by 2");
subplot(3, 2, 4); stemplot(n, x_2, "(4) x_2(n) = x(n-2) : input shifted by 2");
subplot(3, 2, 5); stemplot(n, y_2, "(5) Output signal y_2(n) = x(n^2-2)");
subplot(3, 2, 6); stemplot(n, y_2 - y2p, "(6) Difference y_2(n) - y''_2(n) <> 0");
savefig("add_ex2_6_b");

// Part (c): System y(n) = x(n) - x(n - 1)
n = -7:7;
x = bool2s((n >= 0) & (n <= 3));
y = bool2s((n >= 0) & (n <= 3)) - bool2s((n - 1 >= 0) & (n - 1 <= 3));
y2p = bool2s((n - 2 >= 0) & (n - 2 <= 3)) - bool2s((n - 3 >= 0) & (n - 3 <= 3));
x_2 = bool2s((n - 2 >= 0) & (n - 2 <= 3));
y_2 = bool2s((n - 2 >= 0) & (n - 2 <= 3)) - bool2s((n - 3 >= 0) & (n - 3 <= 3));

figure(2); clf();
subplot(3, 2, 1); stemplot(n, x, "(1) Input signal x(n)");
subplot(3, 2, 2); stemplot(n, y, "(2) Output signal y(n) = x(n) - x(n-1)");
subplot(3, 2, 3); stemplot(n, y2p, "(3) y''_2(n) = y(n-2) : output shifted by 2");
subplot(3, 2, 4); stemplot(n, x_2, "(4) x_2(n) = x(n-2) : input shifted by 2");
subplot(3, 2, 5); stemplot(n, y_2, "(5) y_2(n) = T[x_2(n)] : response to shifted input");
subplot(3, 2, 6); stemplot(n, y_2 - y2p, "(6) Difference y_2(n) - y''_2(n) = 0");
savefig("add_ex2_6_c");

// Part (d): System y(n) = n * x(n)
n = -7:7;
x = bool2s((n >= 0) & (n <= 3));
y = n .* bool2s((n >= 0) & (n <= 3));
y2p = (n - 2) .* bool2s((n - 2 >= 0) & (n - 2 <= 3));
x_2 = bool2s((n - 2 >= 0) & (n - 2 <= 3));
y_2 = n .* bool2s((n - 2 >= 0) & (n - 2 <= 3));

figure(3); clf();
subplot(3, 2, 1); stemplot(n, x, "(1) Input signal x(n)");
subplot(3, 2, 2); stemplot(n, y, "(2) Output signal y(n) = nx(n)");
subplot(3, 2, 3); stemplot(n, y2p, "(3) y''_2(n) = y(n-2) : output shifted by 2");
subplot(3, 2, 4); stemplot(n, x_2, "(4) x_2(n) = x(n-2) : input shifted by 2");
subplot(3, 2, 5); stemplot(n, y_2, "(5) y_2(n) = T[x_2(n)] : response to shifted input");
subplot(3, 2, 6); stemplot(n, y_2 - y2p, "(6) Difference y_2(n) - y''_2(n) <> 0");
savefig("add_ex2_6_d");
