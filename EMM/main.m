close all; clc; clear all;

%% �������� Ŀǰ����������ά��
R1=mvnrnd([1,2.25],[1.75,1;1,1.75],30);
R2=mvnrnd([12.9,10.3],[3.2,1.25;1.25,3.2],70);

Y=[R1;R2];
plot(R1(:,1),R1(:,2),'ro'); hold on;
plot(R2(:,1),R2(:,2),'bo');hold on;
% plot(Y(:,1),Y(:,2),'r+');hold on;

M=2; % ���˹ģ�ͣ��˴�Ϊ˫��˹ģ��
T=300; % ��������
[alpha,mu,sigma]=EMM(Y,M,T);
color={'r','b'};
for m=1:M
    error_ellipse(sigma(:,:,m), mu(m,:)', 'style', color{m}); hold on
end