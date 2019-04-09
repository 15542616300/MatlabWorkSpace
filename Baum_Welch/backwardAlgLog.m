function [bita] = backwardAlgLog(K,Y,a,b,logc)
%BACKWARDALG �����㷨
%   a:ת�Ƹ��� K*K
%   b:K*N
%   phi:��ʼ���ʷֲ�
[N,~]=size(Y);
bita=zeros(K,N);
bita(:,N)=0; % ������� ��Ϊlog1=0


for n=N-1:-1:1
    for i=1:K
        tmp = bita(:,n+1) + log(b(:,n+1)) + log(a(:,i));
        bita(i,n) = -logc(n+1) + log( sum( exp( tmp - max(tmp) ) ) ) + max(tmp);
    end
end

end

