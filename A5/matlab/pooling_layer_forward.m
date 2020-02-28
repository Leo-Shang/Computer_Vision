function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    output.data = zeros(h_out, w_out, c, batch_size);
    input.data = reshape(input.data, [h_in,w_in,c,batch_size]);
    for b = 1:batch_size
        batch = input.data(:,:,:,b);
        data = padarray(batch, [pad pad], 0, 'both');
        for j = 1:c
            for row = 0:h_out-1
                for col = 0:w_out-1
                    temp = data(row*stride+1:row*stride+k,col*stride+1:col*stride+k,j);
                    output.data(row+1,col+1,j,b) = max(temp(:));
                end
            end
        end
    end
%     row_size = output.data / batch_size;
    output.data = reshape(output.data, [h_out*w_out*c, batch_size]);
end

