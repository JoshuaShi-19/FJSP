function the_mac=find_job_mac(job_serial,n,code)
global job;
global mac;
the_mac_type=job{job_serial(1)}{job_serial(2)}(2);
job_in_mac_code=0;
for j=1:job_serial(1)-1
    job_in_mac_code=job_in_mac_code+length(job{j});
end
job_in_mac_code=job_in_mac_code+job_serial(2)+n;
the_mac=mac{the_mac_type}(code(job_in_mac_code));