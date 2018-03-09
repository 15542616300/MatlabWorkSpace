function [ newX ] = k_means( x,c )
%K_MEANS k-means��ֵ���� ��������ʹ�����Ͼ�����м���
%   x:���� ��ά
%   c:���ĸ���;
%   iter:��������(���ǵ����ĵ�һֱ������,��ʱ��ʹ��)
[charcs,datalength]=size(x);
U=zeros(c,charcs); % c�࣬ÿ��charcs������
LastU=zeros(c,charcs);
randIdx=randperm(datalength);
drawIdx=randIdx(1:c);
newX=[x;zeros(1,datalength)]; % �����б�ʾ���
for cIdx=1:c
    U(cIdx,:)=x(:,drawIdx(cIdx)).';
end
flag=0;
LastU=U;
canChange=1;
while flag~=1
    
    % ѭ������
    for n=1:datalength
        dOld=Inf;
        for cIdx=1:c
            dNew=norm(x(:,n).'-U(cIdx,:)).^2;
            if dOld>dNew % ���µĽϽ�
                newX(:,n)=[x(:,n);cIdx];
                dOld=dNew;
            else
                continue;
            end
        end
    end
    
%     newXWid=size(newX,1);
%     newXLen=size(newX,2);
    % ��ÿ������з���
    for cIdx=1:c
        % �ó�����Դ������
        classIdxs=find(newX(3,:)==cIdx);
        dataSet=zeros(charcs,length(classIdxs));
        dataSet(:,:)=newX(1:charcs,classIdxs);
        
        % ��������
        U_up=zeros(charcs,1);
        U_down=0;
        for len=1:length(dataSet)
            U_up=U_up+dataSet(:,len);
            U_down=U_down+1;
        end
        U(cIdx,:)=U_up.'./U_down;
        if LastU(cIdx,:)-U(cIdx,:)==zeros(1,charcs)
            if canChange==1
                flag=1;
            end
        else
            flag=0;
            canChange=0;
        end
    end
    LastU=U;
    canChange=1;
end


end

