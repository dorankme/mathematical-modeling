%% ������б�����
clear;

%% �������ݡ�
[~, ~, raw] = xlsread('/Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx','data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2]);
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14]);

%% �������������
data = reshape([raw{:}],size(raw));

%% ����������������б������ơ�
Teacher = cellVectors(:,1);     % ��ʦ������
Course = cellVectors(:,2);      % �γ�����
C = data(:, 1);     % ����������
D = data(:, 2);     % �༶��ģ��


E = data(:, 3);     % ��ѧ���ݳ�ʵ��ע���Ƽ��ο����ϡ�
F = data(:, 4);     % ��עѧ��רҵ��չ���������¿��гɹ���ʵ�����½�ѧ���ݡ�
G = data(:, 5);     % ���ؽ�ѧ���ɣ���ʱ�ϿΣ���֤ѧʱ��
H = data(:, 6);     % ���õĽ�ѧ��������Ч������ѧ��˼ά��ǿ�����ѧ�Ƶ�˼�룬����ѧ��̽����
I = data(:, 7);     % ע������������ѧ���Ա��γ̵�ѧϰ��Ȥ��
J = data(:, 8);     % ͨ�����γ�ѧϰ��������֪ʶ����������Ұ����ѧϰ֮�����Ȱ����γ̣��ջ��
K = data(:, 9);     % ע���ѧ������������ȡѧ����������ԸĽ���
L = data(:, 10);    % ��ѧ���渺�𣬶�ѧ��Ҫ���ϸ����Ľ�����ʡ�
M = data(:, 11);    % ������죬����׼ȷ�������������ص�ͻ����ע����ϵʵ�ʣ�����ѧ��ѧ�����á�
N = data(:, 12);    % ����ʹ�ð���Ͷ�ý���ѧ�ֶΣ�������ѧ����������֪ʶ��
P = C ./ D * 10;	% �����ʣ�����10�֡�

% ���������ơ�
featureNames = {
    '��������';
    '�༶��ģ';
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

%% ���ݵ�ƽ��-��׼���
m = size(data, 1);  % ��¼����
n = size(data, 2);  % ��¼���������� 

X= [E F G H I J K L M N P]; % ���¶������

X_standard = zscore(X);  % ����ı�׼����

X_R = corrcoef(X_standard); % �������ϵ����

[vec, lambda, rate] = pcacov(X_R); % �������ϵ���������ɷ�����vec����Ϊ���ϵ�������������������ɷ�ϵ����

% lambda Ϊ����ֵ��rateΪ���ɷֵĹ����ʡ�

contr = cumsum(rate); % �����ۼƹ����ʡ�

f = repmat(sign(sum(vec)), size(vec, 1), 1); % ������vec��ͬά���ķ��ž���

vec_2 =vec .* f; % �޸����������ķ��ţ�ʹ��ÿ�������ķ�����Ϊ����

num = 3; % ���ɷֵķ�����

df = X_standard * vec_2(:,1:num);

tf = df * rate(1:num) / 100; % �����ۺϵ÷֡�

[stf,ind] = sort(tf, 'descend');

%% ������������
i = 1:m;
i = i';
result0(1,1:3) = {
    'ԭʼ���ݱ��е������';
    '�÷�';
    '����';
};
result0(2:m+1,1:3) = num2cell([i, tf, ind]);

%% ��ʾ�����

result1(1, :) = {
    '����ֵ', '��ֵ', '������', '�ۼƹ�����'
};
result1(2:size(lambda, 1) + 1,1) = num2cell(lambda);
result1(2:size(lambda, 1), 2) = num2cell(-diff(lambda));
result1(2:size(lambda, 1) + 1,3:4) = num2cell([rate, cumsum(rate)]);

%% ��׼��������
s = {
    '��׼������', 'x1', 'x2', 'x3', 'x4', 'x5', 'x6', 'x7', 'x8', 'x9', 'x10', 'x11'
};

result2(:, 1) = s;

f=[];
for i=1:num
    Frame_Name = ['���ɷ�' num2str(i)];
    f = [f;Frame_Name];
end

result2(1, 2:num + 1) = cellstr(f);
result2(2:end, 2:num + 1) = num2cell(vec_2(:,1:num));

%% ��ͼ��
x = 1:size(contr, 1);
plot(x, contr','.-') % �ۼƹ���ֵ��ͼ��
title('���ɷ�ѡȡ�������ۼƹ���ֵ');
xlabel('���ɷ�ѡȡ����');
ylabel('�ۼƹ���ֵ');

%% �����������ʦ�������ֿγ̡�
TeacherNames = unique(Teacher);
NumberOfTeachers = size(TeacherNames, 1); % �����ж��ٽ�ʦ��
TypeOfCourse = unique(Course); % �����ж����ֿγ̡�

%% ����ÿ��γ̸��Ե�ƽ��ֵ��
NumberOfCourseTypes = size(TypeOfCourse, 1); % �γ���������
MeanCourse = zeros(NumberOfCourseTypes, n); % ��¼ÿ�ſγ̸����ƽ��ֵ����
NumberOfCourse = zeros(NumberOfCourseTypes, 1); % ��¼ÿ�ſγɵİ༶����

for i = 1:NumberOfCourseTypes % ѭ��ÿ�пγ̡�
    for j = 1:m % ѭ��ÿ��ԭʼ���ݡ�
        if(isequal(TypeOfCourse(i), Course(j))) % ����γ�����ͬ��
            MeanCourse(i,:) = MeanCourse(i,:) + data(j,:);
            NumberOfCourse(i) = NumberOfCourse(i) + 1;
        end
    end
end

MeanCourse = MeanCourse ./ NumberOfCourse; % ����ÿ�ֿγ̵�ƽ��ֵ��

%% �γ����ͼ���ͬ��ƽ���ֱ�
Courses = ['�γ���'; featureNames];
Courses = [Courses'; [TypeOfCourse,num2cell(MeanCourse)]]; % �γ����ͼ���ͬ��ƽ���֡�

%% ����ÿ����ʦ�̶��ٸ��࣬�����ˡ�

NumberTeacherNames = size(TeacherNames, 1); %��ʦ������
NumberClassTeacherTeach = zeros(NumberTeacherNames, 1); %��ʦ�̵İ༶��Ŀ��
TeacherTeachStu = zeros(NumberTeacherNames, 1); % ��ʦ�̵�������

for i = 1:NumberTeacherNames
    for j = 1:m
       if(isequal(TeacherNames(i), Teacher(j))) 
           TeacherTeachStu(i) = TeacherTeachStu(i) + D(j);
           NumberClassTeacherTeach(i) = NumberClassTeacherTeach(i) + 1;
       end
    end
end

Teachers = {
    '��ʦ����';
    '����ѧ������';
    '���ڰ���';
}';

% ��ʦ������Ϣ��
Teachers = [Teachers; [TeacherNames, num2cell([TeacherTeachStu, NumberClassTeacherTeach])]];

%% ������б���
% clear;