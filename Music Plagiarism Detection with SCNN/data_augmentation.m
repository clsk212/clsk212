%%%% DATA_AUGMENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   · Generación de 5 variaciones de los audios (pith, volumen, ruido...)
%   · Extracción y concatenación de las características de cada variación.
%
%%%% INPUT:
%
%   - X ----------> Array -----> Vector de audio
%   - fs ---------> Int -------> Sampling rate (Hz)
%   - data -------> Table -----> Dataset
%   - i ----------> Int -------> Número de iteración
%   - pairpath ---> String ----> Path con los pares de imagenes caract.
%
%%%% OUTPUT:
%
%   ** Genera la imagen característica de las versiones y las guarda en jpg.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data_augmentation(X,fs,data,i,pairpath)
    
% Nombre de las canciones originales
    name = data.nombre(i);
    name = string(name);

    % Definición del aumentador de datos
    augmenter = audioDataAugmenter( ...
        "AugmentationMode","sequential", ...
        "NumAugmentations",5, ...
        ...
        "TimeStretchProbability",0.8, ...
        "SpeedupFactorRange", [1.3,1.4], ...
        ...
        "PitchShiftProbability",0, ...
        ...
        "VolumeControlProbability",0.8, ...
        "VolumeGainRange",[-5,5], ...
        ...
        "AddNoiseProbability",0, ...
        ...
        "TimeShiftProbability",0.8, ...
        "TimeShiftRange", [-500e-3,500e-3]);
    
    % Aumentación de datos
    data_var = augment(augmenter,X,fs);

    % Ajustes organizativos
    mkdir('augmentations',name)
    folderpath = "C:\2\TFG\TFG programa\augmentations\";
    filepath = strcat(folderpath,name);
    

    for j=1:5
        % Definir el numero de variación
        var = string(j);
        % Crear una carpeta para cada variación de cada elemento
        mkdir(filepath,var)
        filepath2 = strcat(filepath,"\");
        filepath3 = strcat(filepath2,var);
        data_var.AugmentationInfo(j);
        
        % Definir la variación asociada a la iteración y su vector tiempo
        % asociado (puede variar al modificarse la velocidad del audio)
        aug = data_var.Audio{j};
        N = length(aug);
        taug = (0:(numel(aug)-1))/fs;

        % Extracción de características con la función auxiliar feature_extraction
        feature_extraction(aug,taug,fs,N,filepath3);
        
        % Generación de la imagen característica del audio mediante la concatenación de las características extraidas previamente:
        feature_concat(data,i,filepath3,pairpath,j);
    end
end