%Problem B
t = 0:1e-6:1e-3; % Time in seconds (1e-6 is the step size for 1 microsecond)

u = @(t) t >= 0; % Unit step function u(t)

s = 100 * cos(10000 * pi * t) .* (u(t) - u(t - 1e-3)); % Applying the time window

% Plot the signal
figure;
plot(t*1e3, s); % Convert time to milliseconds for the plot
xlabel('Time (ms)');
ylabel('Amplitude');
title('Signal s(t) between 0 and 1 ms');
grid on;

%Problem D

% Given parameters
A = 2.5e-2; % A = 2.5 cm converted to meters
c_s = 343; % Speed of sound in m/s
B = 0.1; % As specified earlier in the question (B = 0.1 m)
L = 0.1; % As specified earlier (L = 0.1 m)

% Calculate the delays tau1 and tau2 based on distances
tau1 = sqrt(B^2 + (L - A)^2) / c_s; % Delay for microphone 1
tau2 = sqrt(B^2 + (L - 2*A)^2) / c_s; % Delay for microphone 2

% Determine tau_min and tau_max
tau_min = min(tau1, tau2);
tau_max = max(tau1, tau2);

% Define the time vector based on tau_min and tau_max
t = (tau_min - 0.5e-3):1e-6:(tau_max + 0.5e-3); % Time in seconds

% Define the signal s(t)
s = @(t) 100 * cos(10000 * pi * t); % Transmitted signal

% Define the received signals at the two microphones (delayed versions of s(t))
y1 = s(t - tau1); % Received signal at microphone 1
y2 = s(t - tau2); % Received signal at microphone 2

% Plot the received signals vertically stacked
figure;

% Plot signal for microphone 1
subplot(2,1,1); % Top plot
plot(t*1e3, y1); % Convert time to milliseconds for the plot
xlabel('Time (ms)');
ylabel('Amplitude');
title('Received Signal at Microphone 1');
grid on;

% Plot signal for microphone 2
subplot(2,1,2); % Bottom plot
plot(t*1e3, y2); % Convert time to milliseconds for the plot
xlabel('Time (ms)');
ylabel('Amplitude');
title('Received Signal at Microphone 2');
grid on;

