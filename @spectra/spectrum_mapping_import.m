function [shift,axis,spectrum] = spectrum_mapping_import(obj,address)
%从address中读取axis数据，shift数据和综合的spectrum
    totalspectrum = importdata(address,'\t',1);
    shift=str2double(totalspectrum.textdata);
    axis_number=sum(isnan(shift));
    shift(1:axis_number)=[];
    if axis_number==1
        axis = transpose(totalspectrum.data(:,1));
        spectrum = totalspectrum.data(:,2:end)';
    elseif axis_number==2
        axis = transpose(totalspectrum.data(:,[2,1]));
        spectrum = totalspectrum.data(:,3:end)';
    else
        axis = transpose(totalspectrum.data(:,[3,2,1]));
        spectrum = totalspectrum.data(:,4:end)';
    end
end