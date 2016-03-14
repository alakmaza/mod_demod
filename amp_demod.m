%modulate
fs = 500000; N = fs;
t = [0:2*N-1]/N;
carrier = cos( 2*pi*100000*t );
 
sp = resample(mySpeech,fs,48000); sp = sp';

alpha = 0.7;
mod = (1 + alpha*sp).*carrier;
plot(abs(fft(mod)));

%%demodulate
n = fs/100;
c = fir1(n, [99900 100100]/fs*2);
carr = filtfilt(c,1,mod);
plot(abs(fft(carr)))

demod = mod.*carr;
demod = resample(demod,48000,fs);

fs = 500000; fc = 48000/fs;
b = fir1(1000, 2*fc);
y = filtfilt(b,1,demod);
y = y';
y = y - mean(y);

plot(mySpeech)
plot(y*2)
plot(abs(fft(y)))
