%% Labelling MATLAB graphics with latex - Simple example

close all

x = 0:1e-1:20;
y = sqrt(x);

fig1 = figure('Name', 'Root function');
set(gcf, 'Position', [200, 200, 800, 800]);
set(gcf, 'Resize', 'off');
plot(x, y, 'r');
hold on; grid on

title('Graph of the root function on the interval $\left[ 0;\, 1\right]$', 'Interpreter', 'LaTex', 'Fontsize', 12);
xlabel('x $\rm{[1]}$','Interpreter','LaTex','FontSize', 12);
ylabel('y $\rm{[1]}$','Interpreter','LaTex','FontSize', 12);
leg = legend('$y = \sqrt{x}$', 'Interpreter', 'LaTex');
set(leg, 'Interpreter', 'LaTex', 'Fontsize', 14);