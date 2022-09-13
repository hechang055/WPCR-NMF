classdef spectra < spectrum
    
    properties
        Reference
        ReferenceNMF = []
        PeakNormalize = {}
        DemultiplexResult
        Axis
        ReferenceFileNames
        Probe
        ReferencePath
        SpectraFileNames
        SpectraNumber
        SpectraPath
        UnknownNumber = 64
        Maxiter = 200
        Alpha = 0.5
        AnovaP
        SeperateCharacter = struct('LabelL','[','LabelR',']')
    end
    
end