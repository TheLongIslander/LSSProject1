% Define the transmitted signal
transmitted_signal = @(time) 100 * cos(10000 * pi * time); % Transmitted signal

% Define parameters
paramA = 2.5e-2; % 2.5 cm in meters
paramB = 0.1; % 100 mm or 10 cm
paramL = 0.1; % 100 mm or 10 cm

% Call the function lab1sim
[received_signal1, received_signal2] = lab1sim(paramA, paramB, paramL, transmitted_signal);

% Define the time vector
time_vector = 0:1e-6:1e-3; % Time in seconds (from 0 to 1 ms)

% Plot the two received signals
figure;

% Plot signal for microphone 1
subplot(2,1,1); % Top plot
plot(time_vector*1e3, received_signal1(time_vector)); % Convert time to milliseconds for the plot
xlabel('Time (ms)');
ylabel('Amplitude');
title('Received Signal at Microphone 1');
grid on;

% Plot signal for microphone 2
subplot(2,1,2); % Bottom plot
plot(time_vector*1e3, received_signal2(time_vector)); % Convert time to milliseconds for the plot
xlabel('Time (ms)');
ylabel('Amplitude');
title('Received Signal at Microphone 2');
grid on;
