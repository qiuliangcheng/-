%%
%��ı�����ȡ���ֵ������޸ı�
clear all ;
clc
close all
fs = 48e3;%����Ƶ��
T = 0.05;%�ź�ʱ��
f = 15e3;%�ź�Ƶ��
A = 1;%�ź����
t = 0:1/fs:T-1/fs;%ʱ������
sig = sin(2*pi*f*t);%��Ƶ�ź�
% ����1���0�ź�
zeros_1s = zeros(1, fs*T); 

sig_1 = [sig];
n = randn(1,length(sig_1));
var1 = var(n);
A=0.01;
db=10 * log10(A^2 / (2*var1))
x2=A*sig_1+n;
x1=A*sig_1+n;
res_up=0;
res_down=0;
%----------�����Ȼ���--------------
for i=1:length(sig_1)-1
    m= x1(i)*sig_1(i);
    res_up=res_up+m;
    res_down=res_down+(sig_1(i))^2;
end
disp('�����Ȼ���Ƶķ�ֵ��')
A_mml=res_up/res_down
disp('�����Ȼ������ޣ�')
gangma=(2*var1*log(1)*res_down)^0.5
disp('�����Ȼ�������')
res_design=abs(res_up)
%----------person���--------------
G=0;
a=0.1
y=1;
p1=0.3;p2=0.7;
es=sig_1*sig_1';
G=abs(x1*sig_1')
%door=abs(norminv(1-0.5*a,0,(var*res_down)^0.5))
y=y+1;
N=10e3;
len=length(0.005:0.0005:0.1);
o1=zeros(N*p1,len);
o2=zeros(N*p2,len);
for i=0.005:0.0005:0.1
%     A=i;
%     db=10 * log10(A^2 / (2*var));
%     q(y)=db;
%     x1=A*sig_1+n;
    %disp('person�������')
    %p(y)=G;
    a=i;%�ı��龯����
    q(y)=a;
    %disp(['person�龯���ʣ�', num2str(a)]);
    %door_before=normcdf(1-a/2);
    %disp('person������ޣ�')
    door=abs(norminv(1-0.5*a,0,(var1*res_down)^0.5));
    for l=1:N*p1
        
        %var = A_small^2 / (2 * 10^(SNR/10));
        n = randn(1,length(sig_1));
        M=0.1432*sig_1+n;%��֤�����Ϊ-20
        G=abs(M*sig_1');
        if (G>door)
            o1(l,y)=1;
        else
            o1(l,y)=0;
        end
    end
    for l=1:N*p2
        n = randn(1,length(sig_1));
        M=n;
        G=abs(M*sig_1');
        if (G<door)
            o2(l,y)=1;
        else
            o2(l,y)=0;
        end
    end
    w(y)=door;
    y=y+1;
end
row_sums = sum(o1, 1);
row_sums1 = sum(o2, 1);
% pre=(row_sums+row_sums1)./N;
pre=(row_sums)./N;
figure
plot(q,pre);
xlim([0.005 0.1])
title('�龯���ʶ�׼ȷ�ʵ�Ӱ��')
xlabel('�龯����')
ylabel('׼ȷ��')
figure
plot(q,w)
xlim([0.005 0.1])
title('�ı��龯������ȡ����')
xlabel('�龯����')
ylabel('����ֵ')
%�ı��������֤����ȶԼ������Ӱ��
N=10e3;
y=1;
a=0.1;
j=0.1:0.05:10;
len=length(j);
o1=zeros(N*p1,len);
o2=zeros(N*p2,len);
door=abs(norminv(1-0.5*a,0,(var1*res_down)^0.5));
for j=0.1:0.05:10
    A=j;
    db_1=10 * log10(A^2 / (2*var1));
    p(y)=db_1;
    for l=1:N*p1
        n = randn(1,length(sig_1));
        M=A*sig_1+n;
        G=abs(M*sig_1');
        if (G>door)
            o1(l,y)=1;
        else
            o1(l,y)=0;
        end
    end
    for l=1:N*p2
        n = randn(1,length(sig_1));
        M=n;
        G=abs(M*sig_1');
        if (G<door)
            o2(l,y)=1;
        else
            o2(l,y)=0;
        end
    end
    y=y+1;
end
row_sums = sum(o1, 1);
row_sums_1 = sum(o2, 1);
pre=(row_sums)./N;
figure
plot(p,pre);
title('��ͬ�������Ƥ��ѷ�ļ��׼ȷ��')
xlabel('�����')
ylabel('׼ȷ��')
%%
%��֤׼����Խ��
clear all
T = 0.05;Fs = 50e3;N = Fs*T;f = 2*pi*10e3;SNR = -20;
t = 0:T/(N-1):T;
% zeros_1s = zeros(1, Fs*T); 
st_p = sin(f*t);%��������Ϊһ����֪�źţ��ں���ļ���ͳ�����е�st��������
% st_p =[st_p,zeros_1s]
Es_p1 = (st_p*st_p');  %��ֵΪһ���źŵ���������ͨ������ȼ����ֵA�������ڼ������ͳ���������ϵĵĸ��ʷֲ�ʱҪ����
nt_p = randn(1,length(st_p));
En = (nt_p*nt_p');

Es_pA = En*10^(0.1*SNR);
A = (Es_pA/Es_p1)^0.5;
st = A*st_p;
P0 = 0.7;P1 = 0.3;C00 = 0.01;C11 = 0.01;C01 = 20; C10 = 20;
lamada0 = P0/P1*(C10-C00)/(C01-C11);
lamada1 = P0/P1;
PF = 1e-1;
% �Ա������о�׼��
M2 = 10e4;
nt = randn(1,length(st));
%lamada2 = abs(norminv(1-0.5*PF,0,(var(nt)*Es_p1)^0.5))
a1_sum = zeros(4,M2);
for a1 = 1:ceil(M2*P1)
    nt = randn(1,length(st));
    lamada2 = abs(norminv(1-0.5*PF,0,(var(nt)*Es_p1)^0.5));
    lamada00 = abs((2*var(nt)*log(lamada0)*Es_p1)^0.5);    
    lamada11 = abs((2*var(nt)*log(lamada1)*Es_p1)^0.5);
    lamada21 = 0;
    xt = st+nt;
    G = abs(xt*st_p');
    if G >= lamada2
        a1_sum(1,a1) = 1;
    end
    if G >= lamada11
        a1_sum(2,a1) = 1;
    end
    if G >= lamada00
        a1_sum(3,a1) = 1;
    end
     if G > lamada21
        a1_sum(4,a1) = 1;
    end
end
for a1 = ceil(M2*P1)+1:M2
    nt = randn(1,length(st));
    lamada2 = norminv(1-0.5*PF,0,(var(nt)*Es_p1)^0.5);
    lamada00 = abs((2*var(nt)*log(lamada0)*Es_p1)^0.5);    
    lamada11 = abs((2*var(nt)*log(lamada1)*Es_p1)^0.5);
    lamada21 = 0;
    xt = nt;
    G = abs(xt*st_p');
    if G < lamada2
        a1_sum(1,a1) = 1;
    end
    if G < lamada11
        a1_sum(2,a1) = 1;
    end
    if G < lamada00
        a1_sum(3,a1) = 1;
    end
    if G <= lamada21
        a1_sum(4,a1) = 1;
    end
end
res = sum(a1_sum,2);
figure(2)
% name = categorical({'��Ҷ˹׼��','��С�������׼��','N-P׼��'});
bar(res/M2',0.3);
name={'N-P׼��','��С�������׼��','��Ҷ˹׼��','�����Ȼ'};
grid on;
title(['��������ȵ���-20dB�����µ�ʵ����,P0=',num2str(P0),'��P1=',num2str(P1)])
ylabel('�ɹ�������')
set(gca, 'XTickLabel', name)