%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MAE 107 LAB 5
% Samuel Chen
% UID: 704-453-763
%
%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clc;

%%%%%%%% LOAD DATA
load imp1; load imp2; load imp3; load imp4; load step_resp;




%%%%%% FIRST IMPULSE %%%%%%
imp1_time = imp1.X(1).Data;
qq = imp1_time<1.0;
imp1_input = imp1.Y(1).Data;

imp1_aaf = imp1.Y(2).Data;
offset = mean(imp1_aaf(qq));
imp1_aaf = imp1_aaf - offset;

imp1_hpf = imp1.Y(3).Data;
offset = mean(imp1_hpf(qq));
imp1_hpf = imp1_hpf - offset;

imp1_lpf = imp1.Y(4).Data;
offset = mean(imp1_lpf(qq));
imp1_lpf = imp1_lpf - offset;

imp1_res = imp1.Y(5).Data;
offset = mean(imp1_res(qq));
imp1_res = imp1_res - offset;



%%%%%% SECOND IMPULSE %%%%%%
imp2_time = imp2.X(1).Data;
imp2_input = imp2.Y(1).Data;

imp2_aaf = imp2.Y(2).Data;
offset = mean(imp2_aaf(qq));
imp2_aaf = imp2_aaf - offset;

imp2_hpf = imp2.Y(3).Data;
offset = mean(imp2_hpf(qq));
imp2_hpf = imp2_hpf - offset;

imp2_lpf = imp2.Y(4).Data;
offset = mean(imp2_lpf(qq));
imp2_lpf = imp2_lpf - offset;

imp2_res = imp2.Y(5).Data;
offset = mean(imp2_res(qq));
imp2_res = imp2_res - offset;



%%%%%% THIRD IMPULSE %%%%%%
imp3_time = imp3.X(1).Data;
imp3_input = imp3.Y(1).Data;

imp3_aaf = imp3.Y(2).Data;
offset = mean(imp3_aaf(qq));
imp3_aaf = imp3_aaf - offset;

imp3_hpf = imp3.Y(3).Data;
offset = mean(imp3_hpf(qq));
imp3_hpf = imp3_hpf - offset;

imp3_lpf = imp3.Y(4).Data;
offset = mean(imp3_lpf(qq));
imp3_lpf = imp3_lpf - offset;

imp3_res = imp3.Y(5).Data;
offset = mean(imp3_res(qq));
imp3_res = imp3_res - offset;


%%%%%% FOURTH IMPULSE %%%%%%
imp4_time = imp4.X(1).Data;
imp4_input = imp4.Y(1).Data;

imp4_aaf = imp4.Y(2).Data;
offset = mean(imp4_aaf(qq));
imp4_aaf = imp4_aaf - offset;

imp4_hpf = imp4.Y(3).Data;
offset = mean(imp4_hpf(qq));
imp4_hpf = imp4_hpf - offset;

imp4_lpf = imp4.Y(4).Data;
offset = mean(imp4_lpf(qq));
imp4_lpf = imp4_lpf - offset;

imp4_res = imp4.Y(5).Data;
offset = mean(imp4_res(qq));
imp4_res = imp4_res - offset;


%%%%%% STER_RESP %%%%%%
step_time = step_resp.X(1).Data;
step_input = step_resp.Y(1).Data;
step_aaf = step_resp.Y(2).Data;
step_hpf = step_resp.Y(3).Data;
step_lpf = step_resp.Y(4).Data;
step_res = step_resp.Y(5).Data;

%%%%% FIRST IMPULSE %%%%%
dt = 0.0001;    % sample period
a1 = sum(imp1_input)*dt;
imp1_input = imp1_input/a1;
imp1_lpf = imp1_lpf/a1;
imp1_hpf = imp1_hpf/a1;
imp1_res = imp1_res/a1;
imp1_aaf = imp1_aaf/a1;

%%%%% SECOND IMPULSE %%%%%
a2 = sum(imp2_input)*dt;
imp2_input = imp2_input/a2;
imp2_lpf = imp2_lpf/a2;
imp2_hpf = imp2_hpf/a2;
imp2_res = imp2_res/a2;
imp2_aaf = imp2_aaf/a2;


%%%%% THIRD IMPULSE %%%%%
a3 = sum(imp3_input)*dt;
imp3_input = imp3_input/a3;
imp3_lpf = imp3_lpf/a3;
imp3_hpf = imp3_hpf/a3;
imp3_res = imp3_res/a3;
imp3_aaf = imp3_aaf/a3;

%%%%% FOURTH IMPULSE %%%%%
a4 = sum(imp4_input)*dt;
imp4_input = imp4_input/a4;
imp4_lpf = imp4_lpf/a4;
imp4_hpf = imp4_hpf/a4;
imp4_res = imp4_res/a4;
imp4_aaf = imp4_aaf/a4;


disp(a1);
disp(a2);
disp(a3);
disp(a4);

%%%%% FIGURE 1 %%%%%
% b = e^2.068
% a = -8.935320869
func1 = 7.908989311*exp(-8.935320869.*(imp1_time));

figure(1)
plot(imp1_time, imp1_lpf); hold on;     % 0.0060
plot(imp1_time, imp3_lpf);              % 0.0062
plot(imp1_time, imp2_lpf);              % 0.0071
plot(imp1_time, imp4_lpf); 
plot(imp1_time, func1); hold off;    % 0.0081
xlim([-0.05 0.2]);
title('FIGURE 1: Experimental Impulse Response for Low-Pass Filter');
xlabel('Time [seconds]');
ylabel('Volts [V]');
legend('Vector 1', 'Vector 3', 'Vector 2', 'Vector 4', 'Analytical Solution');
grid on;

%imp4_lpf_log = log(imp4_lpf);
%figure(2)
%plot(imp4_time, imp4_lpf_log);


figure(2)
plot(imp1_time, imp1_hpf); hold on;
plot(imp1_time, imp3_hpf);
plot(imp1_time, imp2_hpf);
plot(imp1_time, imp4_hpf);
xlim([-0.0001, 0.0011]);
title('FIGURE 2: Experimental Impulse Response for High-Pass Filter');
xlabel('Time [seconds]');
ylabel('Volts [V]');
legend('Vector 1', 'Vector 3', 'Vector 2', 'Vector 4', 'orientation', 'horizontal', 'location', 'southoutside');
grid on;

a2 = -7.76975052;
b2 = exp(-0.264487257);
ab = exp(2.055);

impulse = imp1_input==0;
%impulse = dirac(imp1_time);
func2 = -ab*exp(a2*imp1_time);

figure(3)   %2b
plot(imp1_time, imp1_hpf); hold on;
plot(imp1_time, imp3_hpf);
plot(imp1_time, imp2_hpf);
plot(imp1_time, imp4_hpf);
plot(imp1_time, func2); hold off;
%xlim([-0.1 4]);
%ylim([-12 4]);
title('FIGURE 2B: Experimental Impulse Response for High-Pass Filter');
xlabel('Time [seconds]');
ylabel('Volts [V]');
legend('Vector 1', 'Vector 3', 'Vector 2', 'Vector 4', 'Analytical Solution', 'location', 'eastoutside');
grid on;

%imp3_hpf_log = log(imp3_hpf);
%figure(4)
%plot(imp3_time, imp3_hpf_log);
%xlim([-0.1 4]);
%ylim([-12 4]);

figure(4) % figure 3
plot(imp1_time, imp1_res); hold on;
plot(imp1_time, imp3_res);
plot(imp1_time, imp2_res); 
plot(imp1_time, imp4_res); hold off;
%xlim([-0.01 0.05]);
title('FIGURE 3: Experimental Impulse Response for Resonator');
xlabel('Time [seconds]');
ylabel('Volts [V]');
legend('Vector 1', 'Vector 3', 'Vector 2', 'Vector 4', 'orientation', 'horizontal', 'location', 'southoutside');
grid on;

figure(5) % figure 4
plot(imp1_time, imp1_aaf); hold on;
plot(imp1_time, imp3_aaf);
plot(imp1_time, imp2_aaf); 
plot(imp1_time, imp4_aaf); hold off;
xlim([-0.01 0.05]);
grid on;


%%%%% FIGURES 5A AND 5B %%%%%
% let's plot input 1

figure(6) % figure 5a
plot(imp1_time, imp1_input, '.b');
xlim([-0.0001 0.0011]);
title('FIGURE 5A: Experimental Input for Vector [0 4 6 8 8 8 8 8 6 4 0]');
xlabel('Time [seconds]');
ylabel('Volts [V]');
grid on;

figure(7)  % figure 5b
plot(imp1_time, imp1_hpf, '.b');
xlim([-0.0001 0.0011]);
title({'FIGURE 5B: Experimental Impulse Response for High-Pass Filter', 'Vector [0 4 6 8 8 8 8 8 6 4 0]'});
xlabel('Time [seconds]');
ylabel('Volts [V]');
grid on;

func1_step = 7.908989311*exp(-8.935320869.*(step_time));

%%%%% FIGURE 6-9 %%%%%
figure(8) % figure 6
plot(step_time, step_lpf); %hold on;
%plot(step_time, func1_step); hold off;
title('FIGURE 6: Experimental Step Response of Low-Pass Filter');
xlabel('Time [seconds]');
ylabel('Volts [V]');
grid on;

figure(9)
plot(step_time, step_hpf);
title('FIGURE 7: Experimental Step Response of High-Pass Filter');
xlabel('Time [seconds]');
ylabel('Volts [V]');
grid on;

% resonance at 11.9 Hz
figure(10)
plot(step_time, step_res); hold on;
plot(step_time, exp(-1.38*step_time));
title('FIGURE 8: Experimental Step Response of Resonator');
xlabel('Time [seconds]');
ylabel('Volts [V]');
grid on;

figure(11)
plot(step_time, step_aaf);


figure(12)
plot(step_time, log(step_lpf));
grid on;

figure(13)
plot(step_time, log(step_hpf));
grid on;

figure(14)
plot(step_time, step_input);
grid on;
