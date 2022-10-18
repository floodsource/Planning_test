function Path = Astar(obstacle,map)
openlist = [ ];
closelist = [ ];
%1�ڵ�����꣬2�ڵ������꣬3�ڵ�F��4�ڵ�G, 5���ڵ�����꣬6���ڵ�������
openlist = [map.start(1,1),map.start(1,2),0+cal_h(map.start,map.goal),0,map.start(1,1),map.start(1,2)];

%������Χ�˸��ڵ�
findflag = 0;
last_in = 0;
while ~findflag
    if(isempty(openlist(:,1)))
        disp('no path');
        return;
    end
    openlist = sortrows(openlist,3);
    openlist = [openlist]
    closelist = [openlist(1,:);closelist];
    current_node = [openlist(1,:)];
    openlist(1,:)= [ ];
    neighbor = [-1,1,2.8;
        0,1,2;
        1,1,2.8;
        1,0,2;
        1,-1,2.8;
        0,-1,2;
        -1,-1,2.8;
        -1,0,2;
        ] ;
    for i=1:length(neighbor(:,1))
        corr_i = [current_node(1,1)+neighbor(i,1),current_node(1,2)+neighbor(i,2)];
        g_i = current_node(1,4)+neighbor(i,3); 
        pos_node=[corr_i(1),corr_i(2),g_i+cal_h(corr_i,map.goal),g_i,current_node(1,1),current_node(1,2)]; 
        %���ж�һ���ǲ����ϰ��������Ǳ߽��
        ob_flag = false;
        for i=1:length(obstacle(:,1))
            if isequal(pos_node(1,1:2),obstacle(i,1:2))%���ϰ�������Ǳ߽�㣬����ѭ��
                ob_flag = true;
                break;
            end
        end
        
        if ob_flag 
            continue;
        end
        [listflag,index] = islist(pos_node,closelist,openlist);
        if listflag == 1
            continue;
        elseif listflag == 2 %����ھӽڵ��Ѿ���openlist��
            if openlist(1,3) > pos_node(1,3)
                openlist(index,:) = pos_node(1,:);
                continue;
            end
        elseif listflag == 3 %����ھӽڵ㲻��openlist��
            openlist = [pos_node;openlist];
            continue
        end
    end
    for x =1:length(openlist(:,1))
        if isequal(map.goal,openlist(x,1:2))
            findflag = 1;
            last_in = x;
            closelist = [openlist(x,:);closelist];
            break;
        end
    end
    get_path = 0;
    indexx = 1;
    Path = [ ]
    %������ȡ����·��
    while 1
        Path = [Path;closelist(indexx,1:2)];
        if isequal(closelist(indexx,1:2),map.start)
            break;
        end
        for i=1:length(closelist(:,1))
            if isequal(closelist(i,1:2),closelist(indexx,5:6))
                indexx = i;
                break;
            end
        end
    end
    
    PlotGrid(map);
    hold on;
    pause(0.01);
    %���ƽڵ�close��open�ڵ�
    FillPlot(closelist,'r');
    hold on;
    closelist = [closelist]
    FillPlot(openlist,'g')
    hold on;

end
%��closelist���ҵ�·��

end

