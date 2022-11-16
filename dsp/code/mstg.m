function st=mstg
%�����ź���������st,����ʾst��ʱ���κ�Ƶ��
%st=mstg ������·�����ź�����γɵĻ���źţ�����N=2000
N=2000;             %NΪ�ź�st�ĳ��ȡ�
Fs=10000;T=1/Fs;Tp=N*T; %����Ƶ��Fs=10kHz��TpΪ����ʱ��
t=0:T:(N-1)*T;k=0:N-1;f=k/Tp;
fc1=Fs/40;      %��1·�����źŵ��ز�Ƶ��fc1=1000Hz,
fm1=fc1/5;      %��1·�����źŵĵ����ź�Ƶ��fm1=100Hz
fc2=Fs/20;      %��2·�����źŵ��ز�Ƶ��fc2=500Hz
fm2=fc2/5;      %��2·�����źŵĵ����ź�Ƶ��fm2=50Hz
fc3=Fs/10;      %��3·�����źŵ��ز�Ƶ��fc3=250Hz,
fm3=fc3/5;      %��3·�����źŵĵ����ź�Ƶ��fm3=25Hz
xt1=cos(2*pi*fm1*t).*cos(2*pi*fc1*t); %������1·�����ź�
xt2=cos(2*pi*fm2*t).*cos(2*pi*fc2*t); %������2·�����ź�
xt3=cos(2*pi*fm3*t).*cos(2*pi*fc3*t); %������3·�����ź�
st=xt1+xt2+xt3;         %��·�����ź����
fxt=fft(st,N);          %�����ź�st��Ƶ��
%����Ϊ��ͼ���֣�����st��ʱ���κͷ�Ƶ��������
figure(1)
subplot(2,1,1);plot(t,st);grid;
xlabel('t/s');ylabel('s(t)');
title('(a) s(t)�Ĳ���')
axis([0,Tp/8,min(st),max(st)]);
subplot(2,1,2)
stem(f,abs(fxt)/max(abs(fxt)),'.');grid;
xlabel('f/Hz');ylabel('����')
title('(b) s(t)��Ƶ��')
axis([0,Fs/5,0,1.2]);
figure(2)
subplot(3,1,1)
plot(xt1);
subplot(3,1,2)
plot(xt2);
subplot(3,1,3)
plot(xt3);
