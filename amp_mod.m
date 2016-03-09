r = audiorecorder(48000, 16, 1);
    recordblocking(r, 2);     % speak into microphone...
p = play(r);   % listen to complete recording
mySpeech = getaudiodata(r);

fs = 48000;
fc = 500000;
N = fc; % number of samples
t = [0:2*N-1]/N; % time array
carrier = cos( 2*pi*100000*t );
 
sp = resample(mySpeech,fc,fs);
sp = sp';

alpha = 0.7; %higher index modulation --> higher amplitude // lower index modulation --> lower amplitude
test = (1 + alpha*sp).*carrier;
plot(abs(fft(test)));

q = 100000;
sm = test([1:q] + 90000);
range = ([0:q-1]/q)*fs;
plot(range, abs(fft(sm)))