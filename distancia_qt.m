% distancia entre minucia de consulta y minucia de template
function [Vault_indice,Real_minucia]=distancia_qt(T,Q, delta2, beta)

LQ=size(Q,1);  %% El número de minucia de huella de consulta
LT=size(T,1);  %% El número de minucia de huella de template


k=1;
for i=1:LT
    flag=0;
    for j=1:LQ
        if dist_qt(T(i,:),Q(j,:),beta)<delta2
            flag=1;
            break;
        end
    end
    
    if flag==1
        Real_minucia(k,:)=T(i,:);
        Vault_indice(k,:)=i;
        k=k+1;
    end
    
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function distancia=dist_qt(Te,Qe,beta)

   D1=dist_ec(Te(1:2),Qe(1:2));
   D2=abs(Te(3)-Qe(3))*beta;
   distancia=D1+D2;
end
