function saveReference(obj,address)
ref = [obj.Shift,obj.Reference];
save([address,'\Reference ',num2str(size(obj.Reference,2)),'.txt'],'ref','-ascii');
file = [address,'\ReferenceName ',num2str(size(obj.Reference,2)),'.txt'];
fid = fopen(file,'w');
StrOut = '';
for i = 1:length(obj.Probe)
    if i ==length(obj.Probe)
        StrOut = [StrOut,obj.Probe{i},'\n'];
    else
        StrOut = [StrOut,obj.Probe{i},'\t'];
    end
end
fprintf(fid,StrOut);
fclose(fid);
end