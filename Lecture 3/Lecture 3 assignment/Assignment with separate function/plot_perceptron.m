%% ======== Plotting perceptron ========
function plot_perceptron(neg_v,pos_v, error0, error1, total_error_history, w, w_dist_history)

f = figure(1);
clf(f);

neg_correct_ind = setdiff(1:size(neg_v,1),error0);
pos_correct_ind = setdiff(1:size(pos_v,1),error1);

subplot(2,2,1);
hold on;
if (~isempty(neg_v))
	plot(neg_v(neg_correct_ind,1),neg_v(neg_correct_ind,2),'og','markersize',15);
end
if (~isempty(pos_v))
	plot(pos_v(pos_correct_ind,1),pos_v(pos_correct_ind,2),'sg','markersize',15);
end
if (size(error0,1) > 0)
	plot(neg_v(error0,1),neg_v(error0,2),'or','markersize',15);
end
if (size(error1,1) > 0)
	plot(pos_v(error1,1),pos_v(error1,2),'sr','markersize',15);
end
title('Classifier');

%In order to plot the decision line, we just need to get two points.
plot([-5,5],[(-w(end)+5*w(1))/w(2),(-w(end)-5*w(1))/w(2)],'k')
xlim([-1,1]);
ylim([-1,1]);
hold off;

subplot(2,2,2);
plot(0:length(total_error_history)-1,total_error_history);
xlim([-1,max(15,length(total_error_history))]);
ylim([0,size(neg_v,1)+size(pos_v,1)+1]);
title('Number of errors');
xlabel('Iteration');
ylabel('Number of errors');

subplot(2,2,3);
plot(0:length(w_dist_history)-1,w_dist_history);
xlim([-1,max(15,length(total_error_history))]);
ylim([0,15]);
title('Distance')
xlabel('Iteration');
ylabel('Distance');