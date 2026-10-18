mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/advance.sci", -1);

// x(n) = {1, -2, 3^, 6}  ->  n = -2:1, xorigin = 3
xn = [1 -2 3 6];
xorigin = 3;
k = 1;

figure(1); clf();
[yn, yorigin] = advance(xn, xorigin, k);
alignaxes();

disp("  yn =");       disp(yn);
disp("  yorigin =");  disp(yorigin);

savefig("lab3_ex2");
