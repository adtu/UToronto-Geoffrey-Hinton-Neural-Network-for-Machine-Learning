function [error0, error1] =  perceptron_error (neg_v, pos_v, neg_m, pos_m, w)

error0 = [];
error1 = [];
for i=1:neg_m
    x = neg_v(i,:)';
    activation = x'*w;
    if (activation >= 0)
        error0 = [error0;i];  %filling up the mistake vector if there's any mistakes
    end
end
for i=1:pos_m
    x = pos_v(i,:)';
    activation = x'*w;
    if (activation < 0)
        error1 = [error1;i];
    end
end