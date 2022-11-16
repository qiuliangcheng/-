function xt=xtg(N)
%�ź�x(t)����,����ʾ�źŵķ�Ƶ��������
%xt=xtg(N) ����һ������ΪN,�м��Ը�Ƶ�����ĵ�Ƶ�����ź�xt,����Ƶ��Fs=1000Hz
%�ز�Ƶ��fc=Fs/10=100Hz,�������Ҳ�Ƶ��f0=fc/10=10Hz.
Fs=1000;T=1/Fs;Tp=N*T;
t=0:T:(N-1)*T;
fc=Fs/10;f0=fc/10; %�ز�Ƶ��fc=Fs/10����Ƶ�����ź�Ƶ��Ϊf0=Fc/10;
mt=cos(2*pi*f0*t);  %������Ƶ���Ҳ������ź�mt��Ƶ��Ϊf0
ct=cos(2*pi*fc*t);  %�����ز����Ҳ��ź�ct��Ƶ��Ϊfc
xt=mt.*ct;          %��˲�����Ƶ�����ź�xt
nt=2*rand(1,N)-1;   %�����������nt
%=======��Ƹ�ͨ�˲���hn,�����˳�����nt�еĵ�Ƶ�ɷ�,���ɸ�ͨ����=======
fp=150; fs=200;Rp=0.1;As=70;    % �˲���ָ��
fb=[fp,fs];m=[0,1];           % ����remezord�����������f,m,dev
dev=[10^(-As/20),(10^(Rp/20)-1)/(10^(Rp/20)+1)];
[n,fo,mo,W]=remezord(fb,m,dev,Fs);  % ȷ��remez�����������
hn=remez(n,fo,mo,W);      % ����remez�����������,�����˳�����nt�еĵ�Ƶ�ɷ�
yt=filter(hn,1,10*nt);      %�˳���������е�Ƶ�ɷ֣����ɸ�ͨ����yt
 
%================================================================
xt=xt+yt;           %�������ź�
fst=fft(xt,N);k=0:N-1;f=k/Tp;
figure(1)
subplot(2,1,1);plot(t,xt);grid;
xlabel('t/s');ylabel('x(t)');
axis([0,Tp/5,min(xt),max(xt)]);
title('(1) ���м���������xt')
subplot(2,1,2);plot(f,abs(fst)/max(abs(fst)));grid;
xlabel('f/Hz');ylabel('����')
axis([0,Fs/2,0,1.2]);
title('(2) �ź�xt��Ƶ��')
end