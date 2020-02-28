function [output] = inner_product_forward(input, layer, param)

    d = size(input.data, 1);
    k = size(input.data, 2); % batch size
    n = size(param.w, 2);

    % Replace the following line with your implementation.  
    output.height = n;
    output.width = 1;
    output.channel = 1;
    output.batch_size = k;
%     output.diff = input.diff;
%     output.w = 
%     output.b = 
    output.data = zeros([n, k]);
    for i = 1:k
        x = input.data(:,i)';
        W = param.w;
        b = param.b;
        output.data(:,i) = (x * W + b)'; 
    end
end
