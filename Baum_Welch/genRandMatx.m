function [output] = genRandMatx(m)
%GENRANDMATX ����һ��������󣬲���ÿ�����Ϊ1
output=rand(m);
for i=1:m
    output(i,:)=output(i,:)./sum(output(i,:));
end

end

