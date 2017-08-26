function ex20_1
%************************************
%���һά�ȴ���ƫ΢�ַ��̵�һ���ۺϺ�������
%************************************
m=0;
x=linspace(0,1,20); %xmesh
t=linspace(0,2,20); %tspan
%************
%�� pde ���
%************
sol=pdepe(m,@ex20_1pdefun,@ex20_1ic,@ex20_1bc,x,t);
u=sol(:,:,1); %ȡ����
%************
%��ͼ���
%************
figure(1)
surf(x,t,u)
title('pde ��ֵ��')
xlabel('λ�� x')
ylabel('ʱ�� t' )
zlabel('��ֵ�� u')
%*************
%����������Ƚ�
%*************
figure(2)
surf(x,t,exp(-t)'*sin(pi*x));
title('������')
xlabel('λ�� z')
ylabel('ʱ�� t' )
zlabel('��ֵ�� u')
%*****************
%t=tf=2 ʱ��λ��֮��
%*****************
figure(3)
M=length(t); %ȡ�յ�ʱ����±�
xout=linspace(0,1,100); %�����λ��
[uout,dudx]=pdeval(m,x,u(M,:),xout);
plot(xout,uout); %��ͼ
title('ʱ��Ϊ 2 ʱ,��λ���µĽ�')
xlabel('x')
ylabel('u')
%******************
%pde ����
%******************
function [c,f,s]=ex20_1pdefun(x,t,u,dudx)
c=pi^2;
f=dudx;
s=0;
%******************

%��ʼ��������
%******************
function u0=ex20_1ic(x)
u0=sin(pi*x);
%******************
%�߽���������
%******************
function [pl,ql,pr,qr]=ex20_1bc(xl,ul,xr,ur,t)
pl=ul;
ql=0;
pr=pi*exp(-t);
qr=1;