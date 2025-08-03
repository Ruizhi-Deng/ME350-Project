% 设置字体为 Times New Roman
set(groot, 'defaultAxesFontName', 'Times New Roman');

% Link lengths
l_AB = 400; % mm
l_BC = 310; % mm
l_CE = 350; % mm
l_OB = 400; % mm

% theta_1 range in degrees
theta1 = 30:0.1:70;

% 预分配数组
d = zeros(size(theta1));
theta2 = zeros(size(theta1));
l_OC = zeros(size(theta1));

% 计算 d, theta2, l_OC
for i = 1:length(theta1)
    th1 = theta1(i);
    d(i) = sqrt(l_AB^2 + l_BC^2 - 2*l_AB*l_BC*cosd(th1));
    theta2(i) = acosd((d(i)^2 + l_BC^2 - l_AB^2)/(2*d(i)*l_BC));
    l_OC(i) = sqrt(l_OB^2 + l_BC^2 - 2*l_OB*l_BC*cosd(90 - th1));
end

% 找出 l_OC = 334 和 184 的最近点
[~, idx_334] = min(abs(l_OC - 334));
[~, idx_184] = min(abs(l_OC - 184));

% 提取对应值
theta1_334 = theta1(idx_334);
d_334 = d(idx_334);
theta2_334 = theta2(idx_334);

theta1_184 = theta1(idx_184);
d_184 = d(idx_184);
theta2_184 = theta2(idx_184);

% 打印结果
fprintf('--- 当 l_OC = 334 mm 时 ---\n');
fprintf('theta1 = %.2f deg\n', theta1_334);
fprintf('d       = %.2f mm\n', d_334);
fprintf('theta2 = %.2f deg\n\n', theta2_334);

fprintf('--- 当 l_OC = 184 mm 时 ---\n');
fprintf('theta1 = %.2f deg\n', theta1_184);
fprintf('d       = %.2f mm\n', d_184);
fprintf('theta2 = %.2f deg\n', theta2_184);


% 创建图像并控制尺寸
figure('Units','centimeters','Position',[2 2 30 10]); % 30x10 cm 横向

% 三图并排
tiledlayout(1,3, 'Padding', 'compact', 'TileSpacing', 'compact');

% === 图1：d vs theta_1 ===
nexttile;
plot(theta1, d, 'b', 'LineWidth', 1.5, 'DisplayName', 'd'); hold on;
% plot(theta1(idx_334), d(idx_334), 'ro', 'DisplayName','l_{OC} = 334');
% plot(theta1(idx_184), d(idx_184), 'go', 'DisplayName','l_{OC} = 184');
xlabel('\theta_1 (deg)', 'FontName', 'Times New Roman');
ylabel('d (mm)', 'FontName', 'Times New Roman');
title('d vs \theta_1', 'FontName', 'Times New Roman');
legend('Location','best');
% axis equal;
pbaspect([1 1 1]);
grid on;

% === 图2：theta_2 vs theta_1 ===
nexttile;
plot(theta1, theta2, 'r', 'LineWidth', 1.5, 'DisplayName', '\theta_2'); hold on;
% plot(theta1(idx_334), theta2(idx_334), 'ro', 'DisplayName','l_{OC} = 334');
% plot(theta1(idx_184), theta2(idx_184), 'go', 'DisplayName','l_{OC} = 184');
xlabel('\theta_1 (deg)', 'FontName', 'Times New Roman');
ylabel('\theta_2 (deg)', 'FontName', 'Times New Roman');
title('\theta_2 vs \theta_1', 'FontName', 'Times New Roman');
legend('Location','best');
% axis equal;
pbaspect([1 1 1]);
grid on;

% === 图3：l_OC vs theta_1 ===
nexttile;
plot(theta1, l_OC, 'k', 'LineWidth', 1.5, 'DisplayName', 'l_{OC}'); hold on;
% plot(theta1(idx_334), l_OC(idx_334), 'ro', 'DisplayName','l_{OC} = 334');
% plot(theta1(idx_184), l_OC(idx_184), 'go', 'DisplayName','l_{OC} = 184');
xlabel('\theta_1 (deg)', 'FontName', 'Times New Roman');
ylabel('l_{OC} (mm)', 'FontName', 'Times New Roman');
title('l_{OC} vs \theta_1', 'FontName', 'Times New Roman');
legend('Location','best');
% axis equal;
pbaspect([1 1 1]);
grid on;
