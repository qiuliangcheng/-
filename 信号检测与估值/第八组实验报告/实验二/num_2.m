
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
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(sig_1));
sig_2 = sig_1 + n;%�ź�+����
mf_1 = (fliplr(sig_1));
figure
plot(mf_1);
delay_sec = T+T;
% ʹ�� circshift ��������ʱ�� y ����
delay_samples = round(delay_sec * fs); 
mf= circshift(mf_1 , [-1, -delay_samples]);
% ����ʱ�ƺ�� y ����
t_delay = t-delay_samples/fs;
% ƥ���˲����ĳ弤��Ӧ
figure(3);
subplot(2,1,1);
plot(t,sig_1)
title('ԭ�ź�')
xlabel('time/s')
ylabel('����')
subplot(2,1,2);
plot(t_delay,mf);
title('MFʱ��ͼ')
xlabel('time/s')
ylabel('����')
% subplot(2,1,2);
% plot(t,sig_2);
% title('�����������ź�')
N = length(mf);
MF = fft(mf, N);
%�˲�������
SNR = -15;%�����
f = 5e3;%�ź�Ƶ��
A = 1;%�ź����
t = 0:1/fs:T-1/fs;%ʱ������
sig_w = A*sin(2*pi*f*t);%��Ƶ�ź�
% ����1���0�ź�
zeros_1s = zeros(1, fs*T);
sig_w_cha=[sig_w, zeros_1s];
figure
plot(sig_w_cha)
wres=conv(sig_w_cha,mf);
t = 0:1/fs:T+T-1/fs;
Tw=T+T;
m=length(wres)*Tw/(length(sig_w_cha ));
m=0:1/fs:m-1/fs;
figure
plot(m,wres)
title('Ƶ��ͨ��ƥ���˲���')
% ��1���0�ź���ӵ��ź�ĩβ
%��ʱ
delay_times=0.05;
zeros_delays = zeros(1, delay_times*fs); 
sig_1_delay = [zeros_delays ,sig, zeros_1s];
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(sig_1_delay));
sig_2_delay = sig_1_delay;
t_dealy = 0:1/fs:T+T+delay_times-1/fs;
T_delay=T+T+delay_times;
delay_final_res=conv(sig_2_delay,mf);
m=length(delay_final_res)*T_delay/(length(sig_2_delay ));
m=0:1/fs:m-1/fs;
figure
subplot(3,1,1)
plot(t,sig_1);
title('û����ʱ���ź�')
subplot(3,1,2)
plot(t_dealy,sig_2_delay);
title('��ʱ�ź�')
xlabel('time/s')
ylabel('����')
subplot(3,1,3)
plot(m,delay_final_res)
title('��ʱ�ź�ͨ��ƥ���˲���')
xlabel('time/s')
ylabel('����')
%�����ź�
final_res=conv(sig_2,mf);
m_ori=length(final_res)*T/length(sig);
m_ori=0:1/fs:m_ori-1/fs;
frequencies = -fs/2:fs/length(mf):fs/2-fs/length(mf); % Ƶ������
amplitudes = abs(MF); % ��������
figure;
subplot(2,1,1)
plot(frequencies, amplitudes);
xlim([0 fs/2-fs/length(mf)])
xlabel('Ƶ�� (Hz)');
ylabel('����');
title('ƥ���˲���Ƶ����Ӧ');
subplot(2,1,2);
plot(m_ori,final_res);
title('�����-20DB�ź�ͨ��ƥ���˲���')
xlabel('time/s')
ylabel('����')