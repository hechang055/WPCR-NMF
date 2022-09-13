function label = load_name(obj, file ,varargin)

    if mod(length(varargin),2)>0
        error('please ensure the number of parameters is even.')
    end
    
    for i = 1:2:length(varargin)
        switch varargin{i}
            case 'LabelL'
                obj.SeperateCharacter.LabelL = varargin{i+1};
            case 'LabelR'
                obj.SeperateCharacter.LabelR = varargin{i+1};
        end
    end
    
    index = zeros(1,2);
    index(1) = strfind(file,obj.SeperateCharacter.LabelL);
    index(2) = strfind(file,obj.SeperateCharacter.LabelR);
    
    label = str2double(file(index(1)+1:index(2)-1));
    
end