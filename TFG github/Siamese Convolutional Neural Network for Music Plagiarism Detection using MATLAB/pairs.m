
%%%% PAIRS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Creación de un dataset con los pares
%
%%%% INPUT:
%
%   - data ---------> Table --------> Tabla data
%
%   - len ----------> Int ----------> Longitud de la tabla data
%
%
%%%% OUTPUT:
%
%   - datapairs ----> Table --------> Tabla con pares de plagio
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function datapairs = pairs(data, len)
    
    l = len;
    lentotal = l^2 - l;
    
    % Definicio-ón de variables
    nombre = strings(lentotal,1);
    grupo = zeros(lentotal,1);
    par  = zeros(lentotal,1);
    plagio = zeros(lentotal,1);
    
    % Definición de contadores
    cont = 1;
    paircont = 1;
    
    for i = 1:len
        for j = 1:len
            
            % Descartar pares de iguales:
            if j == i
                continue
            end
           
            % Pares correctos:
            if data.grupo(i) == data.grupo(j)
                nombre(cont) = data.nombre(i);
                grupo(cont) = data.grupo(i);
                par(cont) = paircont;
                plagio(cont) = 1;
    
                nombre(cont+1) = data.nombre(j);
                grupo(cont+1) = data.grupo(j);
                par(cont+1) = paircont;
                plagio(cont+1) = 1;
               
                cont = cont +2;
                paircont = paircont + 1;
            end
    
            % Pares incorrectos:
            if data.grupo(i) ~= data.grupo(j)
                nombre(cont) = data.nombre(i);
                grupo(cont) = data.grupo(i);
                par(cont) = paircont;
                plagio(cont) = 0;
    
                nombre(cont+1) = data.nombre(j);
                grupo(cont+1) = data.grupo(j);
                par(cont+1) = paircont;
                plagio(cont+1) = 0;
               
                cont = cont +2;
                paircont = paircont + 1;
    
            end
        end
    end
    
    datapairs = table(nombre,grupo,par,plagio);

end