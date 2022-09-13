clear;clc;close;

%%
obj = spectra; 
obj.Shift = [500:1:1800]'; % ����ѡȡ��Χ�������е�����
obj.PeakNormalize = {[1580,1585],-5};%����У׼����{}�����κ�У׼��ÿ�Ź��׳��Ը����������ƽ��ֵ����ڶ���ֵΪ��������������й��׵ĸ������ƽ��ֵ����Ϊ��ֵ����ֱ�ӳ��Ը�ֵ��
obj.SmoothOrder = 3; %ƽ��������һ������²���Ҫ�޸�
obj.SmoothWindow = 5; % ƽ�����ڣ�ֵԽ��Խƽ��������ֵҲ���½���
obj.BaselineLambda = 1e7; % ȥ���߲�����ֵԽ�ͣ�ȥ����Խ���ף������ܻ�ȥ�����ַ�ֵ��
obj.BaselineOrder = 3; %ȥ���ߵļ�����һ������²���Ҫ�޸�
% type = 'm'; % Reference�ṩ�����ͣ������labspec�����Ķ�����ļ�����Ϊ'm'������ǵ������ļ�����Ϊ's'��
obj.SpectraNumber = -1; %������׵ĸ�����-1�������ȫ�����ף�������Ϊ�����������ղ������������ǰN�����ס�
obj.SeperateCharacter = struct('LabelL','[','LabelR',']');%�����������͵ķָ���
% obj.UnknownNumber =110;
obj.UnknownNumber = -1; %δ֪���׵���Ŀ��������Ϊ�Ǹ�������ֱ�Ӱ���������Ŀ���δ֪���ף��������С��0������PCA������Ŀ��
obj.Alpha=0.5;% ��֪���׵�Ȩ��
%%
obj.ReferenceFileNames = 'Reference114.txt';%reference���׵��ļ���
ReferenceNameFileNames = 'ReferenceName 114.txt';%��¼reference���Ƶ��ļ���
obj.ReferencePath = 'D:\Doctoral study\BXY\serum\DATA\';%���������ļ�����·��
data = importdata([obj.ReferencePath,obj.ReferenceFileNames]);
obj.Shift = data(:,1);
obj.Reference = data(:,2:end);
obj = obj.load_referenceName([obj.ReferencePath,ReferenceNameFileNames]);

% ���Reference,��������
% obj =obj.add_reference(ReferenceAddress,ReferenceName,type);������ʽ
% ����ReferenceAddressΪ��Ҫ��ӵ�reference����·����ReferenceNameΪ��reference�ķ�����
% typeΪ��reference�ṩ�����ͣ������labspec�����Ķ�����ļ�����Ϊ'm'������ǵ������ļ�����Ϊ's'��
% ��Ҫ��Ӷ���reference����Ӽ���
% obj = obj.add_reference('D:\Doctoral study\BXY\serum\Ag-20x.txt','Ag','m');

%��Ӷ��Reference,reference������Ӧ���ļ�����ǰ�棬֮���һ���ո���֮���һ����־�Լ���ַ�����������ġ�638��
obj = obj.addMoreReferences('D:\Doctoral study\BXY\serum\DATA\New reference-20220215\*.txt','m','638');
%ѡȡ�����ļ�
[filenames, path] = uigetfile('*.txt','select the spectra','MultiSelect', 'on');
obj.SpectraFileNames = filenames;
obj.SpectraPath = path;
obj = obj.load_allspectra();

obj = obj.spectrum_normalize();
% obj = obj.weightedCLS_NMF();%����δ֪reference
% obj = obj.nnls();%���ݼ������reference������Ӧ��ϵ��
% [obj,MetaboliteAnova] = obj.AnovaTest([3,6]);%����ͳ��ѧ����,�м���������ֿ��Զ��塣
% obj.result_export();%�������
% obj.saveReference('D:\Doctoral study\BXY\serum\DATA')%�ڸ�����·���±���ο�����