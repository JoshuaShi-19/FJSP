%������Ⱥ����
%�����ʼ������Ⱥ����
%�����ʽΪǰ��Ϊ��������
%���Ϊ�������룬�������밴˳�����ȡ������[1,2,1]��Ϊ��һ��������1-3����ֱ��ڣ�����Լӹ��Ļ����еĵ�1��2��1��
function pop=inipop(pop_size)
global mac_num;
global job;
pool=[];%����1�ù�����6������2�Ź���5������poolΪ[6��1��5��2]���������뽫pool������м���
pop=[];
for i=1:length(job)
    pool=[pool,i*ones(1,length(job{i}))];
end
for i=1:pop_size
    %���ɹ�������
    code_job=pool(randperm(length(pool)));
    %���ɻ�������
    code_mac=[];
    for j=1:length(job)
        for k=1:length(job{j})
            code_mac(end+1)=randi([1,mac_num(job{j}{k}(2))]);
        end
    end
    pop(end+1,:)=[code_job,code_mac];
end