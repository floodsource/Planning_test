function [listflag,in] = islist(node,close,open)
    %��closelist�� flag = 1
    %��openlist��  flag = 2
    %����openlist��flag = 3
    for i=1:length(close(:,1))
        if isequal(node(1,1:2),close(i,1:2))%��closelist�У�����flag������
            listflag = 1;
            in = i;
            return;
        end
    end
    
    if(isempty(open(:,1)))%�ж��ǲ���openlistΪ��
        listflag = 3;
        in = [];
        return;
    end
    for j=1:length(open(:,1))
        if isequal(node(1,1:2),open(j,1:2))%����openlist�У�����flag������
            listflag = 2;
            in = j;
            return;
        else
            listflag = 3;
            in = [];
        end
    end
end

