
%%%% FEATURE_CONCAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Concatenación de las características principales de un elemento 
%
%%%% INPUT:
%
%   - data -------> Table -----> Tabla con información sobre los audios
%   - i ----------> Int -------> Número de iteración
%   - filepath ---> String ----> Path con las imagenes características
%   - pairpath ---> String ----> Path con los pares de imagenes caract.
%   - var --------> Int -------> Numero de variación (0 si original)
%
%%%% OUTPUT:
%
%   ** Genera la imagen característica y la guarda en jpg.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function feature_concat(data,i,filepath,pairpath,var)
   
    song = data.nombre(i);
    
    % Lectura de características
    A = imread(fullfile(filepath,"espectrograma_mel.jpg"));
    B = imread(fullfile(filepath,"histograma.jpg"));
    C = imread(fullfile(filepath,"zero_crossing_rate.jpg"));
    D = imread(fullfile(filepath,"root_mean_square_energy.jpg"));
    
    % Redimensionado de las características para su concatenación
    M = min([size(A,1),size(B,1),size(C,1),size(D,1)]); 
    N = min([size(A,2),size(B,2),size(C,2),size(D,2)]);  
    A_resized = imresize(A,[M,N]);
    B_resized = imresize(B,[M,N]);
    C_resized = imresize(C,[M,N]);
    D_resized = imresize(D,[M,N]);

    % Concatenación de características en cuadrícula
    fila_sup = [A_resized, B_resized];
    fila_inf = [C_resized, D_resized];
    caracteristicas = [fila_sup; fila_inf];
    feat = imresize(caracteristicas,[262,350]);
    imshow(feat)

    % Guardado de las características concatenadas en 'features':
    imwrite(feat,fullfile(filepath,'features_concat.jpg'));

    % Guardado de las características concatenadas en 'pair':
    if var==0 
        featname = strcat('features_',song,'.jpg'); 
        imwrite(feat,fullfile(pairpath,featname));
    else
        var_str = string(var);
        featname = strcat('features_',song,'_var_',var_str,'.jpg''.jpg'); 
        imwrite(feat,fullfile(pairpath,featname));
    end
end
    
   