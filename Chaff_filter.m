%  Minucia Decoding, Coarse Filter, Minucia Matcher 
%  Remove minucia without correspondence 
%        parte (b) de la Fig. 5 
%  Filtro para eliminar mas o menos 80% de Chaff Points
%
function  [Ind_Vault,Real_minucia]=Chaff_filter(Vault,Q_minucia,NB_UVT, delta2, beta)


L1=size(Vault,1);
L2=size(Q_minucia,1);

X=Vault(:,1);  %%% Cancatenado con (u, v, th)

%%%%Recuperar valores originales de puntos (incluyendo Chaff points) %%%%%
%%%%%%%%%%%%%%%%%%%%% Minicia decoding 
bit1=NB_UVT(2)+NB_UVT(3);
bit2=NB_UVT(3);

Uq=fix(X/(2^bit1));
X2=X-Uq*(2^bit1);
Vq=fix(X2/2^bit2);
Thq=X2-Vq*(2^bit2);
T_minucia=[Uq,Vq,Thq];
%%%%%%%%%%%%% Filtro %%%%%%%%%%
[Ind_Vault,Real_minucia]=distancia_qt(T_minucia,Q_minucia, delta2, beta);







