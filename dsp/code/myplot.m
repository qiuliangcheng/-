function myplot(B,A)
%ʱ����ɢϵͳ��ĺ�����ͼ
%BΪϵͳ�������Ӷ���ʽϵ������
%AΪϵͳ������ĸ����ʽϵ������
[H,W]=freqz(B,A,1000);  %freqz��������������ɢϵͳƵ����Ӧ����
m=abs(H);        %ȡ����ֵʵ��
plot(W/pi,20*log10(m/max(m)));grid on;
xlabel('\omega/\pi');ylabel('���ȣ�dB��')
axis([0,1,-80,5]);
end