function [obj,MetaboliteP] = AnovaCoeffTest(obj,label)
label = sort(label);
N = size(obj.Spec,2);
% N = 46;
Coeff = cell(1,length(label));%储存每个label对应的Coeff的合并
MetaboliteP = ones(size(obj.Reference,2),1)==1;%记录不具备组内差异的代谢物
for i = 1:length(label)
    CoeffLabel= cell(0);
    Coeff{i} = [];
    for j = 1:N
        if obj.DemultiplexResult(j).Label == label(i)
            CoeffLabel{end+1} = obj.DemultiplexResult(j).Coefficient;
            Coeff{i} = [Coeff{i},obj.DemultiplexResult(j).Coefficient];
        end
    end
    p = zeros(size(obj.Reference,2),1);
    for k = 1:size(obj.Reference,2)
        DataTest=[];group = [];
        for m = 1:size(CoeffLabel,2)
            DataTest = [DataTest,CoeffLabel{m}(k,:)];
            group = [group,ones(size(CoeffLabel{m}(k,:)))*m];
        end
        p(k) = anova1(DataTest,group,'off');    
    end
    MetaboliteP = MetaboliteP & (p>0.05);
end

%计算没有组内显著差异的代谢物在组间的p值
pResult = zeros(size(obj.Reference,2),1);
for k = 1:size(obj.Reference,2)
    DataTest=[];group = [];
    if MetaboliteP(k)
        for m = 1:size(Coeff,2)
            DataTest = [DataTest,Coeff{m}(k,:)];
            group = [group,ones(size(Coeff{m}(k,:)))*m];
        end
        pResult(k) = anova1(DataTest,group,'off');
    else
        pResult(k) = 100;
    end
       
end
obj.AnovaP = pResult;
MetaboliteP = pResult<0.05;
end