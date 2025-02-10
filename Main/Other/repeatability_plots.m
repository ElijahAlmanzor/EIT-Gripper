%after plots of repeatability
a = []
yb1 = b1';
yo1 = o1';
yk1 = k1';
all = [b1;o1;k1]';
% b1 = []
% b2 = []
% b3 = []
% o1 = []
% o2 = []
% o3 = []
% k1 = []
% k2 = []
% k3 = []

%normalise between 0 and 1 for each feature vector
% for i=1:32
%    yb1(i,:) = normalize(yb1(i,:),'range');
% end
% 
% for i=1:32
%    yo1(i,:) = normalize(yo1(i,:),'range');
% end
% 
% for i=1:32
%    yk1(i,:) = normalize(yk1(i,:),'range');
% end
for i=1:32
    yb1(i,:) = yb1(i,:)/(max(all(i,:)));
end
for i=1:32
    yo1(i,:) = yo1(i,:)/(max(all(i,:)));
end
for i=1:32
    yk1(i,:) = yk1(i,:)/(max(all(i,:)));
end


set(gca,'DefaultTextFontSize',18)
one_axis = zeros(1,32) + 1
%just the x axis plot
x_axis = [1:32];

%means and std devs
yb1_means = mean(yb1(:,55:60),2)%mean of each row
yb1_means = yb1_means'
yb1_sd = std(yb1(:,55:60),0,2) %standard dev of each row
yb1_sd = yb1_sd'

x_axis = [1:32];

%means and std devs
yo1_means = mean(yo1(:,55:60),2)
yo1_means = yo1_means'
yo1_sd = std(yo1(:,55:60),0,2)
yo1_sd = yo1_sd'

yk1_means = mean(yk1(:,55:60),2)
yk1_means = yk1_means'
yk1_sd = std(yk1(:,55:60),0,2)
yk1_sd = yk1_sd'

%tiledlayout(1,3)

%nexttile
hold on

for j=55:60
    
    h1 = scatter(x_axis, yb1(:,j),'MarkerEdgeColor', [0.7,0.7,0.7]);
    h1 = scatter(x_axis, yo1(:,j),'MarkerEdgeColor', [0.7,0.7,0.7]);
    h1 = scatter(x_axis, yk1(:,j),'MarkerEdgeColor', [0.7,0.7,0.7]);
end

% plot(x_axis,one_axis,'-k')
% plot(x_axis,one_axis*-1,'-k')
%comparison between the mean with the error bars
h2 = errorbar(x_axis,yb1_means,yb1_sd,'ks','MarkerFaceColor',[0.9290 0.8940 0.1])
h3 = errorbar(x_axis,yo1_means,yo1_sd,'ks','MarkerFaceColor',[0.9290 0.6940 0.1250])
h4 = errorbar(x_axis,yk1_means,yk1_sd,'ks','MarkerFaceColor',[0.10 0.8940 0.1250])

xlabel('Sensor Features')
ylabel('Normalised Measured Impedance')
title('Banana')
legend([h1 h2 h3 h4],{'Data Points','Banana Mean with Std Dev','Orange Mean with Std Dev','Kiwi Mean with Std Dev'})
grid on
hold off
% 

% 
% nexttile
% hold on
% 
% for j=55:60
% h1 = scatter(x_axis, yo1(:,j),'MarkerEdgeColor', [0.7,0.7,0.7]);
% end
% %comparison between the mean with the error bars
% h2 = errorbar(x_axis,yo1_means,yo1_sd,'ks','MarkerFaceColor',[0.9290 0.6940 0.1250])
% xlabel('Sensor Features')
% %ylabel('Normalised Measured Impedance')
% legend([h1 h2],{'Data Points','Mean with Std Dev'})
% title('Orange')
% grid on
% hold off
% % 
% % nexttile
% % %plot each data point
% % for i=1:32
% %     hold on
% %     scatter(x_axis,yk1(:,i)','go')
% % end
% 
% 
% 
% nexttile
% hold on
% 
% for j=55:60
% h1 = scatter(x_axis, yk1(:,j),'MarkerEdgeColor', [0.7,0.7,0.7]);
% end
% % % plot(x_axis,z, 'k-')
% % % plot(x_axis,z*-1,'k-')
% % %comparison between the mean with the error bars
% h2 = errorbar(x_axis,yk1_means,yk1_sd,'ks','MarkerFaceColor',[0.10 0.8940 0.1250])
% xlabel('Sensor Features')
% %ylabel('Normalised Measured Impedance')
% title('Kiwi')
% %legend([yk1(1)  yk1_means],{'Legend 1','Legend 3'})
% legend([h1 h2],{'Data Points','Mean with Std Dev'})
% grid on
% hold off
% % 
% % 
% % % figure 
% % % hold on
% % % errorbar(x_axis,yb1_means,yb1_sd,'ks','MarkerFaceColor',[0.9290 0.8940 0.1], 'LineWidth', 1.5)
% % % errorbar(x_axis,yo1_means,yo1_sd,'ks','MarkerFaceColor',[0.9290 0.6940 0.1250], 'LineWidth',1.5)
% % % errorbar(x_axis,yk1_means,yk1_sd,'ks','MarkerFaceColor',[0.10 0.8940 0.1250], 'LineWidth',1.5)
