%% ������б�����
clear;

%% ������ӱ���е����ݡ�
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: /Users/wangyang/mathematical-modeling/������ѵ/�ڶ���ѵ��/data.xlsx
%    ������: data
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2017/08/28 21:30:56

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

% for i = 1:n
%     temp = data(:,i);
%     data(:,i) = (temp - mean(temp)) / std(temp);
% end

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

%% �����ʱ����
% clearvars data raw cellVectors;

%% ������б���
% clear;