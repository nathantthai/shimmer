clc; clear all
load('shimmerBAGSRTestData.mat','-mat', "shimmerBAData","shimmergsrData","signalNameArrayBA","signalNameArrayGSR");
time = shimmerBAData(:,1);
shimmerBAData_name= [signalNameArrayBA; num2cell(shimmerBAData)];
%%
clc;
%Just using accelerometer in x direction as example here for Low PASS
% quatrotate(shimmerBAData(:,2), shimmerBAData(:,12:15));
filter_d = designfilt('lowpassfir','FilterOrder',10,'CutoffFrequency',.005);
delay_d = mean(grpdelay(filter_d));
accel_x_filtered = filter(filter_d, shimmerBAData(:,2));
zero_d = zeros(delay_d,1);
accel_x_filtered =vertcat(accel_x_filtered,zero_d);
accel_x_filtered = accel_x_filtered(delay_d+1:end,1);

accel_x_filtered(1:14,:)= accel_x_filtered(15,:);%elimminating head artifacts
accel_x_filtered(end-20:end,:)= accel_x_filtered(end-15,:);%elimminating trail artifacts

figure(1)
plot(time, shimmerBAData(:,2), time, accel_x_filtered);

%%
% This is for Magnetometer, eg. using X as example
filter_low_e = designfilt('lowpassfir','FilterOrder',50,'CutoffFrequency',.005);
delay_e = mean(grpdelay(filter_low_e));
mag_x_filtered = filter(filter_low_e, shimmerBAData(:,9));
zero_e = zeros(delay_e,1);
mag_x_filtered =vertcat(mag_x_filtered , zero_e);
mag_x_filtered = mag_x_filtered(delay_e+1:end,1);

mag_x_filtered(1:30,:)= mag_x_filtered(31,:);%elimminating head artifacts
mag_x_filtered(end-30:end,:)= mag_x_filtered(end-35,:);%elimminating trail artifacts

figure(2)
plot(time,shimmerBAData(:,9),time,mag_x_filtered)

%%
clc;
%Just using gyro in x direction as example here for Low PASS
filter_a = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',.3);
delay_a= mean(grpdelay(filter_d));
gyro_x_filtered = filter(filter_a, shimmerBAData(:,6));
zero_a = zeros(delay_d,1);
gyro_x_filtered =vertcat(gyro_x_filtered,zero_a);
gyro_x_filtered = gyro_x_filtered(delay_a+1:end,1);

gyro_x_filtered(1:14,:)= gyro_x_filtered(15,:);%elimminating head artifacts
gyro_x_filtered(end-20:end,:)= gyro_x_filtered(end-15,:);%elimminating trail artifacts

figure(3)
plot(time, shimmerBAData(:,6), time, gyro_x_filtered)

%%
clc;
%Just using accelerometer in x direction as example here for Low PASS
% quatrotate(shimmerBAData(:,2), shimmerBAData(:,12:15));
accel_x_filtered = TVL1denoise(shimmerBAData(:,2), .9, 200);
figure(4)
plot(time, shimmerBAData(:,2), time, accel_x_filtered);