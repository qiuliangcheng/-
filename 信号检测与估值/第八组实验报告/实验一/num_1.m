fs = 48e3;%����Ƶ��
T = 0.05;%�ź�ʱ��
SNR = -15;%�����
f = 15e3;%�ź�Ƶ��
A = 1;%�ź����
t = 0:1/fs:T-1/fs;%ʱ������
sig = A*sin(2*pi*f*t);%��Ƶ�ź�
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(sig));%��˹������
% ����1���0�ź�
zeros_1s = zeros(1, fs*T); 
% ��1���0�ź���ӵ��ź�ĩβ
sig_1 = [sig, zeros_1s];
t = 0:1/fs:T+T-1/fs;%ʱ������
figure
plot(t,sig_1);
xlabel('time/s')
ylabel('����')
title('fs =200k f=15k')
ylim([-1.5 1.5])
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(sig_1));
sig_2 = sig_1 + n;
figure
t = 0:1/fs:T+T-1/fs;%ʱ������
plot(t,sig_2);
title('�źż�����');
writeRAF(sig_1,'50',1,fs,0);%�������źŸ�Ϊ.raf��ʽ�ļ��������ڴ洢�豸��Ŀ¼��,.raf��ʽ�ļ���Ϊ���ֻ���ĸ
% ����Ƶ��ͼ
N = length(sig_1);
Y=fft(sig_1)/N;
frequencies = fs*(0:(N/2))/N;% Ƶ������
P2 = abs(Y); % ��������
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
figure;
plot(frequencies, P1);
xlabel('Ƶ�� (Hz)');
ylabel('����');
title('50K�����ź�Ƶ��ͼ');%���Ըı����Ƶ�ʻ���