function [c,f,s] = pdefun(z,t,u,dudx)
% ƫ΢�ַ��̵�ϵ������������
    c_water = 4.2;
    % ˮ�ı����ݣ��������ڱ�׼����ѹ�µģ�ˮ�ı����ݲ����¶ȱ仯����λ��ǧ��ÿǧ�����϶ȡ�
    p_water = 1000;
    % ˮ���ܶȣ�10^3ǧ��/�����ס�
    k_water = 0.62;
    % ˮ���ȴ���ϵ����W/m?K
    c = (c_water*p_water) / k_water;
    c = c * c;
    f = dudx;
    s = 0;
end