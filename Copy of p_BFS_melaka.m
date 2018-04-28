function [result dist_to_airport] = p_BFS_melaka(x,y)
import java.util.LinkedList
% Creating map
% 0 = unvisited
% -1 = unreachable
% -2 = farm
% -3 = airport

map = zeros(51,28);

%Melaka Map

for i = [6:9 14:17 19:26 28:51]
    map(i,28) = -1;
end

for i = [7:9 14:16 20 23:25 28:51]
    map(i,27) = -1;
end

for i = [2:3 7:9 11:12 27:51]
    map(i,26) = -1;
end

for i = [3 8:9 11:13 18:22 27:51]
    map(i,25) = -1;
end

for i = [11:12 15 18:25 27:51]
    map(i,24) = -1;
end

for i = [14:15 17:22 31:51]
    map(i,23) = -1;
end

for i = [1 13:15 17:21 24:28 33:51]
    map(i,22) = -1;
end

for i = [12:13 17:21 24:31 33:51]
    map(i,21) = -1;
end

for i = [18:21 24:28 31 33:51]
    map(i,20) = -1;
end

for i = [1 15 18:21 34:49]
    map(i,19) = -1;
end

for i = [1:3 18:20 23:24 28:30 34:49]
    map(i,18) = -1;
end

for i = [1:4 18 22:24 27:32 34:49]
    map(i,17) = -1;
end

for i = [1:5 21:24 28:32 34:48]
    map(i,16) = -1;
end

for i = [1:6 20:24 26 28:32 34:47]
    map(i,15) = -1;
end

for i = [1:6 16:17 28:32 34:37 40:46 50:51]
    map(i,14) = -1;
end

for i = [1:8 16:17 24:25 27:32 34:36 40:45 48:51]
    map(i,13) = -1;
end

for i = [1:10 17 27:32 34:35 41:43 47:51]
    map(i,12) = -1;
end

for i = [1:12 27:32 34:35 37:38 41:43 47:51]
    map(i,11) = -1;
end

for i = [1:16 31:32 34:35 37:38 45:51]
    map(i,10) = -1;
end

for i = [1:17 22:26 37:38 45:51]
    map(i,9) = -1;
end

for i = [1:18 23 26 29:30 36:39 44:51]
    map(i,8) = -1;
end

for i = [1:18 29:31 36:37 44:51]
    map(i,7) = -1;
end

for i = [1:19 24 31 36:37 44:51]
    map(i,6) = -1;
end

for i = [1:19 23:24 26 37 40 47:51]
    map(i,5) = -1;
end

for i = [1:21 26 28:29 34:35 39:41 45 48:51]
    map(i,4) = -1;
end

for i = [1:21 26:29 34:35 40:41 44:46 50:51]
    map(i,3) = -1;
end

for i = [1:23 28:29 37 45:48 50:51]
    map(i,2) = -1;
end

for i = [1:26 37:38 43 46:48]
    map(i,1) = -1;
end

%Specify farms
map(23,11) = -2;
map(38,5) = -2;
map(38,7) = -2;
map(49,15) = -2;

%Specify airport
map(10,15) = -3;



%figure;
%surf(map,'EdgeColor','None');
%view(2);

result = 0;
dist_to_airport = 0;
%Check if input is invalid
if (map(x,y) == -1)
    result = -1;
    dist_to_airport = -1;
    return
end

%Conduct BFS
q = LinkedList();
%q = CQueue();
%persistent q
[length_y length_x] = size(map);
map(x,y) = 1;
q.add(x + (y-1)*length_y);
while q.size > 0
    curr = q.remove();
    %checking top of current square
    if mod(curr - 1, length_y) > 0
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr - 1) == 0 || map(curr - 1) <= -2 
            %if square is a farm, add distance to result
            if map(curr - 1) == -2
                result = result + map(curr);
            end
            %if square is the airport, change value in dist_to_airport
            if map(curr - 1) == -3
                dist_to_airport = result + map(curr);
            end
            map(curr -1) = map(curr) + 1;
            q.add(curr - 1);
        end
    end
    
    %checking bottom of current square
    if mod(curr, length_y) > 0
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr + 1) == 0 || map(curr + 1) <= -2
            %if square is a farm, add distance to result
            if map(curr + 1) == -2
                result = result + map(curr);
            end
            %if square is the airport, change value in dist_to_airport
            if map(curr + 1) == -3
                dist_to_airport = result + map(curr);
            end
            map(curr + 1) = map(curr) + 1;
            q.add(curr + 1);
        end
    end
    
    %checking left of current square
    if curr - length_y > 0
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr - length_y) == 0 || map(curr - length_y) <= -2
            %if square is a farm, add distance to result
            if map(curr - length_y) == -2
                result = result + map(curr);
            end
            %if square is the airport, change value in dist_to_airport
            if map(curr - length_y) == -3
                dist_to_airport = result + map(curr);
            end
            map(curr - length_y) = map(curr) + 1;
            q.add(curr - length_y);
        end
    end
    
    %checking right of current square
    if curr + length_y <= length_x * length_y
        %if square is not unmarked or is a farm, add distance to it and add it to queue
        if map(curr + length_y) == 0 || map(curr + length_y) <= -2
            %if square is a farm, add distance to result
            if map(curr + length_y) == -2
                result = result + map(curr);
            end
            %if square is the airport, change value in dist_to_airport
            if map(curr + length_y) == -3
                dist_to_airport = result + map(curr);
            end
            map(curr + length_y) = map(curr) + 1;
            q.add(curr + length_y);
        end
    end
end

end