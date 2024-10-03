% Define the time vector
t = linspace(0, 1, 1000);

% Define the original signal
x_t = cos(10 * pi * t);

% Define the four signals
x1 = x_t .^ 2;  % x(t)^2
x2 = x_t .* cos(10 * pi * (t - 0.1));  % x(t) * x(t - 0.1)
x3 = x_t .* cos(10 * pi * (t - 0.4));  % x(t) * x(t - 0.4)
x4 = x_t .* cos(10 * pi * (t - 0.55)); % x(t) * x(t - 0.55)

% Create a 2x2 grid of subplots
figure;

% Plot x(t)^2
subplot(2, 2, 1);
plot(t, x1);
title('x(t)^2');
xlabel('Time (t)');
ylabel('Amplitude');

% Plot x(t) * x(t - 0.1)
subplot(2, 2, 2);
plot(t, x2);
title('x(t) * x(t - 0.1)');
xlabel('Time (t)');
ylabel('Amplitude');

% Plot x(t) * x(t - 0.4)
subplot(2, 2, 3);
plot(t, x3);
title('x(t) * x(t - 0.4)');
xlabel('Time (t)');
ylabel('Amplitude');

% Plot x(t) * x(t - 0.55)
subplot(2, 2, 4);
plot(t, x4);
title('x(t) * x(t - 0.55)');
xlabel('Time (t)');
ylabel('Amplitude');

% Adjust layout to avoid overlap
sgtitle('Signal Plots in 2x2 Grid');
