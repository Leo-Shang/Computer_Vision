function [output] = relu_forward(input)
output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

% Replace the following line with your implementation.
output.data = zeros(size(input.data));
output.data = input.data;
output.data(output.data < 0) = 0;
% for i = 1:size(output.data,1)
%     for j = 1:size(output.data,2)
%         if output.data(i, j) < 0
%             output.data(i, j) = 0;
%         end
%     end
% end
end
