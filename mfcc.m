function [Output] = mfcc(data,framelength,keepedCoeffs,filterNums,lowFreq,highFreq,fs,time)
%MFCC �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ����ÿ��ֻ��ȡtime��ʱ��
data=data(1:fs*time,1);
% data=data./max(abs(data)); % ����һ�ι�һ��
% data=data-mean(data); % ����ֱ������
% ֡����
% framelength=512;
% �ص����䳤��
overlap=framelength/2;
% �������µ�ϵ������
%keepedCoeffs=12;
% ���ݳ���,�ܳ���
datalength=size(data,1);
% �������������0
Nblock=ceil((datalength-overlap)/overlap);
% DFTʹ�õĴ���������
win=hamming(framelength);
% ���֡
xbuf=zeros(framelength,1);
% DFT��֡���ȣ����ڸ���Ҷ�任����и�����������ԣ�����ֻȡһ��+1��������鿴����Ҷ�任
Xbuf=zeros(framelength/2+1,1);
% ������
P=zeros(framelength/2+1,1);
% �½�ֹƵ��
%lowFreq=300;
% �Ͻ�ֹƵ��
%highFreq=fs/2;
% �˲��������˲�������
%filterNums=26; 
% ��ҪfilterNums��Ƶ������ô���������߼������� Ҳ����28����
points2Keeped=filterNums+2;
% ����Ƶ�ʼ���
fbins=zeros(points2Keeped,1);
% ȡlog֮���÷��������
melPower=zeros(filterNums,1);
% ���յ����
Output=zeros(Nblock,keepedCoeffs);
for i =1:Nblock
    % ��֡����
    xbuf(framelength/2+1:end)=data(framelength/2*(i-1)+1:i*framelength/2,1);
    % ����Ҷ�任+��
    tmp=fft(xbuf(:,1).'.*win.');
    % ��ǰ��+1����Xbuf��
    Xbuf(:,1)=tmp(1:framelength/2+1);
    % ������
    P(:,1)=power(abs(Xbuf(:,1)),2)./(framelength/2+1);
    % ÷��ӳ��
    mels=mfcc_melmap((lowFreq:highFreq).');
    m=linspace(mels(1),mels(end),points2Keeped);
    % ÷����ӳ��ص���׼Ƶ��
    h=mfcc_inv_melmap(m.');
    % ȷ��������Ҫ���Ƶ����ӽ���bin
    fbins=floor(framelength/fs.*h+(h./fs));
    % �˲�����
    fbanks=mfcc_filterBanks(filterNums,fbins,framelength);%.*(fs/framelength);
%     for x=1:26
%         plot((1:framelength/2+1).*(fs/framelength),abs(fbanks(x,:)));
%         hold on;
%     end
    % �Թ�����Ӧ���˲�����
    for n=1:filterNums
        melPower(n,1)=log10(fbanks(n,:)*P(:,1));
    end
    % ��ɢ���ұ任
    mels=mfcc_dct2(melPower,filterNums,keepedCoeffs);
    % �ѽ����������������
    Output(i,:)=mels.';
    xbuf(1:framelength/2)=xbuf(framelength/2+1:end);
end

% Output=abs(Output);

end

