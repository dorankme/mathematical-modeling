%% ��ȡ�ļ�examp02_14.xls�еĵ�һ���������е�G2:G52�е����ݣ����ܳɼ����ݡ�
score = xlsread('examp02_14.xls', 'Sheet1', 'G2:G52');

score = score(score>0); % ȥ��������Ĳ��֡�

%% ����ƽ��ֵ��
score_mean = mean(score); % ����ƽ��ֵ��

%% ����ı�׼�
% ����
ss1 = var(score);   % �����ĸΪn-1��

ss1 = var(score, 0);    % �����ĸΪn-1��

ss2 = var(score, 1);    % �����ĸΪn��

ss3 = std(score);    % �����ĸΪn-1��

ss3 = std(score, 0);    % �����ĸΪn-1��

ss4 = std(score, 1);    % �����ĸΪn��

%% �������ֵ����Сֵ��
score_max = max(score);

score_min = min(score);

%% ����

score_range = range(score);

%% ��λ��

score_median = median(score);

