% Define the sampling frequency (44.1 kHz as given in the problem)
fs = 44.1e3;  
dt = 1 / fs;

% Define the time vector (adjusting to fit the range from -0.2 to 2.2 seconds)
t = -0.2:dt:2.2;

% Define the original signal x(t) = 2cos(10πt)(u(t) - u(t-2))
x_t = 2 * cos(10 * pi * t) .* (heaviside(t) - heaviside(t - 2));

% Define the four values of tau
taus = [0, 0.1, 0.4, 0.55];

% Initialize the autocorrelation values
Rxx = zeros(1, length(taus));

% Compute Rxx for each tau using numerical integration
for i = 1:length(taus)
    tau = taus(i);
    
    % Shifted signal x(t - tau)
    shift_index = round(tau * fs);  % Convert tau into an index shift
    x_shifted = [zeros(1, shift_index), x_t(1:end-shift_index)];  % Shifted signal
    
    % Compute the product x(t) * x(t - tau)
    product = x_t .* x_shifted;
    
    % Approximate the integral using the trapezoidal rule
    Rxx(i) = trapz(t, product);
end

% Display the results in a table
T = table(taus', Rxx', 'VariableNames', {'Tau', 'Rxx'});
disp(T);
