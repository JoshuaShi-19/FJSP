function [p,best_time,best_pop_n,max_time]=choose_prob(pop)
pop_scale=size(pop,1);  %��ȡ��Ⱥ��С  
max_time=zeros(pop_scale,1);  
for i=1:pop_scale  
   max_time(i)=decode(pop(i,:));  %���㺯��ֵ������Ӧ��  
end  
[best_time,best_pop_n]=min(max_time);
f=1./max_time'; %ȡ���뵹��   
%���ݸ������Ӧ�ȼ����䱻ѡ��ĸ���  
fsum=0;  
for i=1:pop_scale  
   fsum=fsum+f(i)^10;% ����Ӧ��Խ�õĸ��屻ѡ�����Խ��  
end  
ps=zeros(pop_scale,1);  
for i=1:pop_scale  
   ps(i)=f(i)^10/fsum;  
end   
%�����ۻ�����  
p=zeros(pop_scale,1);  
p(1)=ps(1);  
for i=2:pop_scale  
   p(i)=p(i-1)+ps(i);  
end  
p=p'; 