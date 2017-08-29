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

for i = 1:len % ѭ����ʦ��
%    score_all = []; % �ܷ֡�
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
   
   for j = 1:m  % ѭ����¼����
       if(isequal(Group_1_Name(i), TeacherNames(j)))     % ���������ȡ�
%            score_all = [score_all; total(j)];       % ������ʦ���ּܷ���һ���������С�
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
%        end
   end

   
   % ѭ���������еļ�¼����������ݡ�
%    var_score = var(score_all);
%    var_1 = var(problem1);
%    var_2 = var(problem2);
%    var_3 = var(problem3);
%    var_4 = var(problem4);
%    var_5 = var(problem5);
%    var_6 = var(problem6);
%    var_7 = var(problem7);
%    var_8 = var(problem8);
%    var_9 = var(problem9);
%    var_10 = var(problem10);
   
   % ������͡�
   var_sum = sum([var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10]);
%    Alpha(i) = k / (k - 1) * (1 - (var_sum / var_score));
end
%% �����ʱ����
% clearvars data raw cellVectors;