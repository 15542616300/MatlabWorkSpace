function [bita] = backwardAlg(K,Y,a,b)
%BACKWARDALG �����㷨
%   a:ת�Ƹ���
%   b:K*N
%   phi:��ʼ���ʷֲ�
[N,~]=size(Y);
bita=zeros(K,N);
bita(:,N)=1; % �������
threhold=10e-4;

for n=N-1:-1:1
    for i=1:K
        tmp=0;
        for j=1:K
            tmp=tmp+a(i,j)*b(j,n+1)*bita(j,n+1);
        end
        bita(j,n)=tmp;
        if bita(j,n)<threhold
           bita(j,n)=threhold;
        end
    end
end

end

