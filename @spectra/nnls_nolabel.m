function obj = nnls_nolabel(obj)
    reference = [obj.Reference,obj.ReferenceNMF];
    [~,n] = size(reference);
    lb = zeros(n,1);
    A = zeros(n,n);
    b = ones(n,1);
    OriRefer = size(obj.Reference,2);
%     ProbeName = cell(1,length(obj.ReferenceFileNames));
%     ProbeCoefficient = cell(length(obj.ReferenceFileNames),1);
    
%     for i = 1: length(ProbeName)
%         file = [obj.ReferencePath,obj.ReferenceFileNames{i}];
%         [~,ProbeName{i}] = obj.load_name(file ,...
%                 'ConcenL',obj.SeperateCharacter.ConcentrationL,'ConcenR',obj.SeperateCharacter.ConcentrationR,...
%                 'ProbeL',obj.SeperateCharacter.ProbeL,'ProbeR',obj.SeperateCharacter.ProbeR);
%     end
    if iscell(obj.Spec)
        Coefficient = cell(1,length(obj.SpectraFileNames));
        NNLSRes = cell(1,length(obj.SpectraFileNames));
        StatisticCoefficient = cell(1,length(obj.SpectraFileNames));
        SpecFitting = cell(1,length(obj.SpectraFileNames));
        for j = 1:size(obj.Spec,2)
            res = [];
            spec = obj.Spec{j};
            coefficient = zeros(n,size(spec,2));
            file = [obj.SpectraPath,obj.SpectraFileNames{j}];
            for i = 1:size(spec,2)
                [coefficient(:,i),~,res_temp,exitflag] = lsqlin(reference,spec(:,i),A,b,[],[],lb,Inf);
                res = [res,res_temp];
            end
            Coefficient{j} = coefficient;
            SpecFitting{j} = reference * coefficient;
            NNLSRes{j} = res;
            StatisticCoefficient{j} = [mean(coefficient(1:OriRefer,:),2),std(coefficient(1:OriRefer,:),0,2)];
        end
        
    else
%         file = [obj.SpectraPath,obj.SpectraFileNames];
%         [Concentration,Probe] = obj.load_name(file,...
%             'ConcenL',obj.SeperateCharacter.ConcentrationL,'ConcenR',obj.SeperateCharacter.ConcentrationR,...
%             'ProbeL',obj.SeperateCharacter.ProbeL,'ProbeR',obj.SeperateCharacter.ProbeR);
        Coefficient = zeros(n,size(obj.Spec,2));
        res=[];
        for i = 1:size(obj.Spec,2)
            [Coefficient(:,i),~,res_temp,exitflag] = lsqlin(reference,obj.Spec(:,i),A,b,[],[],lb,Inf);
            res = [res,res_temp];
        end
        SpecFitting = reference * Coefficient;
        NNLSRes = res;
        StatisticCoefficient = [mean(Coefficient(1:OriRefer,:),2),std(Coefficient(1:OriRefer,:),0,2)];
    end
%     obj.NNLSResult.SpecFitting = SpecFitting;
%     obj.NNLSResult.NNLSRes = NNLSRes;
%     obj.NNLSResult.StatisticCoefficient = StatisticCoefficient;
%     obj.NNLSResult.Coefficient = Coefficient;
%     obj.NNLSResult.Concentraion = Concentration;
%     obj.NNLSResult.Probe = Probe;
    obj.DemultiplexResult = struct('Spec',obj.Spec,'SpecFitting',SpecFitting,'Coefficient',Coefficient,...
        'StatisticCoefficient',StatisticCoefficient,'NNLSRes',NNLSRes,'Axis',obj.Axis);
end