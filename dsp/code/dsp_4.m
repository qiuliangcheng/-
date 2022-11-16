
%ʵ����--��һ��
%%
clear all;clc;

N=1600;   %NΪ�ź�st�ĳ��ȡ�
Fs=10000;T=1/Fs;Tp=N*T; %����Ƶ��Fs=10kHz��TpΪ����ʱ��
t=0:T:(N-1)*T;k=0:N-1;f=k/Tp;
fc1=Fs/40;      %��1·�����źŵ��ز�Ƶ��fc1=250Hz,
fm1=fc1/5;      %��1·�����źŵĵ����ź�Ƶ��fm1=50Hz
fc2=Fs/20;      %��2·�����źŵ��ز�Ƶ��fc2=500Hz
fm2=fc2/5;      %��2·�����źŵĵ����ź�Ƶ��fm2=50Hz
fc3=Fs/10;      %��3·�����źŵ��ز�Ƶ��fc3=1000Hz,
fm3=fc3/5;      %��3·�����źŵĵ����ź�Ƶ��fm3=25Hz
xt1=cos(2*pi*fm1*t).*cos(2*pi*fc1*t); %������1·�����ź�
xt2=cos(2*pi*fm2*t).*cos(2*pi*fc2*t); %������2·�����ź�
xt3=cos(2*pi*fm3*t).*cos(2*pi*fc3*t); %������3·�����ź�
st=xt1+xt2+xt3;         %��·�����ź����
fxt=fft(st,N);          %�����ź�st��Ƶ��
%====����Ϊ��ͼ���֣�����st��ʱ���κͷ�Ƶ��������====================
subplot(2,1,1)
plot(t,st);grid;xlabel('t/s');ylabel('s(t)');
axis([0,Tp/8,min(st),max(st)]);title('(a) s(t)�Ĳ���')
subplot(2,1,2)
stem(f,abs(fxt)/max(abs(fxt)),'.');grid;title('(b) s(t)��Ƶ��')
axis([0,Fs/5,0,1.2]);
xlabel('f/Hz');ylabel('����')


%%
%ʵ����--�ڶ���
clear all;clc; 
%IIR�����˲��������
Fs=10000;T=1/Fs;   %����Ƶ��
%�����źŲ�������mstg��������·�����ز������ź���ӹ��ɵĸ����ź�st 
st=mstg;
%��ͨ�˲��������ʵ��
fp=280;fs=450;
wp=2*fp/Fs;ws=2*fs/Fs;rp=0.1;rs=60;   %DFָ�꣨��ͨ�˲�����ͨ������߽�Ƶ��
[N,wp]=ellipord(wp,ws,rp,rs);         %����ellipord������ԲDF����N��ͨ����ֹƵ��wp
[B,A]=ellip(N,rp,rs,wp);              %����ellip������Բ��ͨDFϵͳ����ϵ������B��A
y1t=filter(B,A,st);                   %�˲��������ʵ�� 
%��ͨ�˲��������ʵ�ֵĻ�ͼ����
figure(2);
subplot(3,2,1);myplot(B,A);     %���û�ͼ����myplot������ĺ�������
title('��ͨ�˲�����ĺ�������');
yt='y_1(t)';
subplot(3,2,2);tplot(y1t,T,yt); %���û�ͼ����tplot�����˲����������
title('��ͨ�˲��������y1t����');
%��ͨ�˲��������ʵ��
fpl=440;fpu=560;fsl=275;fsu=900;
wp=[2*fpl/Fs,2*fpu/Fs];ws=[2*fsl/Fs,2*fsu/Fs];rp=0.1;rs=60; %DFָ�꣨��ͨ�˲�����ͨ������߽�Ƶ��,wpΪ3db�Ľ�ֹƵ��
[N,wp]=ellipord(wp,ws,rp,rs);    %����ellipord������ԲDF����N��ͨ��3db��ֹƵ��wp
[B,A]=ellip(N,rp,rs,wp);         %����ellip������Բ��ͨDFϵͳ����ϵ������B��A
y2t=filter(B,A,st);              %�˲������ʵ��
%��ͨ�˲��������ʵ�ֻ�ͼ����
figure(2);
subplot(3,2,3);myplot(B,A);     %���û�ͼ����myplot������ĺ�������
title('��ͨ�˲�����ĺ�������');
yt='y_2(t)';
subplot(3,2,4);tplot(y2t,T,yt); %���û�ͼ����tplot�����˲����������
title('��ͨ�˲��������y2t����');
%��ͨ�˲��������ʵ��
fp=890;fs=600;
wp=2*fp/Fs;ws=2*fs/Fs;rp=0.1;rs=60;   %DFָ�꣨��ͨ�˲�����ͨ������߽�Ƶ��
[N,wp]=ellipord(wp,ws,rp,rs);         %����ellipord������ԲDF����N��ͨ����ֹƵ��wp
[B,A]=ellip(N,rp,rs,wp,'high');       %����ellip������Բ��ͨDFϵͳ����ϵ������B��A
y3t=filter(B,A,st);                   %�˲������ʵ��
%�ߵ�ͨ�˲��������ʵ�ֻ�ͼ����
figure(2);
subplot(3,2,5);myplot(B,A);     %���û�ͼ����myplot������ĺ�������
title('��ͨ�˲�����ĺ�������');
yt='y_3(t)';
subplot(3,2,6);tplot(y3t,T,yt); %���û�ͼ����tplot�����˲����������
title('��ͨ�˲��������y3t����');


