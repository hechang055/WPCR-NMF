function obj = load_spectrum(obj,address,type)
% type: 's'表示用单光谱作为reference
%       'm'表示用mapping数据作为reference
    switch type
        case 's'
            [shift,spectrum] = obj.spectrum_read(address);
        case 'm'
            [shift,~,spectra] = obj.spectrum_mapping_import(address);
            spectrum = mean(spectra,2);
    end
    spectrum = smooth(spectrum,obj.SmoothWindow,'sgolay',obj.SmoothOrder);
    spectrum = obj.airPLS(spectrum',obj.BaselineLambda,obj.BaselineOrder,[],[],obj.BaselineItermax)';
    obj.Reference = [obj.Reference,mapminmax(interp1(shift,spectrum',obj.Shift'),0,1)'];
end