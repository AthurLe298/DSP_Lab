// Exporting image from the script 
// Usage:  savefig("lab1_ex2")

function savefig(name)
    if ~isdir("figures") then
        mkdir("figures");
    end
    f = gcf();
    f.axes_size = [800, 800]; // Enforce high resolution before export
    xs2png(f, "figures/" + name + ".png");
    mprintf("  saved figures/%s.png\n", name);
endfunction

