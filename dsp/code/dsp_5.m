%ʵ����--��һ��
close all;clc;
%FIR�����˲��������ʵ�� 
%���� xtg �����ź� xt, xt ���� N=1000,����ʾ xt ����Ƶ��
N=1000;xt=xtg(N);
fp=120; fs=150;Rp=0.1;As=60;Fs=1000;    %�������ָ��
%(1)�ô�����������˲���
wc=(fp+fs)/Fs;      %�����ͨ�˲�����ֹƵ��(����pi��һ����
B=2*pi*(fs-fp)/Fs;  %���ɴ����ָ��
Nb=ceil(11*pi/B);   %blackman���ĳ���N
hn=fir1(Nb-1,wc,blackman(Nb));
Hw=abs(fft(hn,1024));   % ����Ƶ��˲���Ƶ������
ywt=fftfilt(hn,xt,N);   %���ú���fftfilt��xt�˲�
%����������Ʒ��Ļ�ͼ���֣��˲�����ĺ������˲�������źŲ��Σ�
f=[0:1023]*Fs/1024;
figure(2)
subplot(2,1,1)
plot(f,20*log10(Hw/max(Hw)));grid;
title('(3) ��������ͨ�˲�����Ƶ����')
xlabel('f/HZ');ylabel('����');
axis([0,Fs/2,-120,20]);
t=[0:N-1]/Fs;Tp=N/Fs; 
subplot(2,1,2)
plot(t,ywt);grid;
axis([0,Tp/2,-1,1]);
xlabel('t/s');ylabel('y_w(t)');
title('(4) �˲���������źŲ���') 
%(2)�õȲ�����ѱƽ�������˲���
fb=[fp,fs];m=[1,0];         % ȷ��remezord�����������f,m,dev
dev=[(10^(Rp/20)-1)/(10^(Rp/20)+1),10^(-As/20)];
[Ne,fo,mo,W]=remezord(fb,m,dev,Fs); % ȷ��remez�����������
hn=remez(Ne,fo,mo,W);       % ����remez�����������
Hw=abs(fft(hn,1024));       % ����Ƶ��˲���Ƶ������
yet=fftfilt(hn,xt,N);       % ���ú���fftfilt��xt�˲�
%�Ȳ�����Ʒ��Ļ�ͼ���֣��˲�����ĺ������˲�������ź�yw(nT)���Σ�
f=[0:1023]*Fs/1024;
figure(3)
subplot(2,1,1)
plot(f,20*log10(Hw/max(Hw)));grid;
title('(5) �Ȳ�����ѱƽ���ͨ�˲�����Ƶ����')
axis([0,Fs/2,-80,10]);
xlabel('f/HZ');ylabel('����')
t=[0:N-1]/Fs;Tp=N/Fs; 
subplot(2,1,2);plot(t,yet);grid;
axis([0,Tp/2,-1,1]);
xlabel('t/s');ylabel('y_e(t)');
title('(6) �˲���������źŲ���') 
