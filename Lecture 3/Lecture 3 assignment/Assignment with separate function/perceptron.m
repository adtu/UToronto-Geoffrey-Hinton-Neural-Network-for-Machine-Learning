%Improving assignment 3 with vectorization

%Initialization
clear; close all; clc

%% ======== Perceptron ========
fprintf ('running perceptron ... \n');

fprintf ('<Press enter 1 to load dataset1>\n');
fprintf ('<Press enter 2 to load dataset2>\n');
fprintf ('<Press enter 3 to load dataset3>\n');
fprintf ('<Press enter 4 to load dataset4>\n');
fprintf ('<Press enter to continue, q to quit>\n\n');

key = input('Please enter the dataset you wish to analyze = ', 's');

if (key == '1')
    load ('dataset1');
end
if (key == '2')
    load ('dataset2');
end
if (key == '3')
    load ('dataset3');
end
if (key == '4')
    load ('dataset4');
end
if (key == 'q')
    return;
end

%% ======== Setting up parameters =========

fprintf ('Setting up parameters .... \n');

neg_m = size(neg_examples_nobias, 1);   % number of neg_training examples
pos_m = size(pos_examples_nobias, 1);   % number of pos_training examples

total_error_history = [];
w_dist_history = [];

% ---- Adding bias ----
neg_v = [neg_examples_nobias, ones(neg_m,1)];   % adding bias at the end
pos_v = [pos_examples_nobias, ones(pos_m,1)];   % adding bias at the end

% ---- Initialization weight ----

n = size(neg_v, 2);
if (~exist('w_init', 'var') || isempty(w_init))
    w = randn(n,1);
else
    w = w_init;
end

if (~exist('w_gen_feas','var'))
    w_gen_feas = [];
end

%% ======== Tallying Errors ========

iter = 0;
[error0, error1] = perceptron_error (neg_v, pos_v, neg_m, pos_m, w);
total_error = size(error0,1) + size(error1,1);
total_error_history (end+1) = total_error;

fprintf ('Number of errors in iteration %d:\t%d\n', iter, total_error);
fprintf (['weights:\t', mat2str(w), '\n']);
plot_perceptron(neg_v,pos_v, error0, error1, total_error_history, w, w_dist_history);
key = input ('<Press Enter to continue, q to quit.>', 's');
if (key == 'q')
    return;
end

%If a generously feasible weight vector exists, record the distance
%to it from the initial weight vector.
if (length(w_gen_feas) ~= 0)
    w_dist_history(end+1) = norm(w - w_gen_feas);
end

%% ========== Iteration =========
%Iterate until the perceptron has correctly classified all points.

while (total_error > 0)
    iter = iter + 1;
    
    w = Update_weights (neg_v, pos_v, neg_m, pos_m, w);
    
    %If a generously feasible weight vector exists, record the distance
    %to it from the current weight vector.
    if (length(w_gen_feas) ~= 0)
        w_dist_history(end+1) = norm(w - w_gen_feas);
    end

    %Find the data points that the perceptron has incorrectly classified.
    %and record the number of errors it makes.
    [error0, error1] = perceptron_error(neg_v,pos_v,neg_m, pos_m, w);
    total_error = size(error0,1) + size(error1,1);
    total_error_history(end+1) = total_error;

    fprintf('Number of errors in iteration %d:\t%d\n',iter,total_error);
    fprintf(['weights:\t', mat2str(w), '\n']);
    plot_perceptron(neg_v, pos_v, error0, error1, total_error_history, w, w_dist_history);
    key = input('<Press enter to continue, q to quit.>', 's');
    if (key == 'q')
        break;
    end
end
