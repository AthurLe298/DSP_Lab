mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/add.sci", -1);

// x1(n) = {0^, 1, 3, -2}  ->  x1origin = 1
// x2(n) = {1, 1^, 2, 3}   ->  x2origin = 2
x1n = [0 1 3 -2]; x1origin = 1;
x2n = [1 1 2 3];  x2origin = 2;

figure(1); clf();
[yn, yorigin] = add(x1n, x1origin, x2n, x2origin);
alignaxes();

disp("  yn =");       disp(yn);
disp("  yorigin =");  disp(yorigin);

savefig("lab3_ex4");
