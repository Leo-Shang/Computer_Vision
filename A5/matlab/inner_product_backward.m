function [param_grad, input_od] = inner_product_backward(output, input, layer, param)
    
% Replace the following lines with your implementation.
    param_grad.b = zeros(size(param.b));
    param_grad.w = zeros(size(param.w));
    h_in = size(param.w,1);
    h_out = output.height;
    batch_size = input.batch_size;
    
    for b = 1:batch_size 
        diff = output.diff(:,b);
        data = repmat(input.data(:,b),[1,h_out]);
        param_grad.w = param_grad.w + data * diag(diff);
        param_grad.b = param_grad.b + ones(1,h_out) * diag(diff);
    end

    input_od = zeros(h_in,batch_size);
    for i = 1:h_in
        for b = 1:batch_size
            input_od(i,b) = param.w(i,:) * output.diff(:,b);
        end
    end
end

