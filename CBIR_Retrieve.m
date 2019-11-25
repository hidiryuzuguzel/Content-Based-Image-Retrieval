function [dbs_AF1, dbs_ANMRR] = CBIR_Retrieve(dbs_path,dbs_feat, Im_ext, N)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
% N = Number of images per class in dbs
Im_name = 'sgn5506_';
dbs_content = dir([dbs_path '*' Im_ext]);

NumberOfImages = floor(length(dbs_content)/N)*N;

dbs_ranks = zeros(NumberOfImages,N);
dbs_precision = zeros(NumberOfImages,1);
dbs_recall = zeros(NumberOfImages,1);
dbs_f1 = zeros(NumberOfImages,1);

% ANMRR initialization
Nq = N;     W = 2*Nq;   % window
dbs_ranks_within_window = zeros(NumberOfImages,W);
dbs_AVR = zeros(NumberOfImages,1);
dbs_NMRR = zeros(NumberOfImages,1);

% figure('Name','CBIR','NumberTitle','off'),
for i=1:NumberOfImages
    D = bsxfun(@minus,dbs_feat(i,:),dbs_feat);
    dist = sqrt(sum(D.^2,2));
    [~, idx] = sort(dist);
    dbs_ranks(i,:) = idx(1:N);
    dbs_ranks_within_window(i,:) = idx(1:W);
% %     subplot(3,7,1), 
%     subplot(2,5,1),
%     imshow(strcat(dbs_path,Im_name,num2str(i-1),Im_ext)), title('Query image')
%     for k=1:N
%         %     subplot(3,7,k+1), 
%         subplot(2,5,k+1),
%         imshow(strcat(dbs_path,Im_name,num2str(dbs_ranks(i,k)-1),Im_ext)), title(['Rank number:',num2str(k)]);
%     end
%     pause;
    retrived_relevant_vector = dbs_ranks(i,:)>floor((i-1)/N)*N & dbs_ranks(i,:)<=ceil(i/N)*N;
    dbs_precision(i) = sum(retrived_relevant_vector)/N;
    dbs_recall(i) = sum(retrived_relevant_vector)/N;
    dbs_f1(i) = 2*dbs_precision(i)*dbs_recall(i)/(dbs_precision(i)+dbs_recall(i));
    
    dbs_tmp_ranks_within_window = (W+1)*ones(1,Nq-1);
    retrived_relevant_vector_within_window = dbs_ranks_within_window(i,:)>floor((i-1)/N)*N & dbs_ranks_within_window(i,:)<=ceil(i/N)*N;
    [~,ranks_within_window] = find(retrived_relevant_vector_within_window);
    ranks_within_window = ranks_within_window(2:end);   % exclude first one , the first retrieval is item queried
    dbs_tmp_ranks_within_window(1:length(ranks_within_window)) = ranks_within_window;
    dbs_tmp_ranks_within_window = dbs_tmp_ranks_within_window - 1;      %
    dbs_AVR(i,:) = mean(dbs_tmp_ranks_within_window);
    dbs_NMRR(i,:) = (2* dbs_AVR(i,:)-Nq-1)/(2*W-Nq+1);
%     fprintf('dbs_path=%s iteration=%d\n',dbs_path,i);
end
dbs_AF1 = mean(dbs_f1);
dbs_ANMRR = mean(dbs_NMRR);

end

