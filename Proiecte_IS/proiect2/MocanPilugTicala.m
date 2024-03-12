clear all
close all 
clc
load('iddata-12')
y_id=id.y;
x_id=id.u;
t_id=id_array(:,1);

subplot(2, 2, 1);
plot(t_id, y_id);
title("iesire identificare")

subplot(2,2,2)
plot(t_id, x_id);
title("intare identificare")

y_val=val.y;
x_val=val.u;
t_val=val_array(:,1);

subplot(2, 2, 3);
plot(t_val, y_val);
title("iesire validare")

subplot(2,2,4)
plot(t_val, x_val);
title("intrare validare")
MSE_vector_val = [];
MSE_vector_id = [];

for na = 1:5
    for nb = 1:5
        for m = 1:3
            n=length(y_id);

            max=nchoosek(m+na+nb, na+nb);
            phi_final=zeros(length(y_id), max);
            
            phi=zeros(n, na+nb);
            
            matrice_grad=zeros(2, max);
            
            for i=1:n   %pozitiile pe coloane 
                k=i-1;
                for j=1:na  %pozitiile pe linie
                    if k>0
                        phi(i,j)=-y_id(k);
                    end
                    k=k-1;
                       
                end
            end
            
            for i=1:n   %pozitiile pe coloane
                k=i-1;
                for j=(na+1):(nb+na)  %pozitiile pe linie
                    
                    if k>0
                        phi(i,j)=x_id(k);
                    end
                    k=k-1;
                       
                end
            end
            
            
            phi_final(:, 1)=1; %am initializat prima coloana cu 1
            aux=0;
            numar_coloane_completate=1;
            for i=1:m
               n=1; %nr elemente
                for j=1:(na+nb)
                    a=1+j+aux;
                    phi_final(:, a)=phi(:, j).^i; %initilizam urmatoarele coloane cu polinoame liniare
                    matrice_grad(1, a)=i;
                    matrice_grad(2, a)=nthprime(n);
                    numar_coloane_completate=numar_coloane_completate+1; %a cata coloana e completata
                    n=n+1;
            
                end
                aux=aux+(na+nb);
            end
            phi_final(:,end)=phi(:,1).*phi(:,2);
            for i=2:max %combinatiile pe care le incercam
                for j=(i+1):max%numar_coloane_completate %pornind de la urmatorul 
                    if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                       
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi && primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
                         
                    end
                end
            end
            teta=phi_final\y_id;
           % y_hat_id_pred = phi_final*teta;
           Y=zeros(1,max);
Y(max)=1;
for k=1:length(y_val)
i=1;
for k1=1:na
    if(k-k1>0)
        mat_de_1(i)=y_id(k-k1);
        i=i+1;
        
    else
        mat_de_1(i)=0;
        i=i+1;
        
    end
end
for k1=1:nb
    if(k-k1>0)
        mat_de_1(i)=x_id(k-k1);
        i=i+1;
    else
    mat_de_1(i)=0;
    i=i+1;
    end
end
% % %bucle in care am introdus y_val cu intarzieri si x_val cu intarzieri
% % %valori pe care le vom folosi in determinarea lui Y
i=i-1;
aux=0;
numar_coloane_completate=1;
matrice_grad=zeros(2, max);
n=1;
%mat_de_1
for ridicare_grad=1:m
        for fiecare_element=1:i
        Y(n)=mat_de_1(fiecare_element)^ridicare_grad;
        matrice_grad(1, n)=ridicare_grad; 
        matrice_grad(2, n)=nthprime(n);
        n=n+1;
        end
      %am folosit acelasi principiu ca la construirea matricei phi
end
for i=1:(max-1) %numarul coloanei
    for j=(i+1):(max-1) %pornind de la urmatorul 
        if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))

            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi && primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end


            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end

            new_number=matrice_grad(2,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(~primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end
             
        end
    end
end
y_hat_id_pred(k)=Y*teta;
end
            MSE_id=sum((y_hat_id_pred-y_id).^2)/length(y_id);
            MSE_vector_id = [MSE_vector_id, MSE_id];
        end
    end
end

[xid,indxid] = min(MSE_vector_id,[],'all','linear');

for na = 1:5
    for nb = 1:5
        for m = 1:3
            n=length(y_val);

            max=nchoosek(m+na+nb, na+nb);
            phi_final=zeros(n, max);
            
            phi=zeros(n, na+nb);
            
            matrice_grad=zeros(2, max);
            
            for i=1:n   %pozitiile pe coloane 
                k=i-1;
                for j=1:na  %pozitiile pe linie
                    if k>0
                        phi(i,j)=-y_val(k);
                       % k=k-1;
                    end
                    k=k-1;
                       
                end
            end
            
            for i=1:n   %pozitiile pe coloane
                k=i-1;
                for j=(na+1):(nb+na)  %pozitiile pe linie
                    if k>0
                        phi(i,j)=x_val(k);
                    end
                    k=k-1;
                end
            end
            
            
            phi_final(:, 1)=1; %am initializat prima coloana cu 1
            aux=0;
            numar_coloane_completate=1;
            for i=1:m
               n=1; %nr elemente
                for j=1:(na+nb)
                    a=1+j+aux;
                    phi_final(:, a)=phi(:, j).^i; %initilizam urmatoarele coloane cu polinoame liniare
                    matrice_grad(1, a)=i;
                    matrice_grad(2, a)=nthprime(n);
                    numar_coloane_completate=numar_coloane_completate+1; %a cata coloana e completata
                    n=n+1;
            
                end
                aux=aux+(na+nb);
            end
            phi_final(:,end)=phi(:,1).*phi(:,2);
            for i=2:max %combinatiile pe care le incercam
                for j=(i+1):max%numar_coloane_completate %pornind de la urmatorul 
                    if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                       
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi && primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
                         
                    end
                end
            end
            teta = phi_final\y_val;
            %y_hat_val_pred = phi_final * teta;
            Y=zeros(1,max);
Y(max)=1;
for k=1:length(y_val)
i=1;
for k1=1:na
    if(k-k1>0)
        mat_de_1(i)=y_val(k-k1);
        i=i+1;
        
    else
        mat_de_1(i)=0;
        i=i+1;
        
    end
end
for k1=1:nb
    if(k-k1>0)
        mat_de_1(i)=x_val(k-k1);
        i=i+1;
    else
    mat_de_1(i)=0;
    i=i+1;
    end
end
% % %bucle in care am introdus y_val cu intarzieri si x_val cu intarzieri
% % %valori pe care le vom folosi in determinarea lui Y
i=i-1;
aux=0;
numar_coloane_completate=1;
matrice_grad=zeros(2, max);
n=1;
%mat_de_1
for ridicare_grad=1:m
        for fiecare_element=1:i
        Y(n)=mat_de_1(fiecare_element)^ridicare_grad;
        matrice_grad(1, n)=ridicare_grad; 
        matrice_grad(2, n)=nthprime(n);
        n=n+1;
        end
      %am folosit acelasi principiu ca la construirea matricei phi
end
for i=1:(max-1) %numarul coloanei
    for j=(i+1):(max-1) %pornind de la urmatorul 
        if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))

            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi && primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end


            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end

            new_number=matrice_grad(2,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(~primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end
             
        end
    end
end
y_hat_val_pred(k)=Y*teta;
end
            MSE_val = sum((y_hat_val_pred-y_val).^2)/length(y_val);
            MSE_vector_val = [MSE_vector_val, MSE_val];
        end
    end
end

% am observat ca ultima combinatie e cea buna dpdv al erorii, deci afisam
% predictia pt na=nb=5, m=3
figure, plot(y_id), hold on, plot(y_hat_id_pred), legend('y id', 'y id predictie'), title('predictie identificare')
figure, plot(y_val), hold on, plot(y_hat_val_pred), legend('y val', 'y val predictie'), title('predictie validare')

[xval,indxval] = min(MSE_vector_val,[],'all','linear');
figure,plot(MSE_vector_id), hold on, plot(indxid,xid,'r*'), title('mse id predictie')
figure, plot(MSE_vector_val), hold on, plot(indxval,xval,'r*'), title('mse val predictie')


for na = 1:5
    for nb = 1:5
        for m = 1:3
            n=length(y_id);

            max=nchoosek(m+na+nb, na+nb);
            phi_final=zeros(length(y_id), max);
            
            phi=zeros(n, na+nb);
            
            matrice_grad=zeros(2, max);
            
            for i=1:n   %pozitiile pe coloane 
                k=i-1;
                for j=1:na  %pozitiile pe linie
                    if k>0
                        phi(i,j)=-y_id(k);
                    end
                    k=k-1;
                       
                end
            end
            
            for i=1:n   %pozitiile pe coloane
                k=i-1;
                for j=(na+1):(nb+na)  %pozitiile pe linie
                    
                    if k>0
                        phi(i,j)=x_id(k);
                    end
                    k=k-1;
                       
                end
            end
            
            
            phi_final(:, 1)=1; %am initializat prima coloana cu 1
            aux=0;
            numar_coloane_completate=1;
            for i=1:m
               n=1; %nr elemente
                for j=1:(na+nb)
                    a=1+j+aux;
                    phi_final(:, a)=phi(:, j).^i; %initilizam urmatoarele coloane cu polinoame liniare
                    matrice_grad(1, a)=i;
                    matrice_grad(2, a)=nthprime(n);
                    numar_coloane_completate=numar_coloane_completate+1; %a cata coloana e completata
                    n=n+1;
            
                end
                aux=aux+(na+nb);
            end
            phi_final(:,end)=phi(:,1).*phi(:,2);
            for i=2:max %combinatiile pe care le incercam
                for j=(i+1):max%numar_coloane_completate %pornind de la urmatorul 
                    if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                       
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi && primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
                         
                    end
                end
            end
            teta=phi_final\y_id;
           % y_hat_id_sim = phi_final*teta;
           Y=zeros(1,max);
           y_hat_id_sim=zeros( length(y_id), 1);
Y(max)=1;
for k=1:length(y_val)
i=1;
for k1=1:na
    if(k-k1>0)
        mat_de_1(i)=y_hat_id_sim(k-k1);
        i=i+1;
        
    else
        mat_de_1(i)=0;
        i=i+1;
        
    end
end
for k1=1:nb
    if(k-k1>0)
        mat_de_1(i)=x_id(k-k1);
        i=i+1;
    else
    mat_de_1(i)=0;
    i=i+1;
    end
end

i=i-1;
aux=0;
numar_coloane_completate=1;
matrice_grad=zeros(2, max);
n=1;
for ridicare_grad=1:m
        for fiecare_element=1:i
        Y(n)=mat_de_1(fiecare_element)^ridicare_grad;
        matrice_grad(1, n)=ridicare_grad; 
        matrice_grad(2, n)=nthprime(n);
        n=n+1;
        end
end
for i=1:(max-1) %numarul coloanei
    for j=(i+1):(max-1) %pornind de la urmatorul 
        if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))

            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi && primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end


            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end

            new_number=matrice_grad(2,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(~primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end
             
        end
    end
end
y_hat_id_sim(k)=Y*teta;
end
            MSE_id=sum((y_hat_id_sim-y_id).^2)/length(y_id);
            MSE_vector_id = [MSE_vector_id, MSE_id];
        end
    end
end

[xid,indxid] = min(MSE_vector_id,[],'all','linear');

for na = 1:5
    for nb = 1:5
        for m = 1:3
            n=length(y_val);

            max=nchoosek(m+na+nb, na+nb);
            phi_final=zeros(n, max);
            
            phi=zeros(n, na+nb);
            
            matrice_grad=zeros(2, max);
            
            for i=1:n   %pozitiile pe coloane 
                k=i-1;
                for j=1:na  %pozitiile pe linie
                    if k>0
                        phi(i,j)=-y_val(k);
                       % k=k-1;
                    end
                    k=k-1;
                       
                end
            end
            
            for i=1:n   %pozitiile pe coloane
                k=i-1;
                for j=(na+1):(nb+na)  %pozitiile pe linie
                    if k>0
                        phi(i,j)=x_val(k);
                    end
                    k=k-1;
                end
            end
            
            
            phi_final(:, 1)=1; %am initializat prima coloana cu 1
            aux=0;
            numar_coloane_completate=1;
            for i=1:m
               n=1; %nr elemente
                for j=1:(na+nb)
                    a=1+j+aux;
                    phi_final(:, a)=phi(:, j).^i; %initilizam urmatoarele coloane cu polinoame liniare
                    matrice_grad(1, a)=i;
                    matrice_grad(2, a)=nthprime(n);
                    numar_coloane_completate=numar_coloane_completate+1; %a cata coloana e completata
                    n=n+1;
            
                end
                aux=aux+(na+nb);
            end
            phi_final(:,end)=phi(:,1).*phi(:,2);
            for i=2:max %combinatiile pe care le incercam
                for j=(i+1):max%numar_coloane_completate %pornind de la urmatorul 
                    if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                       
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi && primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j)^matrice_grad(1,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
            
                        new_number=matrice_grad(2,i)*matrice_grad(2,j);
                        contains = any(matrice_grad(2, :) == new_number);
                        primi=isprime(matrice_grad(2,i));
                        primj=isprime(matrice_grad(2,j));
                        if(~primi&&~primj)
                        if(~contains)
                        phi_final(:, numar_coloane_completate+1)=phi_final(:, i).*phi_final(:,j);
                        matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
                        matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
                        numar_coloane_completate=numar_coloane_completate+1;
                        end
                        end
                         
                    end
                end
            end
            teta = phi_final\y_val;
            %y_hat_val_sim = phi_final * teta;
            Y=zeros(1,max);
            y_hat_val_sim=zeros(length(y_val), 1);
Y(max)=1;
for k=1:length(y_val)
i=1;
for k1=1:na
    if(k-k1>0)
        mat_de_1(i)=y_hat_val_sim(k-k1);
        i=i+1;
        
    else
        mat_de_1(i)=0;
        i=i+1;
        
    end
end
for k1=1:nb
    if(k-k1>0)
        mat_de_1(i)=x_val(k-k1);
        i=i+1;
    else
    mat_de_1(i)=0;
    i=i+1;
    end
end
i=i-1;
aux=0;
numar_coloane_completate=1;
matrice_grad=zeros(2, max);
n=1;
%mat_de_1
for ridicare_grad=1:m
        for fiecare_element=1:i
        Y(n)=mat_de_1(fiecare_element)^ridicare_grad;
        matrice_grad(1, n)=ridicare_grad; 
        matrice_grad(2, n)=nthprime(n);
        n=n+1;
        end
end
for i=1:(max-1) %numarul coloanei
    for j=(i+1):(max-1) %pornind de la urmatorul 
        if(matrice_grad(1,i)+matrice_grad(1,j)<=m && matrice_grad(1,i)>0 && matrice_grad(1,j)>0 && i~=j &&matrice_grad(2, j)~=matrice_grad(2, i))

            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi && primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j)^matrice_grad(1,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end


            new_number=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)^matrice_grad(1,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end

            new_number=matrice_grad(2,i)*matrice_grad(2,j);
            contains = any(matrice_grad(2, :) == new_number);
            primi=isprime(matrice_grad(2,i));
            primj=isprime(matrice_grad(2,j));
            if(~primi&&~primj)
            if(~contains)
            Y(numar_coloane_completate+1)=Y(i).*Y(j);
            matrice_grad(1,numar_coloane_completate+1)=matrice_grad(1,i)+matrice_grad(1,j);
            matrice_grad(2,numar_coloane_completate+1)=matrice_grad(2,i)*matrice_grad(2,j);
            numar_coloane_completate=numar_coloane_completate+1;
            end
            end
             
        end
    end
end
y_hat_val_pred(k)=Y*teta;
end
            MSE_val = sum((y_hat_val_pred-y_val).^2)/length(y_val);
            MSE_vector_val = [MSE_vector_val, MSE_val];
        end
    end
end
sys_id=iddata(y_id, x_id, t_id(2)-t_id(1));sys_val=iddata(y_val, x_val, t_val(2)-t_val(1));
sys_nlarx=iddata(y_hat_id_sim,x_id, t_id(2)-t_id(1));
compare(sys_nlarx, sys_val);title("simulare identificare")
sys_nlarx=iddata(y_hat_id_sim,x_val, t_val(2)-t_val(1));
compare(sys_nlarx, sys_val);title("simulare validare")


[xval,indxval] = min(MSE_vector_val,[],'all','linear');
figure,plot(MSE_vector_id), hold on, plot(indxid,xid,'r*'), title('mse id simulare')
figure, plot(MSE_vector_val), hold on, plot(indxval,xval,'r*'), title('mse val simulare')
