function [w] = update_weights (neg_v, pos_v, neg_m, pos_m, w_current)

%% ========= Updating Weights =========

w = w_current;

for i=1:neg_m
    this_case = neg_v(i,:);
    x = this_case'; %Hint
    activation = this_case*w;
    if (activation >= 0)
        %YOUR CODE HERE
        w = w - x;
    end
end
for i=1:pos_m
    this_case = pos_v(i,:);
    x = this_case';
    activation = this_case*w;
    if (activation < 0)
        %YOUR CODE HERE
        w = w + x;
    end
end
