%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: /Users/wangyang/mathematical-modeling/������ѵ/������ѵ��/������ϵͳ�µ����ݹ�ѧ���ο�.xlsx
%    ������: Sheet1
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2017/08/31 10:11:36
%% �������
clear;

%% ��������
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/������ѵ/������ѵ��/������ϵͳ�µ����ݹ�ѧ���ο�.xlsx','Sheet1');
raw = raw(3:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10]);

%% �����������
data = reshape([raw{:}],size(raw));
m = size(data, 1);  % ����������

%% ����������������б�������
TeacherName = cellVectors(:,1);   % ��ʦ������
CourseName = cellVectors(:,2);    % ��������(�γ���)��
Number_Of_Judges = data(:,1);     % ����������
Class_Size = data(:,2);           % �༶��ģ��
x_1 = data(:,3);            % �������ݣ����ڿγ̣����֣���
x_2 = data(:,4);            % �ڿ��г�Ӧ�ö��������֤���������˼�������⣬��֯�������ۡ�
x_3 = data(:,5);            % ��ý����������?����淶��������
x_4 = data(:,6);            % ���ز��ҹ�ƽ�����Դ�ÿһ��ѧ����
x_5 = data(:,7);            % Ը���ڿ�����ͨ�����ַ�ʽ����ѧ����
x_6 = data(:,8);            % �Ҵ����ſ�ѧ����ණ�����Ը�ѧ�Ƹ�����Ȥ��


% score = [x_1, x_2, x_3, x_4, x_5, x_6, x_7];
score = [x_1, x_2, x_3, x_4, x_5, x_6]; % �����ò����ʡ�

%% ������ʦ����
UniqueTeacherName = unique(TeacherName);    % ������ʦ������
UniqueTeacherNameNum = size(UniqueTeacherName, 1);

UniqueCourseName = unique(CourseName);
UniqueCourseNameNum = size(UniqueCourseName, 1);

%% ����ǰ

X_standard_1 = zscore(score); % ��׼����
X_R_1 = corrcoef(X_standard_1); % �������ϵ����

[vec_1, lambda_1, rate_1] = pcacov(X_R_1); % �������ϵ���������ɷ�����vec����Ϊ���ϵ�������������������ɷ�ϵ����
% lambda Ϊ����ֵ��rateΪ���ɷֵĹ����ʡ�

contr_1 = cumsum(rate_1); % �����ۼƹ����ʡ�

f = repmat(sign(sum(vec_1)), size(vec_1, 1), 1); % ������vec��ͬά���ķ��ž���

vec_1_2 =vec_1 .* f; % �޸����������ķ��ţ�ʹ��ÿ�������ķ�����Ϊ����

%% ѡȡ���ɷָ���

num_1 = 1;

df_1 = X_standard_1 * vec_1_2(:,1:num_1);

% p1_1 = df_1(:, 1)';
% p2_1 = df_1(:, 2)';

% figure;
% scatter(p1_1, p2_1,'o');
% title('ѡȡ�������ɷ�֮�����ɢ��ͼ')
% xlabel('���ɷ�1')
% ylabel('���ɷ�2')
% text(p1_1, p2_1, TeacherName);

tf_1 = df_1 * rate_1(1:num_1) / 100; % �����ۺϵ÷֡�

[stf_1 ,ind_1] = sort(tf_1, 'descend');

%% ��ʾ���

result1(1, :) = {
    '����ֵ', '��ֵ', '������', '�ۼƹ�����'
};
result1(2:size(lambda_1, 1) + 1,1) = num2cell(lambda_1);
result1(2:size(lambda_1, 1), 2) = num2cell(-diff(lambda_1));
result1(2:size(lambda_1, 1) + 1,3:4) = num2cell([rate_1, cumsum(rate_1)]);

%% ��ͼ��
x_temp1 = 1:size(contr_1, 1);
figure;
plot(x_temp1, contr_1','.-') % �ۼƹ���ֵ��ͼ��
title('���ɷ�ѡȡ�������ۼƹ���ֵ');
xlabel('���ɷ�ѡȡ����');
ylabel('�ۼƹ���ֵ');

%% ���γ̷�����㲢��׼����
X = [];
X = [Number_Of_Judges, Class_Size, x_1, x_2, x_3, x_4, x_5, x_6];

MeanCourse = zeros(UniqueCourseNameNum, 8);     % ��¼ÿ�ſγ̸����ƽ��ֵ���󡣰༶��ģ������������ƽ�������ۼӲ����ʡ�
P = zeros(UniqueCourseNameNum, 1);              % �����ʡ�
count = zeros(UniqueCourseNameNum, 1);          % ������

X_new = [];
for i = 1:UniqueCourseNameNum % ѭ��ÿ�пγ̡�
    temp = [];
    for j = 1:m % ѭ��ÿ��ԭʼ���ݡ�
        if(isequal(UniqueCourseName(i), CourseName(j))) % ����γ�����ͬ��
            count(i,1) = count(i,1) + 1;    % ������
            MeanCourse(i, :) = MeanCourse(i, :) + X(j, :);
            temp = [temp; X(j, :)];
        end % ѭ�������м�¼�����Ѿ��ֺ��ࡣ
    end
%     temp = [temp(:, 3:end), temp(:, 1) ./ temp(:, 2)];
    temp = [temp(:, 3:end)]; % �����ò����ʡ�
    X_new = [X_new; zscore(temp)];  % �����µľ����С�
end

MeanCourse(:, 3:end) = MeanCourse(:, 3:end) ./ count; % ����γ̵�6��ָ���ƽ���֣��Լ��ܲ��������Լ��ܰ༶��ģ��
P = MeanCourse(:, 1) ./ MeanCourse(:, 2); % ����γ̵�ƽ�������ʡ� �ܲ�������/�ܰ༶��ģ��

MeanCourse = [MeanCourse, P];

result4(1, 1:2) = {'�γ���', '�ڿν�ʦ��'};
result4(2:6, 1) = UniqueCourseName;
result4(2:6, 2) = num2cell(count);

%% ��ʾ
featureNames = {
    '��������';
    '�༶��ģ';
    '��������';
    '�ڿ��г�Ӧ�ö��������֤���������˼�������⣬��֯�������ۡ�';
    '��ý����������?����淶��������';
    '���ز��ҹ�ƽ�����Դ�ÿһ��ѧ����';
    'Ը���ڿ�����ͨ�����ַ�ʽ����ѧ����';
    '�Ҵ����ſ�ѧ����ණ�����Ը�ѧ�Ƹ�����Ȥ��';
    '���������';
};

result2(1,1) = {'�γ���'};
result2(2:6,1) = UniqueCourseName;
result2(1, 2:10) =  featureNames;
result2(2:6,2:end) = num2cell(MeanCourse);
%% �����
X_standard_2 = X_new;

X_R_2 = corrcoef(X_standard_2); % �������ϵ����

[vec_2, lambda_2, rate_2] = pcacov(X_R_2); % �������ϵ���������ɷ�����vec����Ϊ���ϵ�������������������ɷ�ϵ����

% lambda Ϊ����ֵ��rateΪ���ɷֵĹ����ʡ�

contr_2 = cumsum(rate_2); % �����ۼƹ����ʡ�

f_2 = repmat(sign(sum(vec_2)), size(vec_2, 1), 1); % ������vec��ͬά���ķ��ž���

vec_2_2 =vec_2 .* f_2; % �޸����������ķ��ţ�ʹ��ÿ�������ķ�����Ϊ����

num_2 = 1; % ���ɷֵķ�����

df_2 = X_standard_2 * vec_2_2(:,1:num_2); % ��ά������ɷ֡�

% p1_2 = df_2(:, 1)';
% p2_2 = df_2(:, 2)';
% 
% figure;
% scatter(p1_2, p2_2,'o');
% text(p1_2, p2_2, TeacherName);
% title('����֮���������ɷֵ�ɢ��ͼ');
% xlabel('���ɷ�1');
% ylabel('���ɷ�2');

tf_2 = df_2 * rate_2(1:num_2) / 100; % �����ۺϵ÷֣��������ɷּ������ݡ�

[stf_2,ind_2] = sort(tf_2, 'descend');

%% ��ͼ��
figure;
x_temp2 = 1:size(contr_2, 1);
plot(x_temp2, contr_2','.-') % �ۼƹ���ֵ��ͼ��
title('����֮�����ɷ�ѡȡ�������ۼƹ���ֵ');
xlabel('���ɷ�ѡȡ����');
ylabel('�ۼƹ���ֵ');

%% ��ʾ���
result3(1, :) = {
    '����ֵ', '��ֵ', '������', '�ۼƹ�����'
};
result3(2:size(lambda_2, 1) + 1,1) = num2cell(lambda_2);
result3(2:size(lambda_2, 1), 2) = num2cell(-diff(lambda_2));
result3(2:size(lambda_2, 1) + 1,3:4) = num2cell([rate_2, cumsum(rate_2)]);

%% �����ʱ����
clearvars data raw cellVectors;