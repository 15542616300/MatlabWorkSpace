function [alpha] = forwardAlg(K,Y,a,b,phi)
%FORWARDALG ǰ���㷨 ��֪ģ�͵�����£����۲�����������P(O|lamada)
%   a:ת�Ƹ���
%   b:K*N
%   phi:��ʼ���ʷֲ�
[N,~]=size(Y);
alpha=zeros(K,N); % ǰ�����
threhold=10e-4;

for k=1:K
        alpha(k,1)=phi(k,1)*b(k,1);
end


for n=2:N
    for j=1:K
        tmp=0;
        for i=1:K
            tmp=tmp+alpha(i,n-1)*a(i,j);
        end
        alpha(j,n)=tmp*b(j,n);
        if alpha(j,n)<threhold
           alpha(j,n)=threhold;
        end
    end
end

end

