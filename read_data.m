function [job,mac_num]=read_data(file_name)
data_job=xlsread(file_name,1);
job=cell(1,size(data_job,2)/2);
for i=1:2:size(data_job,2)
    for j=1:size(data_job,1)
        if ~ismissing(data_job(j,i))
            job{(i+1)/2}{j}=data_job(j,i:i+1);
        end
    end
end
mac_num=xlsread(file_name,2);