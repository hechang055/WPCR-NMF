function obj = addMoreReferences(obj,ReferenceAddress,type,sep)
    file = dir(ReferenceAddress);
    if(~exist('sep','var'))
    sep = '638';  % ���δ���ָñ������������и�ֵ
    end
    for i = 1:length(file)
        pos = strfind(file(i).name,sep);
        ReferenceName = file(i).name(1:pos-2);
        obj = add_reference(obj,[file(i).folder,'\',file(i).name],ReferenceName,type);
    end
end