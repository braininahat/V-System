% Get a list of mat files in the current directory
matFiles = dir('sim_*.mat');

% Loop through each mat file
for i = 1:numel(matFiles)
    % Load the data from the mat file
    data = load(matFiles(i).name);
    
    % Extract the x, y, and z variables from the loaded data
    x = data.x;
    y = data.y;
    z = data.z;
    
    % Create a scatter plot
    scatter3(x, y, z, 0.1, 'Marker', '.');
    
    % Save the plot as a PNG file with the same filename
    [~, filename, ~] = fileparts(matFiles(i).name);
    saveas(gcf, [filename, '.png']);
    
    % Close the figure
    close(gcf);
end
