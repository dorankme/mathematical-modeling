%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: /Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx
%    ������: data
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2017/08/28 21:30:56

%% ��������
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% �����������
data = reshape([raw{:}],size(raw));

%% ����������������б�������
VarName1 = cellVectors(:,1);
VarName2 = cellVectors(:,2);
VarName3 = data(:,1);
VarName4 = data(:,2);
VarName5 = data(:,3);
VarName6 = data(:,4);
VarName7 = data(:,5);
VarName8 = data(:,6);
VarName9 = data(:,7);
VarName10 = data(:,8);
VarName11 = data(:,9);
VarName12 = data(:,10);
VarName13 = data(:,11);
VarName14 = data(:,12);

%% �����ʱ����
clearvars data raw cellVectors;