function result_export(obj)

[status,msg] = mkdir([obj.SpectraPath,'result']);

if status == 0
    error(msg)
end
resultPath = [obj.SpectraPath,'result\'];


if iscell(obj.Spec)
    for j = 1:length(obj.Spec)
        fileSpectra = [resultPath,'Spectra-',obj.SpectraFileNames{j}];
        save_spectra(fileSpectra,obj.Shift,obj.DemultiplexResult(j).Spec,obj.DemultiplexResult(j).SpecFitting,obj.SpectraNumber);%输出光谱
        
        fileCoefficient = [resultPath,'Coefficient-',obj.SpectraFileNames{j}];
        save_coefficient(fileCoefficient,obj.Probe,obj.DemultiplexResult(j).Coefficient(1:size(obj.Reference,2),:));
        
        fileStatisticCoefficient = [resultPath,'StatisticCoefficient-',obj.SpectraFileNames{j}];
        save_StatisticCoefficient(fileStatisticCoefficient,obj.Probe,obj.DemultiplexResult(j).StatisticCoefficient)
    end
else
    fileSpectra =[resultPath,'Spectra-',obj.SpectraFileNames];
    save_spectra(fileSpectra,obj.Shift,obj.DemultiplexResult.Spec,obj.DemultiplexResult.SpecFitting,obj.SpectraNumber);%输出光谱
    
    fileCoefficient = [resultPath,'Coefficient-',obj.SpectraFileNames];
    save_coefficient(fileCoefficient,obj.Probe,obj.DemultiplexResult.Coefficient(1:size(obj.Reference,2),:));
    
    fileStatisticCoefficient = [resultPath,'StatisticCoefficient-',obj.SpectraFileNames];
    save_StatisticCoefficient(fileStatisticCoefficient,obj.Probe,obj.DemultiplexResult.StatisticCoefficient)
end
% fid = fopen([resultPath,'Spectra.txt'],'w');
save([resultPath,'DemultiplexResult.mat'],'obj');

end


%%
%输出光谱
function save_spectra(file,shift,Spec,SpecFitting,N)
fid = fopen(file,'w');
if N==-1
    N = size(Spec,2);
else
    N = max(N,size(Spec,2));
end

SpectraOut = zeros(size(Spec,1),2*N+1);
SpectraOut(:,1) = shift;
        StrOut = 'Shift\t';
        for i = 1:N
            SpectraOut(:,i*2) = Spec(:,i);
            StrOut = [StrOut,num2str(i),'-Original\t'];
            SpectraOut(:,i*2+1) = SpecFitting(:,i);
            if i==N
                StrOut = [StrOut,num2str(i),'-Fitting\n'];
            else
                StrOut = [StrOut,num2str(i),'-Fitting\t'];
            end
        end
        fprintf(fid,StrOut);
        fprintf(fid,[repmat('%.3f\t', 1, size(SpectraOut,2)), '\n'], SpectraOut'); 
        fclose(fid);
end
%输出Coefficient
function save_coefficient(file,Probe,Coefficient)
fid = fopen(file,'w');
StrOut = '';
for i = 1:length(Probe)
    if i ==length(Probe)
        StrOut = [StrOut,Probe{i},'\n'];
    else
        StrOut = [StrOut,Probe{i},'\t'];
    end
end
fprintf(fid,StrOut);
fprintf(fid,[repmat('%.5f\t', 1, size(Coefficient,1)), '\n'],Coefficient);
fclose(fid);
end

%%
function save_StatisticCoefficient(file,Probe,StatisticCoefficient)

fid = fopen(file,'w');
StrOut = '';
for i = 1:length(Probe)
    if i ==length(Probe)
        StrOut = [StrOut,Probe{i},'\n'];
    else
        StrOut = [StrOut,Probe{i},'\t'];
    end
end
fprintf(fid,StrOut);
fprintf(fid,[repmat('%.5f\t', 1, size(StatisticCoefficient,1)), '\n'],StatisticCoefficient);
fclose(fid);

end