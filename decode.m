%输入：解码
%输出：二维矩阵，行数i对应原编码中第i个元素，第一列对应工件，第二列对应该工件的工艺
function [max_mac_time,mac_serial,mac_start,mac_end,mac_trans_start_time,job2mac_serial]=decode(code)
global mac_num;
global job;
global mac;
n=length(code)/2;%工序总数量
%解码生成工作序列，二维矩阵，第i行为编码的第i个工序，第一列为工件代号，第二列为工序代号
job_serial=[];
for i=1:n
    job_serial(end+1,:)=[code(i),sum(code(1:i)==code(i))];
end
%解码生成机器序列，元胞组，组内第i个元胞组为机器代号，内部是按照先后顺序的工序向量，工序格式为job_serial格式
%解码生成机器各工序开始、结束时间，工件开始、结束时间
job2mac_serial=cell(1,length(job));
job_start=cell(1,length(job));
job_end=cell(1,length(job));
mac_serial=cell(1,sum(mac_num));
mac_trans_start_time=cell(1,sum(mac_num));
mac_start=cell(1,sum(mac_num));
mac_end=cell(1,sum(mac_num));
for i=1:n
    %此部分求出第i号工序加工机器:the_mac
    the_mac=find_job_mac(job_serial(i,:),n,code);
    job2mac_serial{job_serial(i,1)}(end+1)=the_mac;
    trans_time=cal_trans_time(job2mac_serial{job_serial(i,1)});
%     job_trans_time{job_serial(i,1)}(end+1)=trans_time;
    %求出工件开始时间（不是真正的开始时间）
    if job_serial(i,2)==1
        job_start{job_serial(i,1)}(1)=[trans_time];
    else
        job_start{job_serial(i,1)}(end+1)=job_end{job_serial(i,1)}(job_serial(i,2)-1)+trans_time;
    end
    %将第i个工序插入到机器中加工，如果机器间隔合适，插入间隔中，如不合适，插入到最后一位
    %有一个问题，jobserial没有调顺序，结构还待优化
    [mac_start{the_mac},mac_end{the_mac},job_end_time,insert_pot]=insert_mac(mac_start{the_mac},mac_end{the_mac},job_start{job_serial(i,1)}(job_serial(i,2)),job{job_serial(i,1)}{job_serial(i,2)}(1));
    mac_serial{the_mac}=[mac_serial{the_mac}(1:insert_pot-1,:);job_serial(i,:);mac_serial{the_mac}(insert_pot:end,:)];    
    job_end{job_serial(i,1)}(end+1)=job_end_time;
%     if insert_pot>1
    mac_trans_start_time{the_mac}=[mac_trans_start_time{the_mac}(1:insert_pot-1),mac_start{the_mac}(insert_pot)-trans_time,mac_trans_start_time{the_mac}(insert_pot:end)];
%     end
        
end
%求出机器最大完工时间
max_mac_time=0;
for i=1:sum(mac_num)
    if ~isempty(mac_end{i})
        max_mac_time=max(max_mac_time,max(mac_end{i}));
    end
end
