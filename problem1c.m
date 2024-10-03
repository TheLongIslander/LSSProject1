% Define the sampling frequency (44.1 kHz as given in the problem)
fs = 44.1e3;  
dt = 1 / fs;

% Define the time vector (adjusting to fit the range from -0.2 to 2.2 seconds)
t = -0.2:dt:2.2;

% Define the original signal x(t) = 2cos(10πt)(u(t) - u(t-2))
x_t = 2 * cos(10 * pi * t) .* (heaviside(t) - heaviside(t - 2));

% Define 200 evenly spaced tau values between -1 and 1
taus = linspace(-1, 1, 200);

% Initialize autocorrelation array
Rxx = zeros(size(taus));

% Compute Rxx for each tau using numerical integration
for i = 1:length(taus)
    tau = taus(i);
    shift_index = round(tau * fs);  % Convert tau into an index shift
    if shift_index >= length(x_t)  % Handle case where shift is larger than the signal length
        x_shifted = zeros(1, length(x_t));
    elseif shift_index >= 0
        x_shifted = [zeros(1, shift_index), x_t(1:end-shift_index)];  % Shifted signal
    else
        x_shifted = [x_t(-shift_index+1:end), zeros(1, -shift_index)];  % Negative shift
    end
    product = x_t .* x_shifted;  % Compute the product x(t) * x(t - tau)
    Rxx(i) = trapz(t, product);  % Approximate the integral using the trapezoidal rule
end

% Plot the autocorrelation Rxx versus tau
figure;
plot(taus, Rxx);
title('Autocorrelation R_{xx}(\tau) vs. \tau');
xlabel('\tau');
ylabel('R_{xx}(\tau)');
grid on;
hold on;

% Find and mark the peaks and valleys (extrema)
[pks, locs_peaks] = findpeaks(Rxx, taus);   % Find peaks
[valleys, locs_valleys] = findpeaks(-Rxx, taus);  % Find valleys

% Plot the peaks and valleys
plot(locs_peaks, pks, 'ro', 'MarkerFaceColor', 'r');  % Mark peaks
plot(locs_valleys, -valleys, 'bo', 'MarkerFaceColor', 'b');  % Mark valleys
legend('R_{xx}(\tau)', 'Peaks', 'Valleys');
hold off;

% Display the locations of peaks and valleys
disp('Peaks at tau:');
disp(locs_peaks');
disp('Valleys at tau:');
disp(locs_valleys');
