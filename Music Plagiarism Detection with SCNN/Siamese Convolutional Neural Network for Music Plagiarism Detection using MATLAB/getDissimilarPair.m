%%%% GETDISSIMILARPAIR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Extracción de un par con la etiqueta de NO plagio
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

function  [pairIdx1,pairIdx2,label] = getDissimilarPair(classLabel)

    % Lista única de clases
    classes = unique(classLabel);
    
    % Elección aleatoria de una clase
    classesChoice = randperm(numel(classes),2);
    
    % Extracción de los indices de la clase elegida
    idxs1 = find(classLabel==classes(classesChoice(1)));
    idxs2 = find(classLabel==classes(classesChoice(2)));
    
    % Elección de dos imágenes aleatorias de la clase elegida
    pairIdx1Choice = randi(numel(idxs1));
    pairIdx2Choice = randi(numel(idxs2));
    pairIdx1 = idxs1(pairIdx1Choice);
    pairIdx2 = idxs2(pairIdx2Choice);
    
    % Marcamos que el par es plagio con un 0
    label = 0;

end