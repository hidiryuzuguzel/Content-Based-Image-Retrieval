function [ dbs_rgbfeat, dbs_labfeat, dbs_colorfeat ] = CBIR_ColorFeX( dbs_path, Im_name, Im_ext  )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
dbs_content = dir([dbs_path '*' Im_ext]);
Nbins = 4;

dbs_rgbfeat = zeros(length(dbs_content),12); 
dbs_labfeat = zeros(length(dbs_content),16); 
dbs_colorfeat = zeros(length(dbs_content),28); 


for i=1:length(dbs_content)
    current_image_name = strcat(dbs_path,Im_name,num2str(i-1),Im_ext); 
    current_rgb_image = imread(current_image_name);
    current_lab_image = applycform(current_rgb_image,makecform('srgb2lab'));
    rgb_color_histogram = zeros(Nbins,3);
    lab_color_histogram1 = zeros(8,1); 
    lab_color_histogram2 = zeros(4,2); 
    % TODO: Use quant built-in.. step=256/Nbins,  rgb_color_histogram =
    % quant(current_rgb_image,step)
    for n=1:Nbins
        rgb_color_histogram(n,1) = sum(sum(current_rgb_image(:,:,1)>=64*(n-1) & current_rgb_image(:,:,1)<64*n)); 
        rgb_color_histogram(n,2) = sum(sum(current_rgb_image(:,:,2)>=64*(n-1) & current_rgb_image(:,:,2)<64*n)); 
        rgb_color_histogram(n,3) = sum(sum(current_rgb_image(:,:,3)>=64*(n-1) & current_rgb_image(:,:,3)<64*n)); 
        
        lab_color_histogram2(n,1) = sum(sum(current_lab_image(:,:,2)>=100+25*(n-1) & current_lab_image(:,:,2)<100+25*n));
        lab_color_histogram2(n,2) = sum(sum(current_lab_image(:,:,3)>=100+25*(n-1) & current_lab_image(:,:,3)<100+25*n));
    end
    
    for n=1:8
        lab_color_histogram1(n) =  sum(sum(current_lab_image(:,:,1)>=32*(n-1) & current_lab_image(:,:,1)<32*n)); 
    end
    
    dbs_rgbfeat(i,:) = reshape(rgb_color_histogram,1,12);
    dbs_labfeat(i,:) = [lab_color_histogram1' reshape(lab_color_histogram2,1,8)];
    dbs_colorfeat(i,:) = [dbs_rgbfeat(i,:) dbs_labfeat(i,:)];
    fprintf('dbs_path=%s iteration=%d\n',dbs_path,i);
    
end

dbs_colorfeat = normc(dbs_colorfeat);   % feature normalization

end

