mode(0);
exec("common/savefig.sci", -1);

// two-tone signal: 440 Hz + 1000 Hz
Fs = 8000;
t  = 0 : 1/Fs : 1 - 1/Fs;
y  = 0.6*sin(2*%pi*440*t) + 0.3*sin(2*%pi*1000*t);

// write to .wav and read back
wav = fullfile(TMPDIR, "two_tone.wav");
wavwrite(y, Fs, 16, wav);
[yr, Fsr, bits] = wavread(wav);
yr = matrix(yr, 1, -1);
mprintf("  read back: Fs = %d Hz, %d bits, %d samples\n", Fsr, bits, length(yr));
mprintf("  max |y - yr| = %e\n", max(abs(y - yr)));

// low-pass FIR filter, cutoff 700 Hz
fc = 700 / Fsr;
h  = wfir("lp", 101, [fc 0], "hm", [0 0]);
yf = convol(h, yr);
yf = yf(51 : 50 + length(yr));
wavwrite(yf, Fsr, 16, fullfile(TMPDIR, "two_tone_lowpass.wav"));

// playback
play = %f;
if play then
    playsnd(yr, Fsr);
    playsnd(yf, Fsr);
end

// magnitude spectra
N  = length(yr);
f  = (0:N-1) * Fsr / N;
half = 1 : N/2;
Y  = 2*abs(fft(yr)) / N;
YF = 2*abs(fft(yf)) / N;
mprintf("  before filter: |Y(440)| = %.3f, |Y(1000)| = %.3f\n", Y(441),  Y(1001));
mprintf("  after  filter: |Y(440)| = %.3f, |Y(1000)| = %.3f\n", YF(441), YF(1001));

// plot
figure(1); clf();

subplot(3,1,1);
idx = 1 : 0.02*Fs;
plot(t(idx), yr(idx), "b");
plot(t(idx), yf(idx), "r");
title("Waveform read from .wav (blue) and after the low-pass filter (red)");
xlabel("t (s)"); ylabel("Amplitude"); xgrid();

subplot(3,1,2);
plot(f(half), Y(half));
title("Spectrum of the original: 440 Hz and 1000 Hz");
xlabel("f (Hz)"); ylabel("Amplitude"); xgrid();

subplot(3,1,3);
plot(f(half), YF(half), "r");
title("Spectrum after low-pass filtering (fc = 700 Hz): only 440 Hz is left");
xlabel("f (Hz)"); ylabel("Amplitude"); xgrid();

savefig("lab4_ex4");
