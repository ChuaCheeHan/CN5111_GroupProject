function [result dist_to_airport] = p_BFS_johor(x,y)
import java.util.LinkedList
% Creating map
% 0 = unvisited
% -1 = unreachable
% -2 = farm
% -3 = airport

map = zeros(61,22);

%Johor Map

for i = [8:13 15 16 19:22 25:28 39:45 47:53 56:61]
    map(i,22) = -1;
end

for i = [1 7:13 16 19:23 25 30:35 39:45 47:53 56:61]
    map(i,21) = -1;
end

for i = [1:4 8:13 16 18:21 31:35 39:45 47:53 56:61]
    map(i,20) = -1;
end

for i = [1:5 10 11 15 18 24:29 33:34 42:45 47:53 56:61]
    map(i,19) = -1;
end

for i = [1:5 11 15 18 24:30 34 42:45 48:53 56:61]
    map(i,18) = -1;
end

for i = [1:4 13:15 17 20:21 24:32 36:40 43:46 49:53 56:61]
    map(i,17) = -1;
end

for i = [1:3 6:8 20:22 25:32 35:40 46 47 51:54 58:61]
    map(i,16) = -1;
end

for i = [2 5:9 22 26:32 34:43 46:49 52:56 58:61]
    map(i,15) = -1;
end

for i = [5:10 23 28:31 34:43 46:50 52:56 59:61]
    map(i,14) = -1;
end

for i = [5:12 30 33:44 46:50 53:56 59:61]
    map(i,13) = -1;
end

for i = [1 3 6:12 14 30 33:44 47:51 54:57 59:61]
    map(i,12) = -1;
end

for i = [3 4 6:11 14:15 30 33:45 52 54:57 59:61]
    map(i,11) = -1;
end

for i = [2:4 7:10 13:17 26:28 36:47 55:56 59:61]
    map(i,10) = -1;
end

for i = [2:4 12:16 22:24 37:52 59:61]
    map(i,9) = -1;
end

for i = [2:4 6 12:15 38:49 59:61]
    map(i,8) = -1;
end

for i = [3 6:8 11:13 32:36 39:48 51:54 59:61]
    map(i,7) = -1;
end

for i = [1 3 8:9 12:13 16 32:36 39:43 50:54 56 57 59:61]
    map(i,6) = -1;
end

for i = [1 16 32:36 47:54 56 57 60:61]
    map(i,5) = -1;
end

for i = [1 2 16 39 41:54 56:58 61]
    map(i,4) = -1;
end

for i = [1 2 9 39 41:51 56:58 61]
    map(i,3) = -1;
end

for i = [1:3 11 17 39 41:50 53:54 56:58 61]
    map(i,2) = -1;
end

for i = [1:3 6 7 10:14 41:49 52:54 56:58 61]
    map(i,1) = -1;
end


%Specify farms
map(5,21) = -2;
map(32,9) = -2;
map(59,1) = -2;


%Specify airport
map(22,13) = -3;

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
