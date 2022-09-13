function [spec,axis] = load_spectra(obj,address)

    [shift,axis,spectra] = obj.spectrum_mapping_import(address);
    spec = zeros(length(obj.Shift),size(spectra,2));
    for i = 1:size(spectra,2)
        spectra(:,i) = smooth(spectra(:,i),obj.SmoothWindow,'sgolay',obj.SmoothOrder);
        spectra(:,i) = obj.airPLS(spectra(:,i)',obj.BaselineLambda,obj.BaselineOrder,[],[],obj.BaselineItermax)';
        spec(:,i) = interp1(shift,spectra(:,i)',obj.Shift');
    end
    spec = spec-min(spec,[],1);
%     obj.Axis = axis;
end