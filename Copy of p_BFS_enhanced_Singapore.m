function [result dist_to_airport] = p_BFS_enhanced_Singapore(x,y)
import java.util.LinkedList
% Creating map
% 0 = unvisited
% -1 = unreachable
% -2 = farm
% -3 = airport

map = zeros(63,38);

%Singapore Map
for i = 1:63
    for j = 37:38
        map(i,j) = -1;
    end
end

for i = [1:29 32:63]
  
        map(i,36) = -1;
    
end

for i = [1:23 34:63]
  for j = 33:35
        map(i,j) = -1;
  end
end

for i = [1:17 36:63]
  
        map(i,32) = -1;
    
end

for i = [1:17 37:63]
  
        map(i,31) = -1;
    
end

for i = [1:16 30 31 37 43:63]
  
        map(i,30) = -1;
    
end

for i = [1:13 18 19 30 31 37 43:63]
  
        map(i,29) = -1;
    
end

for i = [1:13 18 19 26 37 44:63]
  
        map(i,28) = -1;
    
end

for i = [1:13 15:19 36 44:63]
  
        map(i,27) = -1;
    
end

for i = [1:13 15:19 23 24 26:29 34:36 44:63]
  
        map(i,26) = -1;
    
end

for i = [1:13 15:19 23 24 26:29 34:35 46:63]
  
        map(i,25) = -1;
    
end

for i = [1:13 15:19 23 24 26:30 46:63]
  
        map(i,24) = -1;
    
end

for i = [1:12 15:19 26:30 47:54 59:63]
  
        map(i,23) = -1;
    
end

for i = [1:13 15:18 26:30 47:54 59:63]
  
        map(i,22) = -1;
    
end

for i = [1:12 15:17 27:32 59:63]
  
        map(i,21) = -1;
    
end

for i = [1:12 19 27:32 61:63]
  
        map(i,20) = -1;
    
end

for i = [1:12 17:19 27:32 63]
  
        map(i,19) = -1;
    
end

for i = [1:3 6:11 18 25 28:32 63]
  
        map(i,18) = -1;
    
end

for i = [1:3 6:11 25 26 28:32 63]
  
        map(i,17) = -1;
    
end

for i = [1:3 6:11 28:32 63]
  
        map(i,16) = -1;
    
end


for i = [1:3 63]
  for j = 13:15
        map(i,j) = -1;
  end 
end

for i = [1:2 63]
  
        map(i,12) = -1;
    
end

for i = [1:2 61:63]
  
        map(i,11) = -1;
    
end

for i = [1:2 53:55 61:63]
  
        map(i,10) = -1;
    
end

for i = [1:2 50:63]
  
        map(i,9) = -1;
    
end

for i = [1:19 47:63]
  
        map(i,8) = -1;
    
end

for i = [1:22 44:63]
  
        map(i,7) = -1;
    
end

for i = [1:22 41:63]
  for j = 5:6
        map(i,j) = -1;
  end
end

for i = [1:25 41:63]
  for j = 3:4
        map(i,j) = -1;
  end
end


for i = [1:28 34:63]
  
        map(i,2) = -1;
    
end

for i = 1:63
  
        map(i,1) = -1;
    
end

%Specify farms
%map(18,24) = -2;
map(13,23) = -2;
map(17,28) = -2;
map(15,29) = -2;

%Specify airport
map(57,19) = -3;

%figure;
%surf(map,'EdgeColor','None');
%view(2);

[length_y length_x] = size(map);
result = 0;
dist_to_airport = 0;
%Check if input is invalid
if (x < 1 || y < 1 || x > 63 || y > 38)
    result = -1;
    dist_to_airport = -1;
    return
end
if (map(x,y) == -1)
    result = -1;
    dist_to_airport = -1;
    return
end

%Conduct BFS
q = LinkedList();
%q = CQueue();
%persistent q
map(x,y) = 1;
q.add(x + (y-1)*length_y);
while q.size > 0
    curr = q.remove();
    %checking top of current square
    if mod(curr - 1, length_y) > 0
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr - 1) == 0 || map(curr - 1) == -2 
            %if square is a farm, add distance to result
            if map(curr - 1) == -2
                result = result + map(curr);
                map(curr - 1) = -4;
            else
                map(curr - 1) = map(curr) + 1;
            end
            q.add(curr - 1);
            if curr == -4
                 map(curr - 1) = 1;
            end
        end
    end
    
    %checking bottom of current square
    if mod(curr, length_y) > 0
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr + 1) == 0 || map(curr + 1) == -2
            %if square is a farm, add distance to result
           if map(curr + 1) == -2
                result = result + map(curr);
                map(curr + 1) = -4;
            else
                map(curr + 1) = map(curr) + 1;
            end
            q.add(curr + 1);
            if curr == -4
                 map(curr + 1) = 1;
            end
        end
    end
    
    %checking left of current square
    if curr - length_y > 0
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr - length_y) == 0 || map(curr - length_y) == -2
            %if square is a farm, add distance to result
            if map(curr - length_y) == -2
                result = result + map(curr);
                map(curr - length_y) = -4;
            else
                map(curr - length_y) = map(curr) + 1;
            end
            q.add(curr - length_y);
            if curr == -4
                 map(curr - length_y) = 1;
            end
        end
    end
    
    %checking right of current square
    if curr + length_y <= length_x * length_y
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr + length_y) == 0 || map(curr + length_y) == -2
            %if square is a farm, add distance to result
            if map(curr + length_y) == -2
                result = result + map(curr);
                map(curr + length_y) = -4;
            else
                map(curr + length_y) = map(curr) + 1;
            end
            q.add(curr + length_y);
            if curr == -4
                 map(curr + length_y) = 1;
            end
        end
    end
end

end