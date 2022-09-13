function obj = load_reference(obj,type)
    
    if iscell(obj.ReferenceFileNames)
        for i = 1:length(obj.ReferenceFileNames)
            file = [obj.ReferencePath,obj.ReferenceFileNames{i}];
            obj = obj.load_spectrum(file,type);
        end
        obj.Reference = [obj.Reference,obj.Shift.^0,obj.Shift,obj.Shift.^2];
    else
        file = [obj.ReferencePath,obj.ReferenceFileNames];
        obj = obj.load_spectrum(file,type);
        obj.Reference = [obj.Reference,obj.Shift.^0,obj.Shift,obj.Shift.^2];
    end
    obj.Reference = mapminmax(obj.Reference',0,1)';

end