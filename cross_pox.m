function child=cross_pox(father_pool,pc)
global job;
job_n=length(job);
job_length=size(father_pool,2)/2;
child=zeros(size(father_pool));
for i=1:2:size(father_pool,1)
    if rand<pc
        %job�ν���
        cross_job=find(rand(1,job_n)>0.5);
        while length(cross_job)==job_n || isempty(cross_job)%����Ĺ�������Ϊȫ�����������൱�ڶ��߻���λ�ã��޽��湤�����൱��û�н���
            cross_job=find(rand(1,job_n)>0.5);
        end
        k1=1;%ָ�룬k1����child1��father2��ȡ����
        k2=1;
        for j=1:job_length
            if ismember(father_pool(i,j),cross_job)
                child(i,j)=father_pool(i,j);
            else
                while ismember(father_pool(i+1,k1),cross_job)
                    k1=k1+1;
                end
                child(i,j)=father_pool(i+1,k1);
                k1=k1+1;
            end
            if ismember(father_pool(i+1,j),cross_job)
                child(i+1,j)=father_pool(i+1,j);
            else
                while ismember(father_pool(i,k2),cross_job)
                    k2=k2+1;
                end
                child(i+1,j)=father_pool(i,k2);
                k2=k2+1;
            end
        end
        %mac�ν���
%         mac_cross=rand(1,job_length)>0.5;
%         child(i,mac_cross)=father_pool(i,mac_cross);
%         child(i+1,mac_cross)=father_pool(i+1,mac_cross);
%         child(i,mac_cross)=father_pool(i+1,mac_cross==0);
%         child(i+1,mac_cross)=father_pool(i,mac_cross==0);
        for j=job_length+1:job_length*2
            if rand>0.5
                child(i,j)=father_pool(i,j);
                child(i+1,j)=father_pool(i+1,j);
            else
                child(i,j)=father_pool(i+1,j);
                child(i+1,j)=father_pool(i,j);
            end
        end
    else
        child(i,:)=father_pool(i,:);
        child(i+1,:)=father_pool(i+1,:);
    end
end
        
