%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�: �����ӱ����������֮���ٵ������ݡ�
%
%    ������: /Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/sort.xlsx
%    ������: data
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2017/08/29 12:03:04

%% ������ݡ�
clear;

%% ��������
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% �����������
data = reshape([raw{:}],size(raw));

%% ����������������б�������
Teacher = cellVectors(:,1);
VarName2 = cellVectors(:,2);
m = size(data, 1);  % ��¼����
score = data(:, 3:end); % ʮ����÷־���

%% ����ÿһ�е��ܷ֡�
total = sum(score')';

%% ���ڽ��ڿγ̰�������1�Ľ���ϵ�����㡣

TeacherNames = unique(Teacher);
NumberOfTeachers = size(TeacherNames, 1); % �����ж��ٽ�ʦ��

NumberTeacherNames = size(TeacherNames, 1); %��ʦ������
NumberClassTeacherTeach = zeros(NumberTeacherNames, 1); %��ʦ�̵İ༶��Ŀ��
TeacherTeachStu = zeros(NumberTeacherNames, 1); % ��ʦ�̵�������

for i = 1:NumberTeacherNames
    for j = 1:m
       if(isequal(TeacherNames(i), Teacher(j))) 
%            TeacherTeachStu(i) = TeacherTeachStu(i) + D(j);
           NumberClassTeacherTeach(i) = NumberClassTeacherTeach(i) + 1;
       end
    end
end

%% �õ����ڿγ���������1�����ݡ�����ʦ�������ڵĿγ̣�

index = (NumberClassTeacherTeach > 1); % �±ꡣ

TeacherNames = TeacherNames(index);
NumberClassTeacherTeach = NumberClassTeacherTeach(index);

Teachers = {
    '��ʦ����';
    '����ѧ������';
    '���ڰ���';
}';

%% ����ϵ����
len = size(TeacherNames, 1); % ��ʦ��Ŀ��
Alpha = zeros(len, 1);
k = 10;
for i = 1:len % ѭ����ʦ��
   score_all = []; % �÷֡�
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
   
   for j = 1:m % ѭ����¼����
       if(isequal(TeacherNames(i), Teacher(j))) % ���������ȡ�
           score_all = [score_all; total(j)]; % ������ʦ���ּܷ���һ���������С�
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
   var_score = var(score_all);
   var_1 = var(problem1);
   var_2 = var(problem2);
   var_3 = var(problem3);
   var_4 = var(problem4);
   var_5 = var(problem5);
   var_6 = var(problem6);
   var_7 = var(problem7);
   var_8 = var(problem8);
   var_9 = var(problem9);
   var_10 = var(problem10);
   
   % ������͡�
   var_sum = sum([var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10]);
   
   Alpha(i) = k / (k - 1) * (1 - (var_sum / var_score));
end

%% ��
Names = {
    '��ʦ����', '�Ŷ�ϵ��'
};

result3(1, :) = Names;
result3(2:len+1, :) = [TeacherNames, num2cell(Alpha)]; 

%% ��ͼ
hist(Alpha);
title('�Ŷ�ϵ���������ֲ�ֱ��ͼ');
xlabel('�Ŷ�ϵ��');
ylabel('����');