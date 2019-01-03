%���������ʼʱ�䣬����ʱ�䣬����깤ʱ��
%����һ������ͼ
function draw_gantt(code)
global mac_num;
global job;
[max_mac_time,mac_serial,mac_start,mac_end,mac_trans_start_time,job2mac_serial]=decode(code);
nb_mac=sum(mac_num);
axis([0,max_mac_time+5,0,nb_mac+0.5]);%x�� y��ķ�Χ
set(gca,'xtick',0:5:max_mac_time+5) ;%x�����������
set(gca,'ytick',0:1:nb_mac+0.5) ;%y�����������
xlabel('�ӹ�ʱ��','FontName','΢���ź�','Color','b','FontSize',10)
ylabel('������','FontName','΢���ź�','Color','b','FontSize',10,'Rotation',90)
title('�������ͼ','fontname','΢���ź�','Color','b','FontSize',16);%ͼ�εı���
color=rand(length(job),3);%�����������ɫ,��ʹ�䷽��ʹ���0.3����ֹ���ֶ��������ɫ
while sum(var(color))<0.26
    color=rand(length(job),3);
end
for i=1:nb_mac
    for j=1:length(mac_start{i})
        rec=[mac_start{i}(j),i-0.3,mac_end{i}(j)-mac_start{i}(j),0.6];%���þ��ε�λ�ã�[�������¶����x���꣬y���꣬���ȣ��߶�]        
        txt=sprintf('p(%d,%d)=%3.1f',mac_serial{i}(j,1),mac_serial{i}(j,2),mac_end{i}(j)-mac_start{i}(j));%������ţ��ӹ�ʱ�������ַ���
        rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',color(mac_serial{i}(j,1),:));%��ÿ������       
        text(mac_start{i}(j)+0.2,i,txt,'FontWeight','Bold','FontSize',10);%�ھ����ϱ�ע����ţ��ӹ�ʱ��
        
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