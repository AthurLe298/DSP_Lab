mode(0);
exec("common/savefig.sci", -1);

// low-contrast test image
H = 128; W = 128;
[X, Y] = meshgrid(1:W, 1:H);
img = 90 + 0.35*X;
img((X-45).^2 + (Y-45).^2 < 20^2) = 160;
img(75:110, 70:110) = 110;
img = round(img);

// histogram
function h = graycount(im)
    h = zeros(1, 256);
    for g = 0:255
        h(g+1) = sum(im == g);
    end
endfunction
h_img = graycount(img);

// histogram equalization
cdf = cumsum(h_img) / (H*W);
lut = round(255 * cdf);
eq  = matrix(lut(img(:) + 1), H, W);
h_eq = graycount(eq);
mprintf("  original  range: %d..%d\n", min(img), max(img));
mprintf("  equalized range: %d..%d\n", min(eq),  max(eq));

// blur
k    = ones(5, 5) / 25;
blur = round(conv2(img, k, "same"));

// LSB watermark
mark = bool2s(abs(X - Y) < 6 | abs(X + Y - W) < 6);
wm   = img - modulo(img, 2) + mark;
rec  = modulo(wm, 2);
mprintf("  watermark: max pixel change = %d, recovered bits wrong = %d\n", ..
        max(abs(wm - img)), sum(rec <> mark));

// display helpers
function showgray(im, ttl)
    Matplot(im + 1);
    a = gca();
    a.isoview = "on";
    a.axes_visible = ["off", "off", "off"];
    title(ttl);
endfunction

function showhist(h, ttl)
    plot2d3(0:255, h);
    a = gca();
    a.data_bounds = [0, 0; 255, 1.1*max(h)];
    a.tight_limits = "on";
    xgrid();
    title(ttl); xlabel("Gray level"); ylabel("Pixels");
endfunction

function grayfigure(num)
    figure(num); clf();
    f = gcf();
    f.color_map  = graycolormap(256);
    f.background = 256;
endfunction

// histogram and equalization
grayfigure(1);
subplot(2,2,1); showgray(img,  "Original (low contrast)");
subplot(2,2,2); showhist(h_img, "Histogram of original");
subplot(2,2,3); showgray(eq,   "Histogram equalized");
subplot(2,2,4); showhist(h_eq,  "Histogram after equalization");
savefig("lab4_ex5_hist");

// blur and watermark
grayfigure(2);
subplot(2,2,1); showgray(img,     "Original");
subplot(2,2,2); showgray(blur,    "Blurred (5x5 box filter)");
subplot(2,2,3); showgray(wm,      "Watermarked (LSB, invisible)");
subplot(2,2,4); showgray(255*rec, "Extracted watermark");

alignaxes();
savefig("lab4_ex5_filter");
