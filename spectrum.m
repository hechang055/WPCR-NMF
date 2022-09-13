classdef spectrum
     properties
        Spec
        Shift = [301:1:1700]';
        SmoothOrder = 3;
        SmoothWindow = 7;
        BaselineLambda = 1e7;
        BaselineOrder = 3;
        BaselineItermax = 25;
        
     end
end