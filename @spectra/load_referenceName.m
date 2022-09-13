function obj = load_referenceName(obj,address)

fid = fopen(address);
ReferNameTemp = fscanf(fid,'%c');
obj.Probe = split(ReferNameTemp,ReferNameTemp(17))';

end