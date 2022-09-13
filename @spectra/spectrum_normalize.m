function obj = spectrum_normalize(obj)

if ~length(obj.PeakNormalize)==0
    [~,indexL] = min(abs(obj.Shift-obj.PeakNormalize{1}(1)));
    [~,indexR] = min(abs(obj.Shift-obj.PeakNormalize{1}(2)));
    if iscell(obj.Spec)
        
        if obj.PeakNormalize{2}>0
            factor = obj.PeakNormalize{2};
        else
            peak = zeros(length(obj.Spec),2);
            for i =1:length(obj.Spec)
                spec = obj.Spec{i};
                peak(i,:) = [mean(spec(indexL:indexR,:),'all'),size(spec,2)];
            end
            factor = sum(peak(:,1).*peak(:,2),'all')/sum(peak(:,2),'all');
        end
        for i =1:length(obj.Spec)
            spec = obj.Spec{i};
            spec = spec./mean(spec(indexL:indexR,:),1);
            obj.Spec{i} = spec*factor;
        end
    else
        if obj.PeakNormalize{2}>0
            factor = obj.PeakNormalize{2};
        else
            spec = obj.Spec;
            factor = mean(spec(indexL:indexR,:),'all');
        end
        spec = obj.Spec;
        spec = spec./mean(spec(indexL:indexR,:),1);
        obj.Spec = spec*factor;
    end
end

end