function [a,b,alpha] = BaumWelch(K,Y,T)
%BAUMWELCH HMMѵ����֮Baum-Welch
%   mu:K*D,sigma:D*D*K,alpha:K*1
%   K:״̬�ĸ���
%   mu:��˹���ģ�͵ľ�ֵ
%   sigma:��˹���ģ�͵�Э�������
%   alpha:��˹���ģ�͵ĳ�ʼ���ʷֲ�
%   times:��������

[N,D]=size(Y);
times=200; % GMM��������
% GMM�����������
%  [~,mu,sigma] = Gmm(Y, K, 'diag');
[alpha,mu,sigma]=EMM(Y,K,times); % mu:K*D,sigma:D*D*K,alpha:K*1
for k=1:K
    sigma(:,:,k)=diag(diag(sigma(:,:,k)));
end

 
% color={'r','b'};
% for m=1:K
%     error_ellipse(sigma(:,:,m), mu(m,:)', 'style', color{m}); hold on 
% end

%% ��ʼ��ת�ƾ���a���������b����ʼ���ʷֲ�alpha
a=genRandMatx(K);
b=zeros(K,N); %���ڵ�ģ����һ�����Ӧһ������˹
for k=1:K
    for n=1:N
        b(k,n)=mvnpdf(Y(n,:),mu(k,:),sigma(:,:,k));
    end
end

% c=zeros(K,N);
% b = Gauss_logp_xn_given_zn(Y,mu.',sigma);

%% Baum-Welch�㷨�׶�
for t=1:T
    
    % 1.ǰ���㷨 ��ʼ���������pObs��ֵ�������⣬�Ⱥ��濪ʼ�������ٹ۲�
    [forPro]=forwardAlg(K,Y,a,b,alpha); % forPro:K*N pObs_1:1*1
%     [forPro,logc]=forwardAlgLog(K,Y,a,b,alpha);

    % 2.�����㷨
    [bakPro]=backwardAlg(K,Y,a,b); % forPro:K*N p_obs_2:1*1 
%     [bakPro]=backwardAlgLog(K,Y,a,b,logc);

    % 3.�����������ҳ�֮Ϊ���ɸ���
%     logGamma=zeros(K,N); % ����ģ�ͺ͹۲����У���ʱ��t����ĳ��״̬�ĸ��� log��
%     logKx=zeros(K,K,N); % ����ģ�ͺ͹۲����У���ʱ��t����ĳ��״̬����ʱ��t+1ʱ�̴���ĳ��ʱ�̵ĸ��� log��
    gamma=zeros(K,N);
    kx=zeros(K,N);
    
    % calculate loggamma
%     logGamma = forPro + bakPro;
    
    % calculate logksi
%     for n = 2:N
%         logKx(:,:,n) = -logc(n) + bsxfun(@plus, bsxfun(@plus, log(a), forPro(:,n-1)), log(b(:,n)) + bakPro(:,n));
%     end
%     logKx(:,:,1) = [];
%     
%     [gamma,kx]=convGamKx2Norm(logGamma,logKx);

    com=zeros(N,1); % ͨ�ü��㲿��
    % ��������������ĳ˷���ɵģ����ڿ��Ըĳɾ�����ʽ
    for n=1:N-1
        for i=1:K
            for j=1:K
                com(n,1)=com(n,1)+forPro(i,n)*a(i,j)*mvnpdf(Y(n+1,:),mu(j,:),sigma(:,:,j))*bakPro(j,n+1);
            end
        end
    end
    
    % ����� 
    for i=1:K
        for j=1:K
            for n=1:N-1
                kx(i,j,n)=forPro(i,n)*a(i,j)*mvnpdf(Y(n+1,:),mu(j,:),sigma(:,:,j))*bakPro(j,n+1)./com(n,1);
            end
        end
    end
    
    % ��٤��
    for i=1:K
        for n=1:N-1
            gamma(i,n)=sum(kx(i,:,n));
        end
    end
    gamma(K,N)=forPro(K,N)/sum(forPro(:,N).');
    
%     % ��ʼ��������
%     % 1) ��ʼ���ʷֲ�����
    for i=1:K
        alpha(i,1)=gamma(i,1);
    end
%     
%     
%     % 2) ״̬ת�Ƹ��ʵ���
    for i=1:K
        for j=1:K
            a(i,j)=sum(kx(i,j,:))./sum(gamma(i,:));
        end
    end
%     
% 
%     % 3) ������ʾ������
    for j=1:K
        for n=1:N
            b(j,n)=gamma(j,n)/sum(gamma(j,:)); % ��������ĸ��´������⡣
        end
    end
    
end

end

