function [c] = vq_lbg(x,lamda,dv,N)
%LBG �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

k=size(x,2);
M=size(x,1);

%% Splitting
c=1/M*sum(x,1); % 1*k

D0=inf;
P=zeros(M,1); % ��Ϊ����������ֻ��¼�±�����ֵ ��һ��ֵ��N�е��������ڶ�����M�е�����


for t=1:log2(N)
   c=[c*(1+dv);c*(1-dv)];
   while(1==1)
        for m=1:M
            pre_dis=inf;
            idx=1;
            for i=1:size(c,1)
                dis=sum(abs(x(m,:)-c(i,:)).^2);
                if pre_dis>dis
                    idx=i;
                    pre_dis=dis;
                end
            end
            P(m,1)=idx;   
        end

        for i=1:size(c,1)
            sums=zeros(1,k);
            nums=0;
            for j=1:M
                if P(j,1)==i
                    sums=sums+x(P(j,1),:);
                    nums=nums+1;
                end
            end
            if nums ~=0
                c(i,:)=sums./nums;
            end
        end

        D1=0;
        for i=1:M
            D1=D1+sum(abs(x(i,:)-c(P(i,1),:)).^2);
        end
        D1=D1/M;
        if (D0-D1)/D1<lamda
           break;
        end
        D0=D1;
    end
end

