clear;clc;close;

%%
obj = spectra; 
obj.Shift = [500:1:1800]'; % 光谱选取范围，可自行调整。
obj.PeakNormalize = {[1580,1585],-5};%光谱校准，空{}则不做任何校准，每张光谱除以给出峰区间的平均值，如第二个值为负数，则乘以所有光谱的该区间的平均值，如为正值，则直接乘以该值。
obj.SmoothOrder = 3; %平滑级数，一般情况下不需要修改
obj.SmoothWindow = 5; % 平滑窗口，值越大越平滑，但峰值也会下降。
obj.BaselineLambda = 1e7; % 去基线参数，值越低，去基线越彻底，但可能会去掉部分峰值。
obj.BaselineOrder = 3; %去基线的级数，一般情况下不需要修改
% type = 'm'; % Reference提供的类型，如果是labspec导出的多光谱文件，则为'm'，如果是单光谱文件，则为's'。
obj.SpectraNumber = -1; %输出光谱的个数，-1代表输出全部光谱，若参数为正整数，则按照参数的数据输出前N条光谱。
obj.SeperateCharacter = struct('LabelL','[','LabelR',']');%用来区分类型的分隔符
% obj.UnknownNumber =110;
obj.UnknownNumber = -1; %未知光谱的数目，若参数为非负整数，直接按给出的数目添加未知光谱，如果参数小于0，会用PCA计算数目。
obj.Alpha=0.5;% 已知光谱的权重
%%
obj.ReferenceFileNames = 'Reference114.txt';%reference光谱的文件名
ReferenceNameFileNames = 'ReferenceName 114.txt';%记录reference名称的文件名
obj.ReferencePath = 'D:\Doctoral study\BXY\serum\DATA\';%上述两个文件所在路径
data = importdata([obj.ReferencePath,obj.ReferenceFileNames]);
obj.Shift = data(:,1);
obj.Reference = data(:,2:end);
obj = obj.load_referenceName([obj.ReferencePath,ReferenceNameFileNames]);

% 添加Reference,采用类似
% obj =obj.add_reference(ReferenceAddress,ReferenceName,type);这种形式
% 其中ReferenceAddress为需要添加的reference完整路径，ReferenceName为该reference的分子名
% type为该reference提供的类型，如果是labspec导出的多光谱文件，则为'm'，如果是单光谱文件，则为's'。
% 需要添加多少reference就添加几行
% obj = obj.add_reference('D:\Doctoral study\BXY\serum\Ag-20x.txt','Ag','m');

%添加多个Reference,reference的名称应在文件名最前面，之后跟一个空格，再之后跟一个标志性间隔字符串，如这里的‘638’
obj = obj.addMoreReferences('D:\Doctoral study\BXY\serum\DATA\New reference-20220215\*.txt','m','638');
%选取光谱文件
[filenames, path] = uigetfile('*.txt','select the spectra','MultiSelect', 'on');
obj.SpectraFileNames = filenames;
obj.SpectraPath = path;
obj = obj.load_allspectra();

obj = obj.spectrum_normalize();
% obj = obj.weightedCLS_NMF();%计算未知reference
% obj = obj.nnls();%根据计算出的reference计算相应的系数
% [obj,MetaboliteAnova] = obj.AnovaTest([3,6]);%计算统计学差异,中间的类型数字可自定义。
% obj.result_export();%输出数据
% obj.saveReference('D:\Doctoral study\BXY\serum\DATA')%在给出的路径下保存参考光谱