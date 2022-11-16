close all; clear all

%����1:����filter���ַ���,��ϵͳ��u(n)����Ӧ�ж��ȶ���
A=[1,-0.9];
B=[0.05,0.05]; %ϵͳ��ַ���ϵ������B��A 
xln=[1 1 1 1 1 1 1 1 zeros(1,50)]; %�����ź�xln=R8n 
x2n=ones(1,128); %�����ź�x2n=un 
hn=impz(B,A,58); %��ϵͳ��λ������Ӧh(n) 
subplot(3,1,1);y='h(n)';
stem(hn,'.');%���ú���tstem��ͼ 
xlabel('n')
ylabel('hn')
title('(1)ϵͳ��λ������Ӧh(n)');
yln=filter(B,A,xln); %��ϵͳ��x1n����Ӧyln 
subplot(3,1,2);
y='y1(n)';stem(yln,'.'); title('(2)ϵͳ��R8(n)����Ӧyl(n)')
xlabel('n');
ylabel('y1n');
y2n=filter(B,A,x2n); %��ϵͳ��x2n����Ӧy2n 
subplot(3,1,3);
y='y2(n)';
stem(y2n,'.'); 
xlabel('n');
ylabel('y2n');
title('(3)ϵͳ��u(n)����Ӧv2(n)')
%=-===-==%����2:����conv����������
x1n=[1 1 1 1 1 1 1 1]; %�����ź�xln=R8n 
hln=[ones(1,10) zeros(1,10)]; h2n=[1 2.5 2.5 1 zeros(1,10)]; y21n=conv(hln,x1n); y22n=conv(h2n,xln);
figure(2)
subplot(2,2,1);stem(hln,'.');%���ú���tstem��ҽ 
title('(1)ϵͳ��λ������Ӧh1(n)')
subplot(2,2,2);stem(y21n,'.'); title('(2)h1(n)��R8(n)�ľ��v21(n)');
xlim([0,25]);ylim([0,8]);
subplot(2,2,3);stem(h2n,'.');%���ú���tstem��ͼ 
ylim([0,3]);title('(3)ϵͳ��λ������Ӧh2(n)')
subplot(2,2,4);stem(y22n,'.'); 
xlim([0,25]);ylim([0,8]);
title('(4)h2(n)��R8(n)�ľ��y22(n)')
%һ======%����3:г��������
un=ones(1,256);%�����ź�ur 
n=0:255;
xsin=sin(0.014*n)+sin(0.4*n); %���������ź�
A=[1,-1.8237,0.9801];
B=[1/100.49,0,-1/100.49];
y31n=filter(B,A,un);
y32n=filter(B,A,xsin);
figure(3);
subplot(2,1,1);
y='y31(n)';
stem(y31n,'.');
title('�����ź�λu(n)ʱ�Ĳ���');
xlim([1,256]);
subplot(2,1,2);
y='y32(n)';
stem(y32n,'.');
title('�����ź�λx(n)ʱ�Ĳ���');xlim([1,256]);