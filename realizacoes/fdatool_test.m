Fs = 30000;              % Sampling Frequency
Fpass = 12000;           % Passband Frequency
Fstop = 13000;           % Stopband Frequency
Dpass = 0.01;            % Passband Ripple
Dstop = 0.01;            % Stopband Attenuation
flag  = 'scale';         % Sampling Flag
 
% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);
 
% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
 
hFIR = dsp.FIRFilter;
hFIR.Numerator = b;
 
% Para definir diretamente os coeficientes
realizemdl(hFIR)
 
% Para definir os coeficientes atrav?s de uma matriz de entrada
realizemdl(hFIR,'MapCoeffsToPorts','on');