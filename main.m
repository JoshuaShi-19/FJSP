clear
global mac_num;
global job;
global mac;
gnmax=50;%最大代数  
pc=0.8; %交叉概率  
pm=0.2; %变异概率
[job,mac_num]=read_data('data.xlsx');
mac=creat_machine(mac_num);
pop_size=10;
pop=inipop(pop_size);
best_time=[];
mean_time=[];
best_pop=[];
generation=1;
while generation<=gnmax
    father_pool=choose_father(pop,pop_size);
    child_cross=cross_pox(father_pool,pc);
    child_mut=mutation_exchange(child_cross,pm);
    [~,best_time(end+1),best_pop_n,f]=choose_prob(child_mut);
    mean_time(end+1)=mean(f);
    best_pop(end+1,:)=child_mut(best_pop_n,:);
    generation=generation+1;
end
[minst_time,minst_n]=min(best_time);
draw_gantt(best_pop(minst_n,:));
figure(2);  
plot(best_time,'r'); hold on;  
plot(mean_time,'b');grid;  
title('搜索过程');  
legend('最优解','平均解');  
fprintf('遗传算法得到的最短时间:%.2f\n',minst_time);  