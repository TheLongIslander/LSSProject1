%Aditya Rajesh
function [mic1sig, mic2sig] = lab1sim(A, B, L, inputSignal)
    % Constants
    speedOfSound = 343; % Speed of sound in m/s

    % Calculate the delays delay1 and delay2
    delay1 = sqrt(B^2 + (L - A)^2) / speedOfSound; % Delay for microphone 1
    delay2 = sqrt(B^2 + (L - 2*A)^2) / speedOfSound; % Delay for microphone 2

    % Anonymous functions for y1(t) and y2(t) (delayed signals)
    mic1sig = @(t) inputSignal(t - delay1); % y1(t) is the signal delayed by delay1
    mic2sig = @(t) inputSignal(t - delay2); % y2(t) is the signal delayed by delay2
end
