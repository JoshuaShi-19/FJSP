%����ĳ�����Ŀ�ʼʱ��ͽ���ʱ�䣨һά��
%������ʱ�䣨һά������1��2����ļ����ʼ�����û�м����Ϊ0
function [mac_start,mac_end,job_end_time,insert_pot]=insert_mac(mac_start,mac_end,job_start,job_end,job_time)
if length(mac_start)>=2
    for i=2:length(mac_start)
        mac_interval=mac_start(i)-mac_end(i-1);
        if mac_interval>=job_time && max(mac_end(i-1),job_start)+job_time<=mac_start(i)
            find_start=max(mac_end(i-1),job_start);
            mac_start=[mac_start(1:i-1),find_start,mac_start(i:end)];
            mac_end=[mac_end(1:i-1),find_start+job_time,mac_end(i:end)];
            job_end_time=find_start+job_time;
            insert_pot=i;
            return
        end        
    end
end
mac_start(end+1)=max([mac_end,job_end,0],[],'omitnan');
mac_end(end+1)=mac_start(end)+job_time;
job_end_time=mac_start(end)+job_time;
insert_pot=length(mac_start);