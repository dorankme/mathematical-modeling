%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: /Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx
%    ������: data
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2017/08/29 12:58:54

%% �������
clear;

%% ��������
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% �����������
data = reshape([raw{:}],size(raw));
m = size(data, 1);
score = data(:, 3:end); % ʮ����÷־���

%% ����������������б�������
TeacherNames = cellVectors(:,1);
CourseNames = cellVectors(:,2);

%% 
TecherNamesTable = unique(TeacherNames);

TeachMum = zeros(size(TecherNamesTable, 1), 1);
for i = 1:size(TecherNamesTable, 1)
    TeachCourse = {};
    for j = 1:m % ѭ�����м�¼��
        if(isequal(TecherNamesTable(i), TeacherNames(j)))
            if(ismember(CourseNames(j), TeachCourse))
                ; % �������顣
            else
                TeachMum(i,1) = TeachMum(i,1) + 1;
                TeachCourse = [TeachCourse, CourseNames(j)];
            end
        end
    end
end

%% �Ѳ���������0-500.500-1000.1000���Ϸ������ÿһ����ÿ������ĵ÷־�ֵ��
featureNames = {
    '��ѧ���ݳ�ʵ��ע���Ƽ��ο�����';
    '��עѧ��רҵ��չ���������¿��гɹ���ʵ�����½�ѧ����';
    '���ؽ�ѧ���ɣ���ʱ�ϿΣ���֤ѧʱ';
    '���õĽ�ѧ��������Ч������ѧ��˼ά��ǿ�����ѧ�Ƶ�˼�룬����ѧ��̽��';
    'ע������������ѧ���Ա��γ̵�ѧϰ��Ȥ';
    'ͨ�����γ�ѧϰ��������֪ʶ����������Ұ����ѧϰ֮�����Ȱ����γ̣��ջ��';
    'ע���ѧ������������ȡѧ����������ԸĽ�';
    '��ѧ���渺�𣬶�ѧ��Ҫ���ϸ����Ľ������';
    '������죬����׼ȷ�������������ص�ͻ����ע����ϵʵ�ʣ�����ѧ��ѧ������';
    '����ʹ�ð���Ͷ�ý���ѧ�ֶΣ�������ѧ����������֪ʶ';
};

TecherNamesTable = unique(TeacherNames);
data_temp = zeros(size(TecherNamesTable, 1), 12);
count_temp = zeros(size(TecherNamesTable, 1), 1);

for i = 1:size(TecherNamesTable, 1) % ѭ����ʦ��
    for j = 1:m % ѭ�����м�¼��
        if(isequal(TecherNamesTable(i), TeacherNames(j)))
            data_temp(i,:) = data_temp(i,:) + data(j, :);
            count_temp(i) = count_temp(i) + 1;
        end
    end
end

data_temp(:, 3:end) = data_temp(:, 3:end) ./ count_temp;

temp_count = zeros(4, 12);

count = zeros(4, 1);
temp_data_temp = data_temp;
for i = 1:size(temp_data_temp, 1) % �������кϲ���ļ�¼��
    if(temp_data_temp(i, 1) < 250)
        count(1, 1) = count(1, 1) + 1;
        temp_count(1,:) =  temp_count(1,:) + temp_data_temp(i, :);
    elseif (temp_data_temp(i, 1) < 500)
        count(2, 1) = count(2, 1) + 1;
        temp_count(2,:) =  temp_count(2,:) + temp_data_temp(i, :);
    elseif (temp_data_temp(i, 1) < 750)
        count(3, 1) = count(3, 1) + 1;
        temp_count(3,:) =  temp_count(3,:) + temp_data_temp(i, :);
    else
        count(4, 1) = count(4, 1) + 1;
        temp_count(4,:) =  temp_count(4,:) + temp_data_temp(i, :);
    end
end

temp_count(:, 3:end) = temp_count(:, 3:end) ./ count;

key = temp_count(:, 3:end);

% ���ղ������������ĸ��ȼ���
result10(1:5,1) = {
    '������';
    '��������С��250��';
    '�����������ڵ���250����С��500��';
    '�����������ڵ���500����С��750��';
    '�����������ڵ���750��';
};

result10(1, 2:11) = featureNames;
result10(2:end, 2:end) = num2cell(key);

count_2 = zeros(5, 1);
temp_data_temp_2 = data_temp;
temp_count_2 = zeros(5, 12);
for i = 1:size(temp_data_temp_2, 1) % �������кϲ���ļ�¼��
    if(temp_data_temp_2(i, 2) < 250)
        count_2(1,1) = count_2(1, 1) + 1;
        temp_count_2(1,:) =  temp_count_2(1,:) + temp_data_temp_2(i, :);
    elseif (temp_data_temp_2(i, 2) < 500)
        count_2(2,1) = count_2(2, 1) + 1;
        temp_count_2(2,:) =  temp_count_2(2,:) + temp_data_temp_2(i, :);
    elseif (temp_data_temp_2(i, 2) < 750)
        count_2(3,1) = count_2(3, 1) + 1;
        temp_count_2(3,:) =  temp_count_2(3,:) + temp_data_temp_2(i, :);
    elseif (temp_data_temp_2(i, 2) < 1000)
        count_2(4,1) = count_2(4, 1) + 1;
        temp_count_2(4,:) =  temp_count_2(4,:) + temp_data_temp_2(i, :);
    else
        count_2(5,1) = count_2(5, 1) + 1;
        temp_count_2(5,:) =  temp_count_2(5,:) + temp_data_temp_2(i, :);
    end
end

temp_count_2(:, 3:end) = temp_count_2(:, 3:end) ./ count_2;

key_2 = temp_count_2(:, 3:end);

% ���ղ������������ĸ��ȼ���
result11(1:6,1) = {
    '������';
    '�༶��ģС��250��';
    '�༶��ģ���ڵ���250����С��500��';
    '�༶��ģ���ڵ���500����С��750��';
    '�༶��ģ���ڵ���750����С��1000��';
    '�༶��ģ���ڵ���1000��';
};

result11(1, 2:11) = featureNames;
result11(2:end, 2:end) = num2cell(key_2);

%% ���ɱ�
Names = {
    '��ʦ����', '����ʦ���ڵĿγ�������'
};

result4(1, :) = Names;
result4(2:size(TecherNamesTable, 1)+1, :) = [TecherNamesTable, num2cell(TeachMum)]; 

%% ���顣
index_1 = (TeachMum==1);    % ֻ��һ�ſΡ�
index_2 = (TeachMum==2);    % ֻ�����ſΡ�
index_3 = (TeachMum==3);    % ֻ�����ſΡ�

%% �������ͼ��
% ֻ��һ�ſε�������ʦ�ڵ�һ���ϵ�ƽ���÷�

Group_1_Name = TecherNamesTable(index_1); 

len = size(Group_1_Name, 1);

problem1 = [];
problem2 = [];
problem3 = [];
problem4 = [];
problem5 = [];
problem6 = [];
problem7 = [];
problem8 = [];
problem9 = [];
problem10 = [];

for i = 1:len % ѭ����ʦ��
   for j = 1:m  % ѭ����¼����
       if(isequal(Group_1_Name(i), TeacherNames(j)))     % ���������ȡ�
           problem1 = [problem1; score(j, 1)];
           problem2 = [problem2; score(j, 2)];
           problem3 = [problem3; score(j, 3)];
           problem4 = [problem4; score(j, 4)];
           problem5 = [problem5; score(j, 5)];
           problem6 = [problem6; score(j, 6)];
           problem7 = [problem7; score(j, 7)];
           problem8 = [problem8; score(j, 8)];
           problem9 = [problem9; score(j, 9)];
           problem10 = [problem10; score(j, 10)];
       end
   end
   % ѭ���������еļ�¼����������ݡ�
end

mean_1(1) = mean(problem1);
mean_1(2) = mean(problem2);
mean_1(3) = mean(problem3);
mean_1(4) = mean(problem4);
mean_1(5) = mean(problem5);
mean_1(6) = mean(problem6);
mean_1(7) = mean(problem7);
mean_1(8) = mean(problem8);
mean_1(9) = mean(problem9);
mean_1(10) = mean(problem10);



%% �����ʱ����
% clearvars data raw cellVectors;