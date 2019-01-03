function child_mut=mutation_exchange(father_pool,pm)
global job;
global mac_num;
job_length=size(father_pool,2)/2;
for i=1:size(father_pool,1)
    if rand<pm
        job_mut_length=ceil((rand*0.1+0.1)*job_length);
        job_mut_pos=unique(ceil(rand(1,job_mut_length)*job_length));
        job_mut_code=father_pool(i,job_mut_pos);
        father_pool(i,job_mut_pos)=job_mut_code(randperm(length(job_mut_pos)));
        mac_mut_n=ceil((rand*0.1+0.1)*job_length);
        for j=1:mac_mut_n
            job_r=ceil(rand*length(job));
            job_l=ceil(rand*length(job{job_r}));
            mac_mut_pos=0;
            for k=1:job_r-1
                mac_mut_pos=mac_mut_pos+length(job{k});
            end
            mac_mut_code_pos=mac_mut_pos+job_l;
            mac_size=job{job_r}{job_l}(2);
            mac_mut_new=ceil(rand*mac_num(mac_size));
            father_pool(i,job_length+mac_mut_code_pos)=mac_mut_new;
        end
    end
end
child_mut=father_pool;
        
        
