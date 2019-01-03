%���������ʼʱ�䣬����ʱ�䣬����깤ʱ��
%����һ������ͼ
function draw_gantt(code)
global mac_num;
global job;
[max_mac_time,mac_serial,mac_start,mac_end]=decode(code);
nb_mac=sum(mac_num);
axis([0,max_mac_time+5,0,nb_mac+0.5]);%x�� y��ķ�Χ
set(gca,'xtick',0:2:max_mac_time+5) ;%x�����������
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
    end
end