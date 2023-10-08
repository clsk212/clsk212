%%%% GETSIMILARPAIR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Extracción de un par con la etiqueta de plagio
%
%%%% INPUT:
%
%   - classLabel -------> Array -------> Vector con las clases (pares)
%
%%%% OUTPUT:
%
%   - pairIdx1 ---------> Int ---------> ID de la imagen 1 del par
%   - pairIdx2 ---------> Int ---------> ID de la imagen 2 del par
%   - pairLabel --------> Int ---------> 1 es plagio, 0 no plagio
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [pairIdx1,pairIdx2,pairLabel] = getSimilarPair(classLabel)

    % Lista única de clases
    classes = unique(classLabel);
    
    % Elección aleatoria de una clase
    classChoice = randi(numel(classes));
    classes(classChoice);
    
    % Extracción de los indices de la clase elegida
    idxs = find(classLabel==classes(classChoice));
    
    % Elección de dos imágenes aleatorias de la clase elegida
    pairIdxChoice = randperm(numel(idxs),2);
    pairIdx1 = idxs(pairIdxChoice(1));
    pairIdx2 = idxs(pairIdxChoice(2));
    
    % Marcamos que el par es plagio con un 1
    pairLabel = 1;

end