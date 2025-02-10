close all;

% Split data into training, validation, and test sets
num_val = 50;
num_test = 50;

% Randomly select validation samples
idx = randperm(size(x, 1), num_val);
x_val = x(idx, :);
t_val = t(idx, :);
x(idx, :) = [];
t(idx, :) = [];

% Randomly select test samples
idx = randperm(size(x, 1), num_test);
x_test = x(idx, :);
t_test = t(idx, :);
x(idx, :) = [];
t(idx, :) = [];

% Define neural network layers
layers = [
    featureInputLayer(32, "Normalization", "rescale-symmetric")
    fullyConnectedLayer(100)
    tanhLayer
    fullyConnectedLayer(30)
    reluLayer
    fullyConnectedLayer(size(t, 2))
    regressionLayer("Name", "regressionoutput")
];

% Training options
miniBatchSize = 32;
validationFrequency = floor(numel(t) / miniBatchSize);

options = trainingOptions('adam', ...
    'MiniBatchSize', miniBatchSize, ...
    'MaxEpochs', 30, ...
    'InitialLearnRate', 1e-3, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {x_val, t_val}, ...
    'ValidationFrequency', validationFrequency, ...
    'Plots', 'training-progress', ...
    'Verbose', false);

% Train network
net = trainNetwork(x, t, layers, options);

% Performance evaluation
YPredicted = predict(net, x_test);
predictionError = t_test - YPredicted;
avg_error = mean(abs(predictionError), 1);  % Average error per output variable

% Plot function to avoid redundancy
plot_results = @(label, predicted, title_str, y_label) ...
    figure, [sorted_label, idx] = sort(label, 'ascend'); ...
    sorted_predicted = predicted(idx); ...
    plot(sorted_predicted, 'DisplayName', 'Predicted'); hold on; ...
    plot(sorted_label, 'DisplayName', 'Label'); hold off; ...
    title(title_str); xlabel('Data Points'); ylabel(y_label); legend;

% Plot validation results
plot_results(t_test(:,1), YPredicted(:,1), 'Weight Validation Data', 'Weight (g)');
plot_results(t_test(:,2), YPredicted(:,2), 'pH Validation Data', 'pH Value');
plot_results(t_test(:,3), YPredicted(:,3), 'Sugar Validation Data', 'Brix Content (%)');
