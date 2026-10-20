mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);

// x(n) = {1^, 2, -3, 2, 1},  h(n) = {1^, 0, -1}
x = [1 2 -3 2 1];
h = [1 0 -1];
Nx = length(x);
Nh = length(h);
Ny = Nx + Nh - 1;
n_x = 0:Nx-1;
n_y = 0:Ny-1;

// folding and shifting
hf   = h($:-1:1);
xpad = [zeros(1, Nh-1), x, zeros(1, Nh-1)];
y_fs = zeros(1, Ny);
for n = 0:Ny-1
    y_fs(n+1) = sum(xpad(n+1 : n+Nh) .* hf);
end

// matrix method
Hm = zeros(Ny, Nx);
for k = 1:Nx
    Hm(k : k+Nh-1, k) = h';
end
y_mat = (Hm * x')';

disp("  H =");                     disp(Hm);
disp("  y (folding/shifting) =");  disp(y_fs);
disp("  y (matrix method) =");     disp(y_mat);
disp("  y (convol, reference) ="); disp(convol(x, h));

// energy
Ex = sum(abs(x).^2);
Ey = sum(abs(y_fs).^2);
mprintf("  Ex = %g,  Ey = %g\n", Ex, Ey);

// plot
figure(1); clf();
subplot(2,2,1); stemplot(n_x, x,            "x(n)");
subplot(2,2,2); stemplot(n_y, y_fs,         "y(n) = x(n) * h(n)");
subplot(2,2,3); stemplot(n_x, abs(x).^2,    "|x(n)|^2,  Ex = " + string(Ex));
subplot(2,2,4); stemplot(n_y, abs(y_fs).^2, "|y(n)|^2,  Ey = " + string(Ey));

alignaxes();
savefig("lab4_ex6");
