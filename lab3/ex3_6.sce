mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);
exec("lab3/convolution.sci", -1);

// x(n) = {1, -2, 3^, 6}  
// h(n) = {1^, 1, 1}  ->  horigin = 1
xn = [1 -2 3 6]; xorigin = 3;
hn = [1 1 1];    horigin = 1;

figure(1); clf();
[yn, yorigin] = convolution(xn, xorigin, hn, horigin);
alignaxes();

disp("  yn =");       disp(yn);
disp("  yorigin =");  disp(yorigin);

savefig("lab3_ex6");
