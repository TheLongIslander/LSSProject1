% Parameters
A = 0.025;  % Microphone separation in meters (2.5 cm)
B = 200;    % Horizontal distance from source to microphones in meters
c_s = 343;  % Speed of sound in m/s
L_vals = 5:5:200;  % L values from 5 to 200 meters (multiples of 5)

% Preallocate arrays for angles
theta_true = zeros(size(L_vals));
theta_est = zeros(size(L_vals));

% Loop through L values and calculate true and estimated angles
for i = 1:length(L_vals)
    L = L_vals(i);

    % True angle calculation
    theta_true(i) = atand(L / B);  % True angle (in degrees) using trigonometry

    % Simulate the signals using lab1sim
    sig = @(t) 100 * cos(10000 * pi * t);  % Signal function
    [y1sig, y2sig] = lab1sim(A, B, L, sig);  % Simulate signals

    % Time vector and sampling rate
    t_max = 5;  % Simulation time in seconds
    fs = 1e6;   % Sampling frequency of 1 MHz
    t = 0:1/fs:t_max;

    % Evaluate signals at each time instant
    y1 = y1sig(t);
    y2 = y2sig(t);

    % Use xcorr to find the time delay (tau1 - tau2)
    [C, lags] = xcorr(y1, y2);
    [~, idx] = max(C);  % Find index of maximum correlation
    time_shift = lags(idx) / fs;  % Convert lag index to time shift

    % Estimate the angle using the far-field approximation formula
    theta_est(i) = asind((time_shift * c_s) / A);  % Estimated angle (degrees)
end

% Plot the true and estimated angles as a function of L
figure;
plot(L_vals, theta_true, 'b', 'LineWidth', 2); hold on;
plot(L_vals, theta_est, 'r--', 'LineWidth', 2);
legend('True Angle', 'Estimated Angle', 'Location', 'SouthEast');
xlabel('Distance L (in meters)');
ylabel('Angle \theta (in degrees)');
title('True vs Estimated Angle as a Function of L');
grid on;