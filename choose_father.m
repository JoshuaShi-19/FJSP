%��ѡ�񡱲���  
function father_pool=choose_father(pop,pop_size)  
[p,best_time,best_pop_n]=choose_prob(pop);
father_pool=[];
for i=1:pop_size
   r=rand;  %����һ�������  
   prand=p-r;  
   j=1;
   while prand(j)<0  
       j=j+1;  
   end  
   father_pool(end+1,:)=pop(j,:); %ѡ�и�������  
end
%��Ӣ���屣��
father_pool(ceil(rand*pop_size),:)=pop(best_pop_n,:);