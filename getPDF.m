function [output] = getPDF(y,mu,sigma)
%GETPDF �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

    [M,N]=size(y);
    output=mvnpdf(y,mu,sigma);
end

