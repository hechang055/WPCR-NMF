function [obj,MetaboliteP] = AnovaTest(obj,label)

y = zeros(length(obj.DemultiplexResult),1);
StatisticCoeff = zeros(length(obj.DemultiplexResult),size(obj.Reference,2));
for i = 1:length(obj.DemultiplexResult)
    
    y(i) = obj.DemultiplexResult(i).Label;
    StatisticCoeff(i,:) = obj.DemultiplexResult(i).StatisticCoefficient(:,1);
    
end

index = zeros(size(y));

for i = 1:length(label)
    index = index | (y==label(i));
end
y = y(index);
StatisticCoeff = StatisticCoeff(index,:);

pResult = [];
for j = 1:size(StatisticCoeff,2)
    CoeffSingle = StatisticCoeff(:,j);
    p = anova1(CoeffSingle,y,'off');
    pResult = [pResult,p];
end
pResult = pResult';
MetaboliteP = pResult<0.05;
obj.AnovaP = pResult;
end