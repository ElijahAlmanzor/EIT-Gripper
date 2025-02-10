% Program for assigning hand-collected Brix, acidity, and weight values to the training data

% Define raw data
raw_weights = [75, 70, 73, 52, 70, 63, 89, 70, 61, 81, 95, 77, 77, 71, 73, 52, 69, 64, ...
               92, 69, 61, 82, 99, 78, 74, 68, 72, 50, 68, 64, 90, 68, 60, 80, 96, 76];

raw_ph = [3.26, 3.90, 3.18, 3.81, 3.32, 3.76, 3.387, 3.43, 3.31, 3.31, 3.50, 3.28, 3.40, 3.78, ...
          3.25, 3.96, 3.34, 3.57, 3.61, 3.49, 3.43, 3.33, 4.24, 3.38, 1.99, 2.20, 2.25, 2.57, ...
          2.43, 3.13, 2.16, 3.29, 2.99, 3.1, 3.19, 3.11];

raw_brix = [15.1, 6.5, 9.2, 9.6, 10.5, 7.7, 11.1, 8.6, 9.2, 9.6, 9.2, 10.3, 25.55, 13.7, ...
            14.1, 26.9, 13.2, 10.4, 26.1, 16.4, 11, 13.6, 28.7, 15.7, 22.3, 11.2, 15.5, ...
            11.6, 11.5, 7, 20.3, 11.7, 11.1, 10.7, 13.2, 11.5];

% Load input data (to be defined elsewhere)
orange_inputs = []; % Load input data here

% Number of repetitions per sample
num_repetitions = 60;
num_samples = length(raw_weights);

% Preallocate output matrix for efficiency
orange_outputs = zeros(num_samples * num_repetitions, 3);

% Assign labels to training data
for i = 1:num_samples
    idx_start = (i - 1) * num_repetitions + 1;
    idx_end = i * num_repetitions;
    
    orange_outputs(idx_start:idx_end, 1) = raw_weights(i);
    orange_outputs(idx_start:idx_end, 2) = raw_ph(i);
    orange_outputs(idx_start:idx_end, 3) = raw_brix(i);
end

% Transpose output matrix
orange_outputs = orange_outputs.';
