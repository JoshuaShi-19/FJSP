function trans_time=cal_trans_time(job2mac_serial)
global mac_loc;
global v_AGV
if length(job2mac_serial)==1
    dist=pdist([mac_loc(job2mac_serial(1),:);0,0]);
else
    dist=pdist([mac_loc(job2mac_serial(end),:);mac_loc(job2mac_serial(end-1),:)]);
end
trans_time=dist/v_AGV;