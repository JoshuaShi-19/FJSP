%输入种群数量
%输出初始化的种群编码
%编码格式为前半为工件编码
%后半为机器编码，机器编码按顺序随机取，比如[1,2,1]即为第一个工件的1-3工序分别在，其可以加工的机器中的第1，2，1个
function pop=inipop(pop_size)
global mac_num;
global job;
pool=[];%比如1好工件有6个工序，2号工件5个，则pool为[6个1，5个2]，工件编码将pool随机排列即可
pop=[];
for i=1:length(job)
    pool=[pool,i*ones(1,length(job{i}))];
end
for i=1:pop_size
    %生成工件编码
    code_job=pool(randperm(length(pool)));
    %生成机器编码
    code_mac=[];
    for j=1:length(job)
        for k=1:length(job{j})
            code_mac(end+1)=randi([1,mac_num(job{j}{k}(2))]);
        end
    end
    pop(end+1,:)=[code_job,code_mac];
end