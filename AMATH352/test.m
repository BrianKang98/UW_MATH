clear all; close all; clc
for ii = 1:10
    disp(['matrix' num2str(ii) ' = TransitionMatrix()'])
    disp(['length' num2str(ii) ' = loadTextFile("text_file_name.txt", matrix' num2str(ii) ')'])
    disp(['arr' num2str(ii) ' = convertTo2D(matrix' num2str(ii) ')'])
    disp('')
    disp(['print("----  ARR ' num2str(ii) ' ----")'])
    %disp(['print('\n'.join([''.join(['{:10}'.format("%.4f" % item) for item in row]) for row in arr1]))'])
end