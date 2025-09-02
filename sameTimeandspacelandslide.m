clear all
clc
urbandata=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值1.xlsx',...
    '城市区域new','A2:F763');
nonurbandata=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值1.xlsx',...
    '非城市区域new','A2:F5869');
urban = urbandata(urbandata(:, 6) == 1, :);
nonurban=nonurbandata(nonurbandata(:, 6) ==1, :);%只找0未发生
%urban = urbandata;
%nonurban=nonurbandata;%只找0未发生
% Initialize arrays to store results

spadis = [];
timedis = [];

% Loop through each urban data point
for i = 1:max(size(urban))
    urda = urban(i, 1);
    urlon = urban(i, 2);
    urlat = urban(i, 3);

    % Initialize variables to track the minimum timestamp difference and indices
    minTimestampDistance = Inf;
    minTimestampIndices = [];
    minDistance = Inf;
    minIndex = 0;

    % Loop through each non-urban data point
    for j = 1:max(size(nonurban))
        nonurda = nonurban(j, 1);
        nonurlon = nonurban(j, 2);
        nonurlat = nonurban(j, 3);

        % Calculate the absolute timestamp difference
        dis2 = abs(urda - nonurda);

        % Check if this timestamp difference is smaller than the current minimum
        if dis2 < minTimestampDistance
            minTimestampDistance = dis2;
            minTimestampIndices = [j];  % Reset the indices for the new minimum timestamp difference
            minDistance = Inf;  % Reset the minimum distance for this group
        elseif dis2 == minTimestampDistance
            minTimestampIndices = [minTimestampIndices, j];  % Add index to the list for equal timestamp differences
        end

        % Calculate the geographic distance (Euclidean distance)
        dis1 = sqrt((urlon - nonurlon)^2 + (urlat - nonurlat)^2);

%         % If this non-urban point has the closest timestamp, update the geographic distance
% 
%         if j == minTimestampIndices(1)
%             minDistance = dis1;
%             minIndex = j;
        if ismember(j, minTimestampIndices)
            if dis1 < minDistance
                minDistance = dis1;
                minIndex = j;
     end
    end
    end
    % Store the minimum geographic distance and its corresponding non-urban point
    spadis = [spadis; minDistance];
    timedis = [timedis; minIndex];
end
timedis(timedis==0)=1;
nonurbandata=nonurban(timedis,1:6);
disp('ok')
