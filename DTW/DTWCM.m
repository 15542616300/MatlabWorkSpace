function [dtw] = DTWCM(ref,seq)
%   DTWCM:cost matrix���� ��̬ʱ��滮
%   ref:������ɢʱ������
%   seq:����Ա�ʱ������
m=size(ref,2);
n=size(seq,2);


dtw=zeros(m,n);

dtw(1,1)=0;
for i=2:m
    dtw(i,1)=dtw(i-1,1)+dist(ref(i-1),seq(1));
end

for j=2:n
    dtw(1,j)=dtw(1,j-1)+dist(ref(1),seq(j-1));
end

for i=2:m
    for j=2:n
        dtw(i,j)=dist(ref(i),seq(j))+min(dtw(i-1,j),min(dtw(i-1,j-1),dtw(i,j-1)));
    end
end


end

