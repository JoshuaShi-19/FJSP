%���룺����
%�������ά��������i��Ӧԭ�����е�i��Ԫ�أ���һ�ж�Ӧ�������ڶ��ж�Ӧ�ù����Ĺ���
function [max_mac_time,mac_serial,mac_start,mac_end,mac_trans_start_time,job2mac_serial]=decode(code)
global mac_num;
global job;
global mac;
n=length(code)/2;%����������
%�������ɹ������У���ά���󣬵�i��Ϊ����ĵ�i�����򣬵�һ��Ϊ�������ţ��ڶ���Ϊ�������
job_serial=[];
for i=1:n
    job_serial(end+1,:)=[code(i),sum(code(1:i)==code(i))];
end
%�������ɻ������У�Ԫ���飬���ڵ�i��Ԫ����Ϊ�������ţ��ڲ��ǰ����Ⱥ�˳��Ĺ��������������ʽΪjob_serial��ʽ
%�������ɻ���������ʼ������ʱ�䣬������ʼ������ʱ��
job2mac_serial=cell(1,length(job));
job_start=cell(1,length(job));
job_end=cell(1,length(job));
mac_serial=cell(1,sum(mac_num));
mac_trans_start_time=cell(1,sum(mac_num));
mac_start=cell(1,sum(mac_num));
mac_end=cell(1,sum(mac_num));
for i=1:n
    %�˲��������i�Ź���ӹ�����:the_mac
    the_mac=find_job_mac(job_serial(i,:),n,code);
    job2mac_serial{job_serial(i,1)}(end+1)=the_mac;
    trans_time=cal_trans_time(job2mac_serial{job_serial(i,1)});
%     job_trans_time{job_serial(i,1)}(end+1)=trans_time;
    %���������ʼʱ�䣨���������Ŀ�ʼʱ�䣩
    if job_serial(i,2)==1
        job_start{job_serial(i,1)}(1)=[trans_time];
    else
        job_start{job_serial(i,1)}(end+1)=job_end{job_serial(i,1)}(job_serial(i,2)-1)+trans_time;
    end
    %����i��������뵽�����мӹ����������������ʣ��������У��粻���ʣ����뵽���һλ
    %��һ�����⣬jobserialû�е�˳�򣬽ṹ�����Ż�
    [mac_start{the_mac},mac_end{the_mac},job_end_time,insert_pot]=insert_mac(mac_start{the_mac},mac_end{the_mac},job_start{job_serial(i,1)}(job_serial(i,2)),job{job_serial(i,1)}{job_serial(i,2)}(1));
    mac_serial{the_mac}=[mac_serial{the_mac}(1:insert_pot-1,:);job_serial(i,:);mac_serial{the_mac}(insert_pot:end,:)];    
    job_end{job_serial(i,1)}(end+1)=job_end_time;
%     if insert_pot>1
    mac_trans_start_time{the_mac}=[mac_trans_start_time{the_mac}(1:insert_pot-1),mac_start{the_mac}(insert_pot)-trans_time,mac_trans_start_time{the_mac}(insert_pot:end)];
%     end
        
end
%�����������깤ʱ��
max_mac_time=0;
for i=1:sum(mac_num)
    if ~isempty(mac_end{i})
        max_mac_time=max(max_mac_time,max(mac_end{i}));
    end
end
