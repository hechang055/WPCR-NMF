function [shift,spectrum] = spectrum_read(obj,address)
%��ȡһ��������ݣ�shift��Ϊ������spectrumΪǿ��
    fid = fopen(address);
    spectrum = cell2mat(textscan(fid,'%f %f','Delimiter','\t'));
    shift = spectrum(:,1);
    spectrum = spectrum(:,2);
    fclose(fid);
end