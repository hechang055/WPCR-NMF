function [obj,MetaboliteP] = AnovaSingleTest(obj,label)
label = sort(label);
N = size(obj.Spec,2);
Coeff = cell(1,length(label));
for i = 1:length(label)
    Coeff{i} = [];
    for j = 1:N
        if obj.DemultiplexResult(j).Label == label(i)
            Coeff{i} = [Coeff{i},obj.DemultiplexResult(j).Coefficient];
        end
    end
    
end

for k = 1:size(obj.Reference,2)
    DataTest=[];group = [];
    for m = 1:size(Coeff,2)
        DataTest = [DataTest,Coeff{m}(k,:)];
        group = [group,ones(size(Coeff{m}(k,:)))*m];
    end
    pResult(k) = anova1(DataTest,group,'off');
end
obj.AnovaP = pResult;
MetaboliteP = pResult<0.05;
end