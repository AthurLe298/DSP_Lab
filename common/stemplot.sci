// standard plot for a discrete-time signal.
//
// This helper widens the data bounds by one index on each side and marks each sample tip with a circle.
//
// Usage:  stemplot(n, x, "title")

function stemplot(n, x, ttl)
    plot2d3(n, x);                 // vertical bars
    plot2d(n, x, -9, "000");       // circle markers
    ylo = min(min(x), 0) - 1;
    yhi = max(max(x), 0) + 1;
    a = gca();
    a.data_bounds = [min(n)-1, ylo ; max(n)+1, yhi];
    a.box = "on";
    xgrid();
    title(ttl);
    xlabel("n");
    ylabel("Amplitude");
endfunction

// alignaxes()
// Aligns the horizontal (n-axis) data bounds across all subplots in the current figure
// without modifying the signals or requiring the add() function.
function alignaxes()
    f = gcf();
    xmin = %inf; xmax = -%inf;
    for i = 1:length(f.children)
        if f.children(i).type == "Axes" then
            xmin = min(xmin, f.children(i).data_bounds(1, 1));
            xmax = max(xmax, f.children(i).data_bounds(2, 1));
        end
    end
    for i = 1:length(f.children)
        if f.children(i).type == "Axes" then
            f.children(i).data_bounds(1, 1) = xmin;
            f.children(i).data_bounds(2, 1) = xmax;
        end
    end
endfunction
