% Define the transmitted signal
sig = @(t) 100 * cos(10000 * pi * t); % Transmitted signal

% Define parameters
A = 2.5e-2; % A = 2.5 cm converted to meters
B = 0.1; % 100 mm or 10 cm
L = 0.1; % 100 mm or 10 cm
fs = 1e6; % Sampling rate of 1 MHz (1e6 samples per second)

% Generate the signals y1(t) and y2(t) using lab1sim
[y1sig, y2sig] = lab1sim(A, B, L, sig);

% Define time vector for t from 0 to 5 ms
t = 0:1/fs:5e-3; % Time from 0 to 5 ms

% Generate the signals over time t
y1 = y1sig(t); % Signal at microphone 1
y2 = y2sig(t); % Signal at microphone 2

% Compute the cross-correlation and lags
[C, lags] = xcorr(y1, y2);

% Convert lags to time (in seconds) by dividing by the sampling rate
time_lags = lags / fs;

% Find the peak of the cross-correlation
[~, peakIndex] = max(C); % Find index of maximum cross-correlation
relative_time_shift = time_lags(peakIndex); % Relative time shift

% Plot the cross-correlation versus time lags
figure;
plot(time_lags*1e3, C); % Plot in milliseconds
xlabel('Time Lag (ms)');
ylabel('Cross-Correlation');
title('Cross-Correlation between y1(t) and y2(t)');
grid on;

% Mark the peak on the plot
hold on;
plot(relative_time_shift*1e3, C(peakIndex), 'ro'); % Peak marked in red
legend('Cross-Correlation', 'Peak (Relative Time Shift)');

% Zoomed-in plot around the peak
figure;
plot(time_lags*1e3, C); % Plot in milliseconds
xlim([relative_time_shift*1e3 - 0.05, relative_time_shift*1e3 + 0.05]); % Zoom in
xlabel('Time Lag (ms)');
ylabel('Cross-Correlation');
title('Zoomed-In Cross-Correlation around Peak');
grid on;

% Display the relative time shift
disp(['Relative time shift: ', num2str(relative_time_shift*1e3), ' ms']);
