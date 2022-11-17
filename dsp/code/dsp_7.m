clc;
clear;
%------------��������Ƶ�ʵ��ź�------------
N=1000;FS=2000;
T=1/FS;Tp=N*T;t=0:T:(N-1)*T;k=0:N-1;f=k/Tp;
f1=100;f2=500;f3=800;
y1=cos(2*pi*f1*t);
y2=cos(2*pi*f2*t);
y3=cos(2*pi*f3*t);
y=y1+y2+y3;
F=fft(y,N);
subplot(2,1,1);
plot(t,y);
title('�����ź�Y�Ĳ���');grid;
xlabel('t'); ylabel('y'); 
xlim([0,Tp/10])
subplot(2,1,2);
stem(f,abs(F)/max(abs(F)),'.');
title('y��Ƶ��');grid;
xlabel('f/Hz'); ylabel('����'); 
xlim([0,1000]);
%---------���һ����ͨ�˲���-----------
fp=120;fs=460;wp=2*fp*T;ws=2*fs*T;
wc=(ws+wp)/2;
ND=50;
f=FS/N*k;
hn=fir1(ND-1,wc,blackman(ND));
figure(2);
subplot(2,1,1)
plot(hn);
title('��ͨ�˲���h(n)�Ĳ���');grid;
xlabel('n'); ylabel('hn'); 
subplot(2,1,2)
HW=fft(hn,N);
plot(f,20*log10(abs(HW)/max(abs(HW))));
title('��ͨ�˲���h(n)��Ƶ��������');grid;
xlabel('f/Hz'); ylabel('|H(jw)|'); 
axis([0,1000,-100,5]);
%-------------�˳�800HZ��Ƶ��------------
fp=520;fs=740;wp=2*fp/FS;ws=2*fs/FS;wc=(wp+ws)/2;
Nd=50;
hn2=fir1(Nd-1,wc,blackman(Nd));
k=0:N-1;f=FS/N*k;
Hw=fft(hn2,N);%�˵�ͨ�˲�����Ƶ��
figure(3);
subplot(2,1,1); plot(hn2);title('��ͨ�˲���h2(n)�Ĳ���');grid;
xlabel('n'); ylabel('h2(n)'); axis auto normal;
subplot(2,1,2); plot(f,20*log10(abs(Hw)/max(abs(Hw))));
title('��ͨ�˲���h2(n)��Ƶ��������');grid;
xlabel('f/Hz'); ylabel('|H(jw)|'); axis([0,1000,-100,5]);
%-----------�����ص����������ص���ӷ����о������------------
y1=add(y,hn);
y2=over_save(y,hn2);
N=length(y1);
YK1=fft(y1,N);
YK2=fft(y2,N);
Fs=2000;T=1/Fs;Tp=N*T;
t=0:T:(N-1)*T;k=0:N-1;f=k/Tp;
figure(4)
subplot(2,1,1);stem(f,abs(YK1)/max(abs(YK1)),'.');
title('�ص���ӷ�����y1(t)��Ƶ��');
xlabel('f/Hz'); ylabel('����');axis([0,600,0,1]);grid;
subplot(2,1,2);stem(f,abs(YK2)/max(abs(YK2)),'.');
xlim([0,1000]);xlabel('f/Hz'); ylabel('����');
title('�ص�����������y2(t)��Ƶ��');



