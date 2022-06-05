
clc 
clear 
close all

freq_samp = [1*10^9,4*10^9];           %采样频率
number=2^22;                           %数据量
lw=5000;                               %线宽
data1=wgn(1,number,0)*sqrt(2*pi*lw/freq_samp(1));      %生成高斯白噪声的相位差
freq_delta=data1/2/pi/(1/freq_samp(1));                %生成高斯白噪声的频率波动量
freq_delta1(1) = 0;
for i = 2:length(freq_delta)                            %频率累计
    freq_delta1(i) = freq_delta1(i-1)+freq_delta(i-1);
end

%%% 接下来使用维纳过程求解单边带频率功率谱密度
xcorr_freq_delta=xcorr(freq_delta1);                       %频率波动量自相关
n=nextpow2(length(xcorr_freq_delta));
Nu=2^n;
fspo_ssb =(0:1:-1+Nu/2)*freq_samp(1)/Nu;                     
Yo= abs(fft(xcorr_freq_delta,Nu))/Nu;          
Yo_ssb = [Yo(1),Yo(2:Nu/2).*2];

%%% 使用周期图法求解单边带频率功率谱密度
n=nextpow2(length(freq_delta1));
Nu=2^n;
% fspo =(-Nu/2:1:-1+Nu/2)*freq_samp/Nu;                     %频率单位
fspo1_ssb =(0:-1+Nu/2)*freq_samp(1)/Nu;                     %频率单位
Yo1 = abs(fft(freq_delta1,Nu)).^2/Nu*freq_samp(1);          %功率谱密度
Yo1_ssb = [Yo1(1),Yo1(2:Nu/2).*2];


%%%%%%%%%%%%%%%%%%%%%%%%% 第2个采样率 %%%%%%%%%%%%%%%%%%%%%%%%%%
data1=wgn(1,number,0)*sqrt(2*pi*lw/freq_samp(2));      %生成高斯白噪声的相位差
freq_delta=data1/2/pi/(1/freq_samp(2));                %生成高斯白噪声的频率波动量

freq_delta2(1) = 0;                                    %频率累计
for i = 2:length(freq_delta)
    freq_delta2(i) = freq_delta2(i-1)+freq_delta(i-1);
end
figure
plot(freq_delta2)

%%% 接下来使用维纳过程单边带频率功率谱密度
xcorr_freq_delta=xcorr(freq_delta2);                       %频率波动量自相关
n=nextpow2(length(xcorr_freq_delta));
Nu=2^n;
fspo_ssb_1 =(0:1:-1+Nu/2)*freq_samp(2)/Nu;                     
Yo_1 = abs(fft(xcorr_freq_delta,Nu))/Nu;          
Yo_ssb_1 = [Yo_1(1),Yo_1(2:Nu/2).*2];

%%% 使用周期图法求解单边带频率功率谱密度
n=nextpow2(length(freq_delta2));
Nu=2^n;
% fspo =(-Nu/2:1:-1+Nu/2)*freq_samp/Nu;                     %频率单位
fspo1_ssb_1 =(0:-1+Nu/2)*freq_samp(2)/Nu;                     %频率单位
Yo1_1 = abs(fft(freq_delta2,Nu)).^2/Nu*freq_samp(2);          %功率谱密度
Yo1_ssb_1 = [Yo1_1(1),Yo1_1(2:Nu/2).*2];

% [pxx w] = periodogram(freq_delta);

figure;
plot(log10(fspo_ssb),log10(Yo_ssb));
hold on
plot(log10(fspo1_ssb),log10(Yo1_ssb));
hold on
plot(log10(fspo1_ssb_1),log10(Yo1_ssb_1));
% hold on
% plot(log10(w),log10(pxx));
legend('维纳过程,采样率1G','周期图法,采样率1G','周期图法,采样率4G');
xlabel('以10为底取对数')
ylabel('以10为底取对数')
title('频率功率谱密度');











