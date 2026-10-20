mode(0);
exec("common/stemplot.sci", -1);
exec("common/savefig.sci", -1);

// x(n) = {1^, 2, -3, 2, 1},  h(n) = {1^, 0, -1, -1, 1}
x = [1 2 -3 2 1];
h = [1 0 -1 -1 1];
N = length(x);
M = length(h);
hp = [h, zeros(1, N-M)];
n  = 0:N-1;

// folding and shifting 
xf   = x(pmodulo(-(0:N-1), N) + 1);
y_fs = zeros(1, N);
for nn = 0:N-1
    xs = xf(pmodulo((0:N-1) - nn, N) + 1);
    y_fs(nn+1) = sum(hp .* xs);
end

// matrix method (circulant)
Xc = zeros(N, N);
for r = 0:N-1
    for c = 0:N-1
        Xc(r+1, c+1) = x(pmodulo(r - c, N) + 1);
    end
end
y_mat = (Xc * hp')';

disp("  X (circulant) =");        disp(Xc);
disp("  y (folding/shifting) ="); disp(y_fs);
disp("  y (matrix method) =");    disp(y_mat);
disp("  y (ifft(fft.*fft), reference) =");
disp(round(real(ifft(fft(x) .* fft(hp)))));

// energy
Ex = sum(abs(x).^2);
Ey = sum(abs(y_fs).^2);
mprintf("  Ex = %g,  Ey = %g  (per period)\n", Ex, Ey);

// plot
figure(1); clf();
subplot(2,2,1); stemplot(n, x,            "x(n), one period");
subplot(2,2,2); stemplot(n, y_fs,         "y(n), circular convolution, N = 5");
subplot(2,2,3); stemplot(n, abs(x).^2,    "|x(n)|^2,  Ex = " + string(Ex));
subplot(2,2,4); stemplot(n, abs(y_fs).^2, "|y(n)|^2,  Ey = " + string(Ey));
savefig("lab4_ex7");
