function [delta,kx] = viterbi_decode(a,b,phi)
%VITERBI_DECODE ά�ر��㷨����
%   a:K*K ״̬ת�Ƹ��ʾ���
%   b:K*N ������ʾ���
%   phi:K*1 ��ʼ���ʷֲ�
[K,N]=size(b);

delta=zeros(N,K);
kx=zeros(N,1);

for k=1:K
    delta(1,k)=phi(k,1)*b(k,1);
    kx(1,1)=1;
end

for n=2:N    
   [delta(n,:),kx(n,1)]=max(delta(n-1,:)*a,[],2);
   delta(n,:)=delta(n,:).'.*b(:,n);
end

end

