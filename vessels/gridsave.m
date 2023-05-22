% Get a list of PNG files in the current directory
pngFiles = dir('sim_*.png');

% Initialize variables
numImages = numel(pngFiles);
numRows = 1;
numCols = 4;
numGrids = ceil(numImages / (numRows * numCols));
gridIndex = 1;
imageIndex = 1;

% Loop through each PNG file
while imageIndex <= numImages
    % Create a new figure for the grid
    figure('Position', [100, 100, 1200, 240]);
    
    % Loop through each grid position
    for row = 1:numRows
        for col = 1:numCols
            % Check if there are more images to process
            if imageIndex > numImages
                break;
            end
            
            % Read the image
            img = imread(pngFiles(imageIndex).name);
            
            % Compute the subplot position
            subPos = (row - 1) * numCols + col;
            
            % Calculate the image size to fit the subplot
            imgSize = getSubplotSize(subPos, numRows, numCols, size(img, 1), size(img, 2));
            
            % Resize the image to fit the subplot
            img = imresize(img, imgSize);
            
            % Create tight subplot in the current grid position
            ax = subplot('Position', getSubplotPosition(subPos, numRows, numCols));
            
            % Display the image
            imshow(img);
            
            % Remove the title
            title('');
            
            % Increment the image index
            imageIndex = imageIndex + 1;
        end
        
        % Break the inner loop if there are no more images
        if imageIndex > numImages
            break;
        end
    end
    
    % Save the grid as a PNG file numbered sequentially
    gridFilename = sprintf('grid_%03d.png', gridIndex);
    saveas(gcf, gridFilename);
    
    % Close the figure
    close(gcf);
    
    % Increment the grid index
    gridIndex = gridIndex + 1;
end

% Helper function to calculate subplot size
function subplotSize = getSubplotSize(subPos, numRows, numCols, imgHeight, imgWidth)
    subplotSize = [NaN NaN];
    if subPos <= numRows * numCols
        subplotSize = [imgHeight imgWidth];
    end
end

% Helper function to calculate subplot position
function subplotPos = getSubplotPosition(subPos, numRows, numCols)
    subWidth = 1 / numCols;
    subHeight = 1 / numRows;
    subRow = ceil(subPos / numCols);
    subCol = mod(subPos - 1, numCols) + 1;
    subplotPos = [(subCol - 1) * subWidth, 1 - subRow * subHeight, subWidth, subHeight];
end
