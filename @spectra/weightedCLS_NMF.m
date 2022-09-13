function obj = weightedCLS_NMF(obj)
% 进行weightedCLS_NMF中未知组分的光谱计算

if iscell(obj.Spec)
    
    spec = [];
    for j = 1:size(obj.Spec,2)    
        spec = [spec,obj.Spec{j}];
    end
    
else
    
    spec = obj.Spec;
    
end

if obj.UnknownNumber<0
    [~,~,latent] = pca(spec');
    score = cumsum(latent)/sum(latent);
    obj.UnknownNumber = length(latent)-sum(score>0.997)+1;
end

obj.ReferenceNMF = rand(size(obj.Reference,1),obj.UnknownNumber);
reference = [obj.Reference,obj.ReferenceNMF];
OriRefer = size(obj.Reference,2);


dim = size(spec);

reference = reference./(ones(dim(1),1)*sum(reference));
Coefficient = rand(size(reference,2),dim(2));
for iter = 1:obj.Maxiter
    
    reference = reference./(ones(dim(1),1)*sum(reference)); 
    reference(:,OriRefer+1:end) = reference(:,OriRefer+1:end).*(spec*Coefficient(OriRefer+1:end,:)')./(reference(:,OriRefer+1:end)*Coefficient(OriRefer+1:end,:)*Coefficient(OriRefer+1:end,:)'+reference(:,1:OriRefer)*Coefficient(1:OriRefer,:)*Coefficient(OriRefer+1:end,:)');
    Coefficient(1:OriRefer,:) = Coefficient(1:OriRefer,:).*((obj.Alpha+1)*reference(:,1:OriRefer)'*spec)./((obj.Alpha+1)*reference(:,1:OriRefer)'*reference(:,1:OriRefer)*Coefficient(1:OriRefer,:)+reference(:,1:OriRefer)'*reference(:,OriRefer+1:end)*Coefficient(OriRefer+1:end,:));
    Coefficient(OriRefer+1:end,:) = Coefficient(OriRefer+1:end,:).*(reference(:,OriRefer+1:end)'*spec)./(reference(:,OriRefer+1:end)'*reference(:,OriRefer+1:end)*Coefficient(OriRefer+1:end,:)+reference(:,OriRefer+1:end)'*reference(:,1:OriRefer)*Coefficient(1:OriRefer,:));
              
end

reference= mapminmax(reference',0,1)';
obj.ReferenceNMF = reference(:,end-obj.UnknownNumber+1:end);

end