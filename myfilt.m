function output = myfilt(I)


    x1 = I;
    [s1 , s2] = size(x1);
    f1 = zeros(s1,s2);
    
    for i = 1:s1
        for j = 1:s2
            if x1(i,j) == 0 || x1(i,j) == 255
                f1(i,j)=0;
                x1(i,j)=0;
            else
                f1(i,j)=1;
            end
        end
    end
    %figure,imshow(x1);
    fsave=f1;
    x2 = x1;
    for i = 2:s1-1
        for j = 2:s2-1
            if x2(i,j) == 0 && (x2(i-1,j) + x2(i+1,j) + x2(i,j-1) + x2(i,j+1)) ~= 0 
                x1(i,j)= (x2(i-1,j) + x2(i+1,j) + x2(i,j-1) + x2(i,j+1))/(fsave(i-1,j) + fsave(i+1,j) + fsave(i,j-1) + fsave(i,j+1));
                f1(i,j)=1;
            end
        end
    end
    x2 = x1;
    %figure,imshow(x1);
    for i = 2:s1-1
        for j = 2:s2-1
            if x2(i,j) == 0 
                if x2(i-1,j)~=0 && (x2(i-1,j-1)+ x2(i-1,j+1)+ x2(i,j)+ x2(i,j-1)+ x2(i,j+1)+ x2(i+1,j)+ x2(i+1,j-1)+ x2(i+1,j+1)==0)~=0   
                    x1(i,j) = (x2(i-1,j) + x2(i-1,j-1) + x2(i-1,j+1) + x2(i,j) + x2(i,j-1) + x2(i,j+1) + x2(i+1,j) + x2(i+1,j-1) + x2(i+1,j+1) )/(f1(i-1,j) + f1(i-1,j-1) + f1(i-1,j+1) + f1(i,j) + f1(i,j-1) + f1(i,j+1) + f1(i+1,j) + f1(i+1,j-1) + f1(i+1,j+1));
                end            
            end
        end
    end
    
    x2=x1;
    %figure,imshow(x1);
    for i = 2:s1-1
        for j = 2:s2-1
            flag = 0;
            list = uint8.empty(1,0);
            if fsave(i,j) == 0 
                if x2(i-1,j-1)~=0
                    flag = 1;
                    list = x2(i-1,j-1);
                end
                if x2(i-1,j)~=0
                    flag = 1;
                    list = [list x2(i-1,j)];
                end
                if x2(i-1,j+1)~=0
                    flag = 1;
                    list = [list x2(i-1,j+1)];
                end
                if x2(i,j-1)~=0
                    flag = 1;
                    list = [list x2(i,j-1)];
                end
                if x2(i,j)~=0
                    flag = 1;
                    list = [list x2(i,j)];
                end
                if x2(i,j+1)~=0
                    flag = 1;
                    list = [list x2(i,j+1)];
                end
                if x2(i+1,j-1)~=0
                    flag = 1;
                    list = [list x2(i+1,j-1)];
                end
                if x2(i+1,j)~=0
                    flag = 1;
                    list = [list x2(i+1,j)];
                end
                if x2(i+1,j+1)~=0
                    flag = 1;
                    list = [list x2(i+1,j+1)];
                end
                if flag == 1
                    x1(i,j) = median(list);
                end
            end
        end
    end
    
    %figure,imshow(x1);
    for i = 2:s1-1
        if x1(i,1)==0
            x1(i,1)=x1(i,2);
        end
    end
    
    
    for i = 2:s1-1
        if x1(i,s2)==0
            x1(i,s2)=x1(i,s2-1);
        end
    end    
    for i = 2:s2-1
        if x1(1,i)==0
            x1(1,i)=x1(2,i);
        end
    end
    for i = 2:s2-1
        if x1(s1,i)==0
            x1(s1,i)=x1(s1-1,i);
        end
    end
    
    %figure,imshow(x1);
output = x1;
end