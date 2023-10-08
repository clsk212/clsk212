%%%% GETSIAMESEBATCH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Extracción de una muestra del dataset
%
%%%% INPUT:
%
%   - imds ------------> ImageDataStore ----> Dataset de pares de plagio
%   - miniBatchSize ---> Int ---------------> Tamaño de la muestra
%
%%%% OUTPUT:
%
%   - X1 --------------> Array -------------> Imagen 1
%   - X2 --------------> Array -------------> Imagen 2
%   - pairLabels ------> Array -------------> Etiqueta del par
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X1,X2,pairLabels] = getSiameseBatch(imds,miniBatchSize)

    % Definición de parámetros
    pairLabels = zeros(1,miniBatchSize);
    imgSize = size(readimage(imds,1));
    X1 = zeros([imgSize 1 miniBatchSize],"single");
    X2 = zeros([imgSize 1 miniBatchSize],"single");
    
    for i = 1:miniBatchSize

        % Selección aleatoria entre par con plagio o sin plagio
        choice = rand(1);
        if choice < 0.5
            [pairIdx1,pairIdx2,pairLabels(i)] = getSimilarPair(imds.Labels);
        else
            [pairIdx1,pairIdx2,pairLabels(i)] = getDissimilarPair(imds.Labels);
        end
        
        X1(:,:,:,i) = imds.readimage(pairIdx1);
        X2(:,:,:,i) = imds.readimage(pairIdx2);
    end

end