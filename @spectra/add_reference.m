function obj = add_reference(obj,ReferenceAddress,ReferenceName,type)

    switch type
        case 's'
            [shift,spectrum] = obj.spectrum_read(ReferenceAddress);
        case 'm'
            [shift,~,spectra] = obj.spectrum_mapping_import(ReferenceAddress);
            spectrum = mean(spectra,2);
    end

    spectrum = smooth(spectrum,obj.SmoothWindow,'sgolay',obj.SmoothOrder);
    spectrum = obj.airPLS(spectrum',obj.BaselineLambda,obj.BaselineOrder,[],[],obj.BaselineItermax)';
    obj.Reference = [obj.Reference(:,1:end-3),mapminmax(interp1(shift,spectrum',obj.Shift'),0,1)',obj.Reference(:,end-2:end)];
    obj.Probe{end+1} = ReferenceName;
end