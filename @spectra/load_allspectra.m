function obj = load_allspectra(obj)

     if iscell(obj.SpectraFileNames)
         Axis = cell(1,length(obj.SpectraFileNames));
         Spec = cell(1,length(obj.SpectraFileNames));
         for i = 1:length(obj.SpectraFileNames)
            file = [obj.SpectraPath,obj.SpectraFileNames{i}];
            [Spec{i},Axis{i}] = obj.load_spectra(file);
         end
         
     else
         
         file = [obj.SpectraPath,obj.SpectraFileNames];
         [Spec,Axis] = obj.load_spectra(file);
        
     end
    obj.Spec = Spec;
    obj.Axis = Axis;
end