x =linspace(0,1,20); %x ȡ 20 ��
t=linspace(0,2,5); %ʱ��ȡ 5 �����
m=0; %������ 1 ֮���
sol=pdepe(m,@ex20_1pdefun,@ex20_1ic,@ex20_1bc,x,t);
% ���� 7 ��ʾ�����
u=sol(:,:,1);
surf(x,t,u)
title('pde ��ֵ��')
xlabel('λ��')
ylabel('ʱ��' )
zlabel('u')

figure(2); %���ͼ 2
M=length(t); %ȡ�յ�ʱ����±�
xout=linspace(0,1,100); %�����λ��
[uout,dudx]=pdeval(m,x,u(M,:),xout);
plot(xout,uout); %��ͼ
title('ʱ��Ϊ 2 ʱ,��λ���µĽ�')
xlabel('x')
ylabel('u')