train_size = 40:40:120;
noise = 0:0.5:2;
Q = 5:5:20;

% Q=20
X40 = [-0.44083,-0.33202,0.19339,0.6379, 0.95484];
X80 = [-1.6966,-1.643,-1.5469,-1.4874,-1.445];
X120 = [-1.9713,-1.9469,-1.7569,-1.7955,-1.6949];

plot(noise,X40)
hold all
plot(noise,X80,'green')
plot(noise,X120, 'red')
xlabel('var');
ylabel('median overfit');
legend('size = 40,','size = 80', 'size = 120','Location','northoutside');
text(2,0.0,'Qf = 20');
hold off

% Q = 20
M40 = [6401.0226,887.0187,196.1367,18085.0049,1548.3898];
M80 = [-0.37098,0.72778,5.5401,1.5775,6.8318];
M120 = [-2.0419,-2.0113,-1.3266,-1.644,-1.3374];

% plot(noise,M40)
% hold all
% plot(noise,M80, 'green')
% plot(noise,M120, 'red')
% xlabel('var');
% ylabel('mean overfit');
% legend('size = 40,','size = 80', 'size = 120','Location','northoutside');
% text(2,0.0,'Qf = 20');
% hold off

%noise = 0
% Q40 = [-0.79862,-2.1236,-0.70442,-0.44083];
% Q80 = [-0.78334,-2.0322,-1.6268,-1.6966];
% Q120 = [-0.6787,-2.1233,-2.0748,-1.9713];

%noise = 1
% Q40 = [-0.079179,-1.1924,-0.098578,0.19339];
% Q80 = [-0.55336,-1.7376,-1.5646,-1.5469];
% Q120 = [-0.72583,-1.9692,-1.945,-1.7569];

%noise = 2
% Q40 = [0.41938,-0.70775,0.8193, 0.95484];
% Q80 = [-0.39824,-1.6792,-1.39,-1.445];
% Q120 = [-0.49598,-1.7285,-1.7149,-1.6949];
% 
% plot(Q,Q40)
% hold all
% plot(Q,Q80,'green')
% plot(Q,Q120, 'red')
% xlabel('Qf');
% ylabel('median overfit');
% legend('size = 40','size = 80', 'size = 120', 'Location','northoutside');
% text(20,-0.4,' var = 2');
% hold off
% 
MQ40 = [ -1.0186,-2.4534,182.4054,6401.0226];
MQ80 = [-0.98379,-2.3196,0.32113,-0.37098];
MQ120 = [-0.96993,-2.3394,-2.0314,-2.0419];

% plot(Q,MQ40)
% hold all
% plot(Q,MQ80, 'green')
% plot(Q,MQ120, 'red')
% xlabel('Qf');
% ylabel('mean overfit');
% legend('size = 40','size = 80', 'size = 120', 'Location','northoutside');
% text(20,0.0,' var = 0');
% hold off

% var = 0
Q5 = [-0.79862,-0.78334, -0.6787];
Q10 = [-2.1236,-2.0322,-2.1233];
Q15 = [-0.70442,-1.6268,-2.0748];
Q20 = [-0.44083,-1.6966,-1.9713];

% plot(train_size,Q5)
% hold all
% plot(train_size,Q10,'green')
% plot(train_size,Q15, 'red')
% plot(train_size,Q20, 'yellow')
% xlabel('size');
% ylabel('median overfit');
% legend('Q = 5','Q = 10', 'Q = 15','Q=20','Location','northoutside');
% text(2,0,' var = 0');
% hold off

% size = 120
MQ5 = [-1.0186,-0.98379,-0.96993];
MQ10 = [-2.4534,-2.3196,-2.3394];
MQ15 = [182.4054, 0.32113,-2.0314];
MQ20 = [6401.0226,-0.37098,-2.0419];

% plot(train_size,MQ5)
% hold all
% plot(train_size,MQ10, 'green')
% plot(train_size,MQ15, 'red')
% plot(train_size,MQ20, 'yellow')
% xlabel('size');
% ylabel('mean overfit');
% legend('Q = 5','Q = 10', 'Q = 15', 'Q = 20','Location','northoutside');
% text(120,7000,' var = 0');
% hold off