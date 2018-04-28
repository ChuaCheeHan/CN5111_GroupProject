function [result dist_to_airport] = p_BFS_kl(x,y)
import java.util.LinkedList
% Creating map
% 0 = unvisited
% -1 = unreachable
% -2 = farm
% -3 = airport

map = zeros(38,36);

for i = [1:3 6:14 16:17 19:20 22:29 31:38]
    map(i,36) = -1;
end

for i = [1:4 6:14 16:17 23:29 31:38]
    map(i,35) = -1;
end

for i = [1:4 7:13 16:17 24:29 31:38]
    map(i,34) = -1;
end

for i = [1:5 8:13 16:17 22 24:29 31:38]
    map(i,33) = -1;
end

for i = [1:6 17 22 24:25 31:38]
    map(i,32) = -1;
end

for i = [1:7 10:15 21:22 24 29:38]
    map(i,31) = -1;
end

for i = [1:8 10:11 22 27:38]
    map(i,30) = -1;
end

for i = [1:8 11 26:38]
    map(i,29) = -1;
end

for i = [1:9 11:14 20 26:38]
    map(i,28) = -1;
end

for i = [1:9 11:14 20 26:38]
    map(i,27) = -1;
end

for i = [1:9 11:14 26:38]
    map(i,26) = -1;
end

for i = [1:9 11:14 26:38]
    map(i,25) = -1;
end

for i = [1:9 12:13 26:38]
    map(i,24) = -1;
end

for i = [1:9 26:38]
    map(i,23) = -1;
end

for i = [1:10 26 29:30 34:38]
    map(i,22) = -1;
end

for i = [1:11 29 36:38]
    map(i,21) = -1;
end

for i = [1:11 28 31:34 37:38]
    map(i,20) = -1;
end

for i = [1:11 27:28 31:35 37:38]
    map(i,19) = -1;
end

for i = [1:11 30:35 37:38]
    for j = 16:18
    map(i,j) = -1;
    end
end

for i = [1:9 13 30:35]
    map(i,15) = -1;
end

for i = [1:8 11:14 32:35 37:38]
    map(i,14) = -1;
end

for i = [1:8 12:14 19 32:34 37:38]
    map(i,13) = -1;
end

for i = [1:10 18:19 32:33 36:38]
    map(i,12) = -1;
end

for i = [1:11 18:20 33 35:38]
    map(i,11) = -1;
end

for i = [1:16 35:38]
    map(i,10) = -1;
end

for i = [1:15 32 35:38]
    map(i,9) = -1;
end

for i = [1:14 18:21 32 35:38]
    map(i,8) = -1;
end

for i = [1:14 17:22 35:38]
    map(i,7) = -1;
end

for i = [1:14 16:22]
    map(i,6) = -1;
end

for i = [1:14 16:24 26 29 37:38]
    map(i,5) = -1;
end

for i = [1:14 17:23 35:38]
    map(i,4) = -1;
end

for i = [1:16 20:23 35:38]
    map(i,3) = -1;
end

for i = [1:18 28 36:38]
    map(i,2) = -1;
end

for i = [1:22 28 31 37:38]
    map(i,1) = -1;
end


%Specify farms
map(29,10) = -2;
map(26,11) = -2;
map(16,29) = -2;
map(26,31) = -2;

%Specify airport
map(24,6) = -3;
map(18,22)= -3;



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