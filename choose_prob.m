function [p,best_time,best_pop_n,max_time]=choose_prob(pop)
pop_scale=size(pop,1);  %读取种群大小  
max_time=zeros(pop_scale,1);  
for i=1:pop_scale  
   max_time(i)=decode(pop(i,:));  %计算函数值，即适应度  
end  
[best_time,best_pop_n]=min(max_time);
f=1./max_time'; %取距离倒数   
%根据个体的适应度计算其被选择的概率  
fsum=0;  
for i=1:pop_scale  
   fsum=fsum+f(i)^10;% 让适应度越好的个体被选择概率越高  
end  
ps=zeros(pop_scale,1);  
for i=1:pop_scale  
   ps(i)=f(i)^10/fsum;  
end   
%计算累积概率  
p=zeros(pop_scale,1);  
p(1)=ps(1);  
for i=2:pop_scale  
   p(i)=p(i-1)+ps(i);  
end  
p=p'; 