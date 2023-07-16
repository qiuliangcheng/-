%%
%--------------------������(1)-----------------------------------
% ��������
A = 1; % �źŷ���
T = 1; % �ź�����
fs = 1000; % ����Ƶ��
t = (0:1/fs:T-1/fs)'; % ʱ������
wo = 2 * pi * 50; % ��ʼƵ��
dw = 2 * pi * 0.5; % Ƶ�ʲ���
N = 100; % ƥ���˲�������
SNR=-10;
var = A^2 / (2 * 10^(SNR/10));
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
% �����ź�
rand_phase = 2 * pi * rand(); % �����λ
w = wo ;
r=0.1:0.05:10;
o=zeros(length(r),1);
l=zeros(length(r),1);
y=1;
for j=0.1:0.05:10
    A=j;
    o(y)=10 * log10(A^2 / (2*var));
    x = A * sin(w * t+ rand_phase) + n; % �������
    matched_filter_output = zeros(N, 1);
    for i = 0:N-1
        filtered_signal = sin((wo + i * dw) * (T-t));
        matched_filter_output(i + 1) = sum(abs(hilbert(conv(x , filtered_signal))));
    end
% Ƶ�ʹ���
    [max_val, max_idx] = max(matched_filter_output);
    estimated_freq = (wo + (max_idx - 1) * dw) / (2 * pi);
    l(y)=estimated_freq;
    y=y+1;
end
figure
plot(o,l);
title('����������Ƶ��')
xlabel('�����')
ylabel('Ƶ�ʹ���')
%figure
%subplot(311)
%plot(t,x)
%title('�����Ϊ8 Ƶ��Ϊ50hz')
%xlabel('ʱ��')
%ylabel('����')
%subplot(312)
%A=0.01;
%w=2 * pi * 10;
%x = A * sin(w * t+ rand_phase) + n; % �������
%plot(t,x)
%title('�����Ϊ-50 Ƶ��Ϊ10hz')
%xlabel('ʱ��')
%ylabel('����')
%subplot(313)
%A=0.1;
%w=2 * pi * 20;
%x = A * sin(w * t+ rand_phase) + n; % �������
%plot(t,x)
%title('�����Ϊ-30 Ƶ��Ϊ20hz')
%xlabel('ʱ��')
%ylabel('����')
%db=10 * log10(A^2 / (2*var))
% ƥ���˲��������ֵѡ����

% ��ʾ���
disp(['True fs: ', num2str(wo/(2*pi)), ' Hz']);
fprintf('Estimated frequency: %.2f Hz\n', estimated_freq);
%%
%-------------------------�����⣨2��--------------------------------
% ��������   ����ʱ�����

A = 1; % ����
w0 = 2 * pi * 10; % ��Ƶ��
t1 = 0.5; % ����ʱ��
t_min=0.01;
tm=100*t_min;
fs=1000;
dt=1/fs;
T = 5; % �źų���ʱ��
SNR = 10; % ����� (dB)
var = A^2 / (2 * 10^(SNR/10));

t = 0:dt:T-dt;
% ���������λ
m = 2 * pi * rand(1);
% �����ź�
zeros_1s = zeros(1, fs*t1); 
% ��1���0�ź���ӵ��ź�ĩβ
x = cos(w0 * (t - t1) + m);
t=0:dt:T+t1-dt;
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
x = [zeros_1s ,x];
x_noisy = A*x+n;
% figure
% subplot(311)
% plot(t,x_noisy);
% title('����Ϊ1 �����Ϊ 4 ʱ����ʱΪ0.5s')
% xlabel('ʱ��')
% ylabel('����')
% t1=0.1;
% A=0.01;
% SNR=-50;
% zeros_1s = zeros(1, fs*t1); 
% % ��1���0�ź���ӵ��ź�ĩβ
% t = 0:dt:T-dt;
% x = cos(w0 * (t - t1) + m);
% t=0:dt:T+t1-dt;
% x = [zeros_1s ,x];
% n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
% x_noisy = A*x+n;
% subplot(312)
% plot(t,x_noisy);
% title('����Ϊ0.01 �����Ϊ -50 ʱ����ʱΪ0.1s')
% xlabel('ʱ��')
% ylabel('����')
% 
% t1=1;
% A=8;
% SNR=8;
% zeros_1s = zeros(1, fs*t1); 
% % ��1���0�ź���ӵ��ź�ĩβ
% t = 0:dt:T-dt;
% x = cos(w0 * (t - t1) + m);
% t=0:dt:T+t1-dt;
% n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
% x = [zeros_1s ,x];
% x_noisy = A*x+n;
% subplot(313)
% plot(t,x_noisy);
% title('����Ϊ8 �����Ϊ 8 ʱ����ʱΪ1s')
% xlabel('ʱ��')
% ylabel('����')
% ��Ӹ�˹������
r=0.1:0.05:10;
o=zeros(length(r),1);
l=zeros(length(r),1);
e=1;
for j=0.1:0.05:10
    A=j;
    x_noisy = A*x+n;
    o(e)=10 * log10(A^2 / (2*var));
    % ƥ���˲���
    t2=0:dt:T+tm;
    h = sin(w0 * (T+tm-t2));
    % zeros_2s = zeros(1, fs*(T+tm)); 
    % h = [h,zeros_2s];
    %figure
    %subplot(211)
    %plot(t,x_noisy)
    % t2=0:dt:2*(T+tm);
    %subplot(212)
    %plot(t2,h);
    %title('ƥ���˲����ź�')
    y = conv(x_noisy, h);

    %figure
    %plot(y,'b')
    %figure
    % ������
    envelope = abs(hilbert(y));
    m_guji=length(envelope)*(T+t1)/length(x);
    m_guji=0:1/fs:m_guji-1/fs;
    plot(m_guji,envelope,'r')
    % ���Ƶ���ʱ��
    if(SNR>=-10)
        window_size = (tm-t1)*900;  % ���ڴ�С������Ϊ100
        tolerance = 0.0005;  % ������ޣ�����Ϊ2%
        start_idx = 1;  % ��ʼ����������Ϊ1
        window1=0;
        while start_idx + window_size <= length(envelope)
            if(envelope(start_idx)>100)
                window1 = envelope(start_idx : start_idx + window_size - 1);  % ��ȡ��ǰ����
                if abs(window1(end) - window1(1)) / window1(1) <= tolerance  % �жϴ������һ��ֵ���һ��ֵ������Ƿ�С���������
                first_val = window1(1);  % ȡ����һ��ֵ
                break;
                end
            end
            start_idx = start_idx + 1;  % �������һ���1������
        end
    else
        [max1 ,start_idx]=max(envelope);
    end
    res=m_guji(start_idx);
    t1_estimated = res-T;
    l(e)=t1_estimated;
    e=e+1;
end
% �����ʾ
plot(o,l);
title('ʱ�ӹ����������')
xlabel('�����')
ylabel('ʱ�����')

%%
figure;
subplot(2, 1, 1);
plot(t, x_noisy);
title('Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(m_guji, envelope);
title('Envelope of Matched Filter Output');
xlabel('Time (s)');
ylabel('Amplitude');
disp(['True arrival time: ', num2str(t1), ' s']);
disp(['Estimated arrival time: ', num2str(t1_estimated), ' s']);


%%
%Ƶ���뵽��ʱ�乲ͬ����
clear;
clc;
% ��������
A = 1; % �źŷ���
T = 5; % �ź�����
fs = 1000; % ����Ƶ��
t1=0.5;%��ʵ����ʱ��
dt=1/fs;
SNR=-10;%�����
wo = 2 * pi * 10; % ��ʼƵ��
dw = 2 * pi * 0.5; % Ƶ�ʲ���
rand_phase = 2 * pi * rand(); % �����λ
zeros_1s = zeros(1, fs*t1); 
tm=2;
t=0:dt:T-dt;
sig_x = sin(wo * (t-t1)+ rand_phase);
var = A^2 / (2 * 10^(SNR/10));
t=0:dt:T+t1-dt;
n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
N = 100; % ƥ���˲�������

% �����ź�
w = wo ;
sig2_x = [zeros_1s ,sig_x];
x = A*sig2_x + n; % �������
% figure
% subplot(311)
% plot(t,x_noisy);
% title('����Ϊ1 �����Ϊ -10 ʱ����ʱΪ0.5s Ƶ��Ϊ 10Hz')
% xlabel('ʱ��')
% ylabel('����')
% t1=0.1;
% A=0.01;
% SNR=-50;
% wo=2*pi*20;
% zeros_1s = zeros(1, fs*t1); 
% % ��1���0�ź���ӵ��ź�ĩβ
% t = 0:dt:T-dt;
% x=sin(wo * (t-t1)+ rand_phase);
% t=0:dt:T+t1-dt;
% x = [zeros_1s ,x];
% n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
% x_noisy = A*x+n;
% subplot(312)
% plot(t,x_noisy);
% title('����Ϊ0.01 �����Ϊ-50 ʱ����ʱΪ0.1s Ƶ��Ϊ20Hz')
% xlabel('ʱ��')
% ylabel('����')
% t1=1;
% A=8;
% SNR=8;
% wo=50
% zeros_1s = zeros(1, fs*t1); 
% % ��1���0�ź���ӵ��ź�ĩβ
% t = 0:dt:T-dt;
% x=sin(2*pi*wo * (t-t1)+ rand_phase);
% t=0:dt:T+t1-dt;
% n = sqrt(A^2/(2*10^(SNR/10)))*randn(size(t));
% x = [zeros_1s ,x];
% x_noisy = A*x+n;
% subplot(313)
% plot(t,x_noisy);
% title('����Ϊ8 �����Ϊ 8 ʱ����ʱΪ1s Ƶ��Ϊ50Hz')
% xlabel('ʱ��')
% ylabel('����')
A=8;
db=10 * log10(A^2 / (2*var))
x = A*sig2_x + n; % �������
t_esi = (0:1/fs:T+tm-1/fs')'; % ʱ������
% ƥ���˲��������ֵѡ����
matched_filter_output = zeros(N, 1);
for i = 0:N-1
    filtered_signal = sin((wo + i * dw) * (T+tm-t_esi));
    c((i+1),:)=abs(hilbert(conv(x , filtered_signal)));
    matched_filter_output(i + 1) = sum(abs(hilbert(conv(x , filtered_signal))));
end
% Ƶ�ʹ���
[max_val, max_idx] = max(matched_filter_output);
time_esta=c(max_idx,:);
time_guji=length(time_esta)*(T+t1)/length(sig2_x );
time_guji=0:1/fs:time_guji-1/fs;
plot(time_guji,time_esta,'r')
estimated_freq = (wo + (max_idx - 1) * dw) / (2 * pi);
if(SNR>=-10)
    window_size = (tm-t1)*900;  % ���ڴ�С������Ϊ100
    tolerance = 0.0005;  % ������ޣ�����Ϊ2%
    start_idx = 1;  % ��ʼ����������Ϊ1
    window1=0;
    while start_idx + window_size <= length(time_esta)
        if(time_esta(start_idx)>100)
            window1 = time_esta(start_idx : start_idx + window_size - 1);  % ��ȡ��ǰ����
            if abs(window1(end) - window1(1)) / window1(1) <= tolerance  % �жϴ������һ��ֵ���һ��ֵ������Ƿ�С���������
            first_val = window1(1);  % ȡ����һ��ֵ
            break;
            end
        end
        start_idx = start_idx + 1;  % �������һ���1������
    end
else
    [max1 ,start_idx]=max(time_esta);
end
res=time_guji(start_idx);
t1_estimated = res-T;
% ��ʾ���
disp(['True fs: ', num2str(wo/(2*pi)), ' Hz']);
fprintf('Estimated frequency: %.2f Hz\n', estimated_freq);
disp(['True arrival time: ', num2str(t1), ' s']);
disp(['Estimated arrival time: ', num2str(t1_estimated), ' s']);