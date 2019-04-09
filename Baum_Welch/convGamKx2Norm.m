function [gamma,kx] = convGamKx2Norm(logGamma,logKx)
%CONVGAMKX2NORM ��logGamma��logKxȥ��log
%   logGamma:K*N
%   logKx:K*K*N

[K,N] = size(logGamma);
gamma=zeros(K,N); % ����ģ�ͺ͹۲����У���ʱ��t����ĳ��״̬�ĸ��� ��ͨ��
kx=zeros(K,K,N); % ����ģ�ͺ͹۲����У���ʱ��t����ĳ��״̬����ʱ��t+1ʱ�̴���ĳ��ʱ�̵ĸ��� ��ͨ��

for k=1:K
    maxGamma=0;
    maxKx=0;
    for n=1:N
        maxGamma=max(logGamma(k,:));
        maxKx=max(reshape(logKx(k,:,:), K*(N-1), 1));
    end
    logGamma(k,:)=logGamma(k,:)-maxGamma;
    logKx(k,:)=logKx(k,:)-maxKx;
end

gamma=exp(logGamma);
kx=exp(logKx);

end

