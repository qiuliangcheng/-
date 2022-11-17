clear all;
clc;
%�����ź�
Fs = 10000;%���ݲ������������ʸ���10K
ts = 1/Fs;k = 0:4999;
%��Ŀ������Ƶ��
f0 = 1300;f1 = 1600; f2=950;
%��Ŀ�����Ĳ���
A = 2;B1 = 0.8;B2 = 2.8;
fa=0.02;w_0=0;
k1=12000:14800;t = ts*k1;
%�ضϣ���ֻ��T�ڸ�ֵ�����ಹ��
xct = [zeros(1,11999) A*sin(2*pi*f0*t+w_0) zeros(1,10200)];
k2=5000:22000;t = ts*k2;
%�ضϣ���ֻ��T�ڸ�ֵ�����ಹ��
x1nt = [zeros(1,4999) B1*sin(2*pi*f1*t+w_0) zeros(1,3000)];
k3=11200:13600;t = ts*k3;
x2nt = [zeros(1,11199) B2*sin(2*pi*f2*t+w_0) zeros(1,11400)];
nt = normrnd(0,sqrt(fa),1,25000);
%nt=sqrt(fa)*randn(1,25000);
%xt��Ϊ�������������ź�
xt = xct + x1nt +x2nt +nt;
T = 0:24999;
T = T/10000;
figure(1)
subplot(3,1,1)
xlabel('ʱ��t/s');ylabel('����');
plot(T,xt);
title('�������źŷ���');
subplot(3,1,2)
plot(T,xt-nt)
xlabel('ʱ��t/s');ylabel('����');
title('�źŷ���');
subplot(3,1,3)
%�����źŹ�����
nfft = 50000;
[e,f] = xcorr(xt,xt,'unbiased');
CXk1 = fft([e,f],nfft);
Pxx1 = CXk1.*conj(CXk1)/50000;
index = 0:round(nfft/2-1);
k = index*Fs/nfft;
plot_Pxx1 = 10*log10(Pxx1(index+1));
plot(k,plot_Pxx1);
xlabel('f/Hz');
ylabel('�������ܶ�');
title('�����źŹ�����');
%-----ʱƵ�׷���
figure(11)
wlen=512;
hop = wlen/4;
nfft = 512;
win = blackman(wlen);
[S, f, t]=mystft(xt,win,hop,nfft,Fs);
PlotSTFT_2(t,f,S,win);

%%
%�����źŹ�����
%��Բ�˲�����ʵ��
fpl=1290;fpu=1310;fsl=1200;fsu=1400;
wp=[2*fpl/Fs,2*fpu/Fs];
ws=[2*fsl/Fs,2*fsu/Fs];rp=0.5;rs=50;
[N,wp]=ellipord(wp,ws,rp,rs);
disp(N)
[B,A]=ellip(N,rp,rs,wp);
B1=quant(B,0.000001);A1=quant(A,0.000001);
yt=filter(B,A,xt);
figure(2);
subplot(3,1,1);
myplot(B,A);
title('��Բ�˲���')
figure(2);
subplot(3,1,2);
plot(((0:24999)/Fs),yt);
xlabel('t/s');
ylabel('��ֵ');
title('��Բ�˲����ź����ʱ����ͼ')
%�����������
figure(7)
fplot(B,A);hold on;
fplot(B1,A1);
title('��Բ�˲����������');
legend('����ǰ','������')

%����Ϊ����б�ѩ��1�ʹ�ͨ�˲������ڶ���IIR�����˲�����Ʒ�����
rp=0.5;
rs=50;
f1=1290;
f3=1310;
fsl=1200;
fsh=1400;
wp1=2*pi*f1/Fs;
wp3=2*pi*f3/Fs;
wsl=2*pi*fsl/Fs;
wsh=2*pi*fsh/Fs;
wp=[wp1 wp3];
ws=[wsl wsh];
[N,wn]=cheb1ord(wp/pi,ws/pi,rp,rs);
disp(N)
[b,a]=cheby1(N,rp,wp/pi);
b1=quant(b,0.000001);a1=quant(a,0.000001);
figure(8)
fplot(b,a);hold on;
fplot(b1,a1);
title('�б�ѩ���˲����������');
legend('����ǰ','������')
[h,w]=freqz(b,a,256,Fs);
h=20*log10(abs(h));
figure(3);
subplot(3,1,1);
plot(w,h);
xlabel('f/Hz');
ylabel('����/dB');
title('�б�ѩ��1�ʹ�ͨ�˲����Ķ���������Ӧͼ');
grid on;
y1t=filter(b,a,xt);
subplot(3,1,2);
plot(((0:24999)/Fs),y1t);
xlabel('t/s');
ylabel('��ֵ');
title('��ƺ���б�ѩ��1�ʹ�ͨIIR�˲������ʱ����');

%��Բ�˲���������źŹ�����
nfft = 512;
[e,f] = xcorr(yt,yt,'unbiased');
CXk2 = fft([e,f],nfft);
Pxx2 = abs(CXk2);
index = 0:round(nfft/2-1);
k = index*Fs/nfft;
plot_Pxx2 = 10*log10(Pxx2(index+1));
figure(2);
subplot(3,1,3),
plot(k,plot_Pxx2);
title('����Բ�˲����˲����źŹ�����');
xlabel('f/Hz');
ylabel('����/dB'); 
%�б�ѩ���˲�������źŹ�����
nfft = 512;
[e,f] = xcorr(y1t,y1t,'unbiased');
CXk3 = fft([e,f],nfft);
Pxx3 = abs(CXk3);
index = 0:round(nfft/2-1);
k = index*Fs/nfft;
plot_Pxx3 = 10*log10(Pxx3(index+1));
figure(3);
subplot(3,1,3),
plot(k,plot_Pxx3);
title('���б�ѩ���˲����˲�����źŹ���ͼ');
xlabel('f/Hz');
ylabel('����/dB'); 

rp=0.5;rs=50;
f=[1200 1290 1310 1400];
a=[0 1 0];
dev=[10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n1,fo,ao,w]=remezord(f,a,dev,Fs);
b1=remez(n1,fo,ao,w);
y3=fftfilt(b1,xt,5000);
[n2,wn,beta,ftype]=kaiserord(f,a,dev,Fs);
b2 = fir1(n2,wn,'noscale');
y4=fftfilt(b2,xt,5000);
figure(10)
subplot(2,1,1);
stem(b2,'.')
title('���ÿ�����hn��ʱ����');
%title('����kaiserord�˲����ʱ����');
cy4n=xcorr(y4);
Nffty4=2^nextpow2(length(cy4n));
ener4=10*log10(abs(fft(cy4n,Nffty4)));
f4=Fs*linspace(0,1,Nffty4);
subplot(2,1,2)
plot(f4,ener4)
xlim([0,5000])
title('��FIR�˲����˲����źŵĹ�����')
cy3n=xcorr(y3);
Nffty3=2^nextpow2(length(cy3n));
ener3=10*log10(abs(fft(cy3n,Nffty3)));
f3=Fs*linspace(0,1,Nffty3);
figure(4)
subplot(2,1,1)
plot(((0:24999)/Fs),y3)
title('���Ȳ���FIR�˲����˲����ź�ʱ��ͼ');
xlabel('t/s')
ylabel('��ֵ')
subplot(2,1,2)
plot(f3,ener3)
title('��FIR�˲����˲����źŵĹ�����')
xlabel('f/hz')
axis( [0 5000 min(ener3) max(ener3)] )
figure(5)
subplot(2,1,1)
freqz(b1,1,1024,Fs);
title('�Ȳ����˲����ķ�Ƶ����Ƶ����'); 
figure(6)
subplot(2,1,2)
freqz(b2,1,1024,Fs);
title('kaiserord�˲����ķ�Ƶ����Ƶ����'); 



 