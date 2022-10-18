function [listflag,in] = islist(node,close,open)
    %在closelist中 flag = 1
    %在openlist中  flag = 2
    %不在openlist中flag = 3
    for i=1:length(close(:,1))
        if isequal(node(1,1:2),close(i,1:2))%在closelist中，返回flag和索引
            listflag = 1;
            in = i;
            return;
        end
    end
    
    if(isempty(open(:,1)))%判断是不是openlist为空
        listflag = 3;
        in = [];
        return;
    end
    for j=1:length(open(:,1))
        if isequal(node(1,1:2),open(j,1:2))%点在openlist中，返回flag和索引
            listflag = 2;
            in = j;
            return;
        else
            listflag = 3;
            in = [];
        end
    end
end

