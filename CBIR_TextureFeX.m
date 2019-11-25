function [ dbs_lbpfeat, dbs_glcmfeat, dbs_texturefeat ] = CBIR_TextureFeX( dbs_path, Im_name, Im_ext, dbs_type  )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%  dbs_type = 0 -> Color dbs   & dbs_type = 1 -> Texture dbs
dbs_content = dir([dbs_path '*' Im_ext]);

if (dbs_type==0)
    dbs_lbpfeat = zeros(length(dbs_content),256,3);
else if (dbs_type==1)
        dbs_lbpfeat = zeros(length(dbs_content),256);
    else
        fprintf('Enter 0 for color dbs and 1 for texture dbs\n');
        return;
    end
end


% 4 statistical parameters calculated from GLCM: energy, entropy, contrast,
% inverse difference moment
dbs_glcmfeat = zeros(length(dbs_content),4);

if (dbs_type==0)
    lbp_block = zeros(3,3,3);
else if (dbs_type==1)
        lbp_block = zeros(3,3);
    end
end
lbp_weight = zeros(3,3);
lbp_weight(1,1) = 2^0;lbp_weight(1,2) = 2^1;lbp_weight(1,3) = 2^2;
lbp_weight(2,3) = 2^3;lbp_weight(3,3) = 2^4;lbp_weight(3,2) = 2^5;
lbp_weight(3,1) = 2^6;lbp_weight(2,1) = 2^7;

% GLCM parameter
dx = 4;
dy = 4;
quant_level = 4;
IJ = zeros(quant_level);    % IJ = (i-j)^2 for all i,j
for i=1:quant_level
    for j=1:quant_level
        IJ(i,j) = (i-j)^2;
    end
end


if (dbs_type==0)
    for i=1:length(dbs_content)
        
        current_image_name = strcat(dbs_path,Im_name,num2str(i-1),Im_ext);
        current_rgb_image = imread(current_image_name);
        current_lab_image = applycform(current_rgb_image,makecform('srgb2lab'));
        current_gray_image = double(rgb2gray(current_lab_image));
        current_quant_gray_image = floor(quant_level*(current_gray_image./256));
        
        % LBP (realIm_dbs)
        for x=1:size(current_rgb_image,1)-2
            for y=1:size(current_rgb_image,2)-2
                lbp_block(:,:,1) = current_rgb_image(x:x+3-1,y:y+3-1,1);
                lbp_block(:,:,1) = (lbp_block(:,:,1) >=  lbp_block(2,2,1));
                id = sum(sum(lbp_block(:,:,1).*lbp_weight));
                dbs_lbpfeat(i,id+1,1) =  dbs_lbpfeat(i,id+1,1)+1;
                lbp_block(:,:,2) = current_rgb_image(x:x+3-1,y:y+3-1,2);
                lbp_block(:,:,2) = (lbp_block(:,:,2) >=  lbp_block(2,2,2));
                id = sum(sum(lbp_block(:,:,2).*lbp_weight));
                dbs_lbpfeat(i,id+1,2)=dbs_lbpfeat(i,id+1,2)+1;
                lbp_block(:,:,3) = current_rgb_image(x:x+3-1,y:y+3-1,3);
                lbp_block(:,:,3) = (lbp_block(:,:,3) >=  lbp_block(2,2,3));
                id = sum(sum(lbp_block(:,:,3).*lbp_weight));
                dbs_lbpfeat(i,id+1,3)=dbs_lbpfeat(i,id+1,3)+1;
            end
        end
        
        %GLCM (realIm_dbs)
        GLCM = zeros(quant_level);
        for x=1:size(current_quant_gray_image,1)-dy
            for y=1:size(current_quant_gray_image,2)-dx
                idx = current_quant_gray_image(x,y)+1;
                idy = current_quant_gray_image(x+dy,y+dx)+1;
                GLCM(idx,idy) = GLCM(idx,idy) + 1;
            end
        end
        dbs_glcmfeat(i,1) = sum(sum(GLCM.^2));           % energy
        dbs_glcmfeat(i,2) = -sum(sum(GLCM(GLCM~=0).*log2(GLCM(GLCM~=0)))); % entropy
        dbs_glcmfeat(i,3) = sum(sum(IJ.*GLCM));          % contrast
        dbs_glcmfeat(i,4) = sum(sum(GLCM./(1+IJ)));      % inverse difference moment
         fprintf('dbs_path=%s iteration=%d\n',dbs_path,i);
    end
    dbs_lbpfeat = reshape(dbs_lbpfeat,length(dbs_content),256*3);
else if (dbs_type==1)
        for i=1:length(dbs_content)
            
            current_texture_image_name =  strcat(dbs_path,Im_name,num2str(i-1),Im_ext);
            current_texture_image = double(imread(current_texture_image_name));
            current_quant_texture_image = floor(quant_level*(current_texture_image./256));
            
            % LBP (texture_dbs)
            for x=1:size(current_texture_image,1)-2
                for y=1:size(current_texture_image,2)-2
                    lbp_block_texture = current_texture_image(x:x+3-1,y:y+3-1,1);
                    lbp_block_texture = (lbp_block_texture >=  lbp_block_texture(2,2));
                    id = sum(sum(lbp_block_texture.*lbp_weight));
                    dbs_lbpfeat(i,id+1) =  dbs_lbpfeat(i,id+1)+1;
                end
            end
            
            %GLCM (texture_dbs)
            GLCM_texture = zeros(quant_level);
            for x=1:size(current_quant_texture_image,1)-dy
                for y=1:size(current_quant_texture_image,2)-dx
                    idx = current_quant_texture_image(x,y)+1;
                    idy = current_quant_texture_image(x+dy,y+dx)+1;
                    GLCM_texture(idx,idy) = GLCM_texture(idx,idy) + 1;
                end
            end
            dbs_glcmfeat(i,1) = sum(sum(GLCM_texture.^2));           % energy
            dbs_glcmfeat(i,2) = -sum(sum(GLCM_texture(GLCM_texture~=0).*log2(GLCM_texture(GLCM_texture~=0)))); % entropy
            dbs_glcmfeat(i,3) = sum(sum(IJ.*GLCM_texture));          % contrast
            dbs_glcmfeat(i,4) = sum(sum(GLCM_texture./(1+IJ)));      % inverse difference moment
             fprintf('dbs_path=%s iteration=%d\n',dbs_path,i);
        end
    end
end

dbs_texturefeat = [dbs_lbpfeat dbs_glcmfeat];
dbs_texturefeat = normc(dbs_texturefeat);   % feature normalization
end





