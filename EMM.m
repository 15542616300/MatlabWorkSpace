function [mu,sigma] = EMM(Y,K,times)
%EMM �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% y:ѵ������
% k:ģ�͸���
% times:��������

%% ������ʼ��
% ��Ҫ��������mu��sigma��alpha
[M,N]=size(Y); % M ��ʾ���ݸ�����N ��ʾά��
alpha=ones(K,1).*1/K; 
mu=rand(K,N);
sigma=eye(N).*K; 

resp=zeros(M,K);

%% �������
for t=1:times
    %% E���裬��ȡ��Ӧ��
    for k=1:K
        resp(:,k)=alpha(k,1).*getPDF(Y,mu(k,:),sigma);
    end
    for i=1:N
        resp(i,:)=resp(i,:)./sum(resp(i,:));
    end
    
    %% M���裬������һ�ֵ�����ģ�Ͳ���
    for k=1:K
      
       r_sum=sum(resp(:,k));
       mu(k,:)= sum(resp(:,k).'*Y(:,:))./r_sum;
       
       cov_k=zeros(N,N);
       for i=1:M
            cov_k=cov_k+resp(i,k)*((Y(i,:)-mu(k,:))'*(Y(i,:)-mu(k,:)))./r_sum;
       end
       sigma=cov_k;
       alpha(k,1)=r_sum/M;
    
    end
end

end

