% Uncomment to load your data
% x = orange_inputs;
% t = orange_outputs;

% Choose a Training Function
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
net = fitnet([100, 100], trainFcn);
net.trainParam.epochs = 10000;

% Setup Division of Data for Training, Validation, and Testing
net.divideParam.trainRatio = 85 / 100;
net.divideParam.valRatio = 5 / 100;
net.divideParam.testRatio = 10 / 100;

% Train the Network
[net, tr] = train(net, x, t);

% Test the Network
y = net(x);
e = gsubtract(t, y);
performance = perform(net, t, y);

% Extract Test Data
tInd = tr.testInd;
tstlabel = t(:, tInd);  % Test labels
tstOutputs = net(x(:, tInd));  % Test outputs
test_e = gsubtract(tstlabel, tstOutputs);
mean_error = mean(abs(test_e), 2);
tstPerform = perform(net, t(tInd), tstOutputs);

% Plotting Weight Validation Data
figure;
[tstlabel_ascending, idx] = sort(tstlabel(1, :), 'ascend');
tstOutputs_ascending = tstOutputs(1, idx);
plot(tstOutputs_ascending, 'DisplayName', 'Predicted');
hold on;
plot(tstlabel_ascending, 'DisplayName', 'Label');
hold off;
title('Weight Validation Data');
xlabel('Data Points');
ylabel('Weight (g)');
legend;

% Plotting pH Validation Data
figure;
[tstlabel_ascending, idx] = sort(tstlabel(2, :), 'ascend');
tstOutputs_ascending = tstOutputs(2, idx);
plot(tstOutputs_ascending, 'DisplayName', 'Predicted');
hold on;
plot(tstlabel_ascending, 'DisplayName', 'Label');
hold off;
title('pH Validation Data');
xlabel('Data Points');
ylabel('pH');
legend;

% Plotting Brix Validation Data
figure;
[tstlabel_ascending, idx] = sort(tstlabel(3, :), 'ascend');
tstOutputs_ascending = tstOutputs(3, idx);
plot(tstOutputs_ascending, 'DisplayName', 'Predicted');
hold on;
plot(tstlabel_ascending, 'DisplayName', 'Label');
hold off;
title('Brix Validation Data');
xlabel('Data Points');
ylabel('Brix Content (%)');
legend;

% Uncomment these lines for additional plots
% figure, plotperform(tr);
% figure, plottrainstate(tr);
% figure, ploterrhist(e);
% figure, plotregression(t, y);
% figure, plotfit(net, x, t);
