%%%% BINARYCROSSENTROPY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  · Cáclulo de la pérdida media de la muestra
%
%%%% INPUT:
%
%   - Y -----------> Double --------> Probabilidad del plagio
%   - pairLabels --> Array ---------> Etiquetas de plagio
%
%%%% OUTPUT:
%
%   - loss --------> Double --------> Pérdida media de la muestra
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function loss = binarycrossentropy(Y,pairLabels)

    % Cálculo de la precisión de la predicción
    precision = underlyingType(Y);

    % Si la precisión es menor que un epsilon fijo, se le asigna el valor
    % de epsilon, y si es mayor que 1-epsilon, se le asigna 1-epsilon.
    Y(Y < eps(precision)) = eps(precision);
    Y(Y > 1 - eps(precision)) = 1 - eps(precision);
    
    % Cálculo binario de la pérdida crossentropy
    loss = -pairLabels.*log(Y) - (1 - pairLabels).*log(1 - Y);
    
    % Cálculo de la pérdida media en la muestra
    loss = sum(loss)/numel(pairLabels);

end