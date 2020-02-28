function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
input_od = zeros(size(input.data));

[row, col] = size(input.data);
for i = 1:row
    for j = 1:col
        if input.data(i,j) >= 0
            input_od(i, j) = output.diff(i, j);
        else
            input_od(i, j) = 0;
        end
    end
end

end
