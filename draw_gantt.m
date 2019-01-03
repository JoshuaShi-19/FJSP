%输入机器开始时间，结束时间，最大完工时间
%画出一个甘特图
function draw_gantt(code)
global mac_num;
global job;
[max_mac_time,mac_serial,mac_start,mac_end,mac_trans_start_time,job2mac_serial]=decode(code);
nb_mac=sum(mac_num);
axis([0,max_mac_time+5,0,nb_mac+0.5]);%x轴 y轴的范围
set(gca,'xtick',0:5:max_mac_time+5) ;%x轴的增长幅度
set(gca,'ytick',0:1:nb_mac+0.5) ;%y轴的增长幅度
xlabel('加工时间','FontName','微软雅黑','Color','b','FontSize',10)
ylabel('机器号','FontName','微软雅黑','Color','b','FontSize',10,'Rotation',90)
title('解码甘特图','fontname','微软雅黑','Color','b','FontSize',16);%图形的标题
color=rand(length(job),3);%生成随机的颜色,并使其方差和大于0.3，防止出现多个相似颜色
while sum(var(color))<0.26
    color=rand(length(job),3);
end
for i=1:nb_mac
    for j=1:length(mac_start{i})
        rec=[mac_start{i}(j),i-0.3,mac_end{i}(j)-mac_start{i}(j),0.6];%设置矩形的位置，[矩形左下顶点的x坐标，y坐标，长度，高度]        
        txt=sprintf('p(%d,%d)=%3.1f',mac_serial{i}(j,1),mac_serial{i}(j,2),mac_end{i}(j)-mac_start{i}(j));%将工序号，加工时间连城字符串
        rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',color(mac_serial{i}(j,1),:));%画每个矩形       
        text(mac_start{i}(j)+0.2,i,txt,'FontWeight','Bold','FontSize',10);%在矩形上标注工序号，加工时间
        
        if mac_serial{i}(j,2)-1>0
            rec_trans=[mac_start{i}(j),i-0.7,mac_start{i}(j)-mac_trans_start_time{i}(j),0.4];
            txt_trans=sprintf('t(%d,%d)=%3.1f',job2mac_serial{mac_serial{i}(j,1)}(mac_serial{i}(j,2)-1),i,mac_start{i}(j)-mac_trans_start_time{i}(j));
            rectangle('Position',rec_trans,'LineWidth',0.5,'LineStyle','-','FaceColor',[1,1,1]);
            text(mac_start{i}(j)+0.2,i-0.5,txt_trans,'FontWeight','Bold','FontSize',10);
        end
    end
end
% for i=1:length(job_trans_time)
%     for j=1:length(job_trans_time{i})
%         rec=[mac_start{i}(j),i-0.3,mac_end{i}(j)-mac_start{i}(j),0.6];