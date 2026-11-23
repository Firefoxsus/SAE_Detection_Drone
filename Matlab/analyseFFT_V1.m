clc;
clearvars;

[y, Fs] = audioread('C:\Users\Hugo\Documents\INSA\P2\SAE\FichierAudio\Ed_Fp_10_F15_N_W_dw_ev2_M1.wav');

y = y(:, 1);                    % Passage en mono si stéréo
y = y - mean(y);                % Suppression de la composante continue (0 Hz)
N = length(y);

% Calcul du spectre d'amplitude unilatéral
Y = fft(y);
P2 = abs(Y / N);
P1 = P2(1:floor(N/2)+1);
P1(2:end-1) = 2 * P1(2:end-1);

f = Fs * (0:floor(N/2)) / N;

% Tracé avec axe fréquentiel logarithmique
figure;
semilogx(f, 10*log10(P1));
title('Spectre fréquentiel unilatéral (axe X logarithmique)');
xlabel('Fréquence (Hz)');
ylabel('Amplitude |P1(f)|');
xlim([20 Fs/2]);                % Évite 0 Hz (infini en échelle log)
grid on;
