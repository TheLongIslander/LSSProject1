%% Written by Nurullah Dogan

function [angle_degrees, L] = lab1est(A, B, y1, y2, fs)

% A: distance between the two microphones (microphone spacing)
% B: distance to the sound source (horizontal distance)
% y1: the signal received by microphone 1
% y2: the signal received by microphone 2
% fs: Sampling frequency in Hz (input parameter)

Speed_of_sound = 343;  % Speed of sound in air (meters per second)

%% Computing the cross-correlation of y1 & y2
[cross_corr, Time_shifts] = xcorr(y1, y2);  
% cross_corr: cross-correlation values between y1 and y2 at various time shifts
% Time_shifts: sample shifts (lags) corresponding to each cross-correlation value

% Find the maximum cross-correlation value and its index
[max_corr, max_corr_Index] = max(cross_corr);  
% max_corr: the maximum value of the cross-correlation, representing the strongest alignment between y1 and y2
% max_corr_Index: the index of the peak value in the cross-correlation

% Convert the sample shift to time shift
SampleShift = Time_shifts(max_corr_Index);  % The sample shift (lag) corresponding to the maximum cross-correlation
time_shift = SampleShift / fs;  % Convert the sample shift to time shift in seconds by dividing by the sampling frequency
% This gives the relative time delay between when the signal is received by the two microphones

% Compute relative time delay
absoluteTimeDelay = abs(time_shift);  
% Compute the relative time delay (τ1 - τ2), which is the absolute value of the time shift
% This represents the time difference between when the signal reached mic1 and mic2

sinOftheta = min(max((absoluteTimeDelay * Speed_of_sound)/A, -1), 1);
% this is the sine of the angle of arrival (sin(theta)).
% We use the min function so the value does not exceed 1 as the range of
% sin functions are typically from -1 to 1 and for noise calculation purposes

angle_radians = asin(sinOftheta); % we find the angle of direction of the sound using the inverse sin function

angle_degrees = angle_radians * (180/pi); % we turn the angle (given in radians) to degrees, even though its not required

L = B * tan(angle_radians); % Estimate the distance L using the  distance B and the angle 
fprintf("Direction angle (in degrees) is: %.3f\n", angle_degrees);
fprintf("The L (in meters) is: %.3f\n", L);

end


