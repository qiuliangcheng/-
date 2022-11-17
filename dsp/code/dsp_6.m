clear all;close all;
%%
fs = 1000;    %����Ƶ��
f1 = 100;   %ϸ����ʼƵ��
f2 = 200;  %ϸ������Ƶ��
ND=50'
wp=2*f1/fs;ws=2*f2/fs;
wc=(wp+ws)/2;
h=fir1(ND-1,wc,blackman(ND));
% d = designfilt('lowpassfir','PassbandFrequency',0.25, ...
%          'StopbandFrequency',0.35,'PassbandRipple',0.5, ...
%          'StopbandAttenuation',65,'DesignMethod','kaiserwin');
% h = tf(d);   %ϵͳ���ݺ���
m = 1024;    %�任����
y = fft(h,m);  % ֱ��FFT���

w = exp(-1j*2*pi*(f2-f1)/(m*fs));   %����������֮��ı�ֵ
a = exp(1j*2*pi*f1/fs);             %�����������
z = czt(h,m,w,a);                   %CZT�任
fn = (0:m-1)'/m;
fy = fs*fn;                         %Ƶ��
fz = (f2-f1)*fn + f1;
figure(1);
subplot(2,1,1)
plot(fy,abs(y))
xlim([0 500])
legend('FFT')
subplot(2,1,2)
plot(fz,abs(z),'b')
xlim([100 200])
legend('CZT')
xlabel('Frequency (Hz)')
grid on;
figure(2);
plot(fy,abs(y),'r-*',fz,abs(z),'b')
xlim([100 200])
legend('FFT','CZT')
xlabel('Frequency (Hz)')
grid on;
%%
%---------�ڶ���--------------
A0=0.6;W_0=1.2;a_0=pi/3;w_0=2*pi/100;
A=A0*exp(1i*a_0);W=W_0*exp(-1i*w_0);
N=8;M=64;L=128;%��������ָ��
k=0:0.001:M-1;
zk=A.*W.^(-1j*k);
n=0:7;xn=ones(1,8);
A1=power(A,-n);W1=power(W,n.*n/2);
yn1=xn.*A1.*W1;yn=[yn1,zeros(1,L-N)];
yk=fft(yn);%����y(n)���в�����Ƶ�׷���
n=0:M-1;W2=power(W,-n.*n/2);
n=M:L-1;W3=W.^(-(L-n).*(L-n)/2);
hn=[W2,W3];hk=fft(hn);%����h(n)���в�����Ƶ�׷���
mk=ifft(yk.*hk);%����v��k������
k=0:L-1;
Wk=W.^(k.^2/2);
k=0;
while(k<M)
    Xzk(k+1)=mk(k+1)*Wk(k+1);
    k=k+1;
end
figure(1)
subplot(1,1,1);stem(abs(mk),'.');axis auto normal;
title('����m(k)����ͼ');xlabel('k');ylabel('m(k)');
figure(2)
subplot(2,1,1),stem(abs(Xzk),'.');axis auto;
title('XzkƵ��ͼ');xlabel('k');ylabel('|Xzk|');
subplot(2,1,2),stem(20*log10(abs(Xzk)/max(abs(Xzk))),'.');
title('X(zk)�ֱ�ֵ');xlabel('k');axis auto;
ylabel('dB');
figure(3)
polar(angle(zk),abs(zk),'b');