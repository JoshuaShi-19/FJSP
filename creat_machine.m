%����������������
%���һ��һάԪ���飬��i��Ԫ����һ�����󣬴����˵�i�������ı�ţ����һ����������������mac{1}=[1,2,3]
function mac=creat_machine(mac_num)
num=0;
mac={};
for i =mac_num
    mac_serial=[];
    for j=1:i
        num=num+1;
        mac_serial=[mac_serial,num];
    end
    mac{end+1}=mac_serial;
end