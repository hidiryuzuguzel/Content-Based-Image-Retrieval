% SGN-31006 Image and Video Processing Techniques EXERCISE 5 and 6 
% Hidir Yuzuguzel, 244904
% Department of Signal Processing, TUT
clear all; clc;

realIm_dbs_path = '..\databases\realIm_dbs\Images\';
realIm_jpg_dbs_path = '..\databases\realIm_dbs\Images_jpeg\';
realIm_jp2_dbs_path = '..\databases\realIm_dbs\Images_jp2\';
texture_dbs_path = '..\databases\texture_dbs\Images\';
texture_jpg_dbs_path = '..\databases\texture_dbs\Images_jpeg\';
texture_jp2_dbs_path = '..\databases\texture_dbs\Images_jp2\';

realIm_name = 'sgn5506_';
texture_name = 'sgn5506_';
isExtracted = 1;    % flag if the it is 1, then no need to extrac, just load from the mat file. O/w perform FeX
if (isExtracted)
    % load realIm_dbs. Color feature
    load('./features/realIm_dbs_rgbfeat');
    load('./features/realIm_dbs_labfeat');
    load('./features/realIm_dbs_colorfeat');
    load('./features/realIm_jpg_dbs_rgbfeat');
    load('./features/realIm_jpg_dbs_labfeat');
    load('./features/realIm_jpg_dbs_colorfeat');
    load('./features/realIm_jp2_dbs_rgbfeat');
    load('./features/realIm_jp2_dbs_labfeat');
    load('./features/realIm_jp2_dbs_colorfeat');  
    % load realIm_dbs. Texture feature extraction
    load('./features/realIm_dbs_lbpfeat');
    load('./features/realIm_dbs_glcmfeat');
    load('./features/realIm_dbs_texturefeat');
    load('./features/realIm_jpg_dbs_lbpfeat');
    load('./features/realIm_jpg_dbs_glcmfeat');
    load('./features/realIm_jpg_dbs_texturefeat');
    load('./features/realIm_jp2_dbs_lbpfeat');
    load('./features/realIm_jp2_dbs_glcmfeat');
    load('./features/realIm_jp2_dbs_texturefeat');
    % load texture dbs. Texture feature extraction
    load('./features/texture_dbs_lbpfeat');
    load('./features/texture_dbs_glcmfeat');
    load('./features/texture_dbs_texturefeat');
    load('./features/texture_jpg_dbs_lbpfeat');
    load('./features/texture_jpg_dbs_glcmfeat');
    load('./features/texture_jpg_dbs_texturefeat');
    load('./features/texture_jp2_dbs_lbpfeat');
    load('./features/texture_jp2_dbs_glcmfeat');
    load('./features/texture_jp2_dbs_texturefeat');    
else
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FeX -- Feature Extraction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % realIm_dbs. Color feature
    [realIm_dbs_rgbfeat, realIm_dbs_labfeat, realIm_dbs_colorfeat] = CBIR_ColorFeX(realIm_dbs_path, realIm_name, '.jpg' );
    [realIm_jpg_dbs_rgbfeat, realIm_jpg_dbs_labfeat, realIm_jpg_dbs_colorfeat] = CBIR_ColorFeX(realIm_jpg_dbs_path, realIm_name, '.jpg' );
    [realIm_jp2_dbs_rgbfeat, realIm_jp2_dbs_labfeat, realIm_jp2_dbs_colorfeat] = CBIR_ColorFeX(realIm_jp2_dbs_path, realIm_name, '.jp2' );
    save realIm_dbs_rgbfeat
    save realIm_dbs_labfeat
    save realIm_dbs_colorfeat
    save realIm_jpg_dbs_rgbfeat
    save realIm_jpg_dbs_labfeat
    save realIm_jpg_dbs_colorfeat
    save realIm_jp2_dbs_rgbfeat
    save realIm_jp2_dbs_labfeat
    save realIm_jp2_dbs_colorfeat

    % realIm_dbs. Texture feature extraction
    [ realIm_dbs_lbpfeat, realIm_dbs_glcmfeat, realIm_dbs_texturefeat ] = CBIR_TextureFeX( realIm_dbs_path, realIm_name, '.jpg', 0  );
    [ realIm_jpg_dbs_lbpfeat, realIm_jpg_dbs_glcmfeat, realIm_jpg_dbs_texturefeat ] = CBIR_TextureFeX( realIm_jpg_dbs_path, realIm_name, '.jpg', 0  );
    [ realIm_jp2_dbs_lbpfeat, realIm_jp2_dbs_glcmfeat, realIm_jp2_dbs_texturefeat ] = CBIR_TextureFeX( realIm_jp2_dbs_path, realIm_name, '.jp2', 0  );
    save realIm_dbs_lbpfeat
    save realIm_dbs_glcmfeat
    save realIm_dbs_texturefeat
    save realIm_jpg_dbs_lbpfeat
    save realIm_jpg_dbs_glcmfeat
    save realIm_jpg_dbs_texturefeat
    save realIm_jp2_dbs_lbpfeat
    save realIm_jp2_dbs_glcmfeat
    save realIm_jp2_dbs_texturefeat

    % texture dbs. Texture feature extraction
    [ texture_dbs_lbpfeat, texture_dbs_glcmfeat, texture_dbs_texturefeat ] = CBIR_TextureFeX( texture_dbs_path, texture_name, '.tif', 1  );
    [ texture_jpg_dbs_lbpfeat, texture_jpg_dbs_glcmfeat, texture_jpg_dbs_texturefeat ] = CBIR_TextureFeX( texture_jpg_dbs_path, texture_name, '.jpg', 1  );
    [ texture_jp2_dbs_lbpfeat, texture_jp2_dbs_glcmfeat, texture_jp2_dbs_texturefeat ] = CBIR_TextureFeX( texture_jp2_dbs_path, texture_name, '.jp2', 1  );
    save texture_dbs_lbpfeat
    save texture_dbs_glcmfeat
    save texture_dbs_texturefeat
    save texture_jpg_dbs_lbpfeat
    save texture_jpg_dbs_glcmfeat
    save texture_jpg_dbs_texturefeat
    save texture_jp2_dbs_lbpfeat
    save texture_jp2_dbs_glcmfeat
    save texture_jp2_dbs_texturefeat
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Retrieval %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% realIm_dbs. Color feature Retrieval
[realIm_dbs_rgbfeat_AF1, realIm_dbs_rgbfeat_ANMRR] = CBIR_Retrieve(realIm_dbs_path,realIm_dbs_rgbfeat, '.jpg', 20)
[realIm_dbs_labfeat_AF1, realIm_dbs_labfeat_ANMRR] = CBIR_Retrieve(realIm_dbs_path,realIm_dbs_labfeat, '.jpg', 20)
[realIm_dbs_colorfeat_AF1, realIm_dbs_colorfeat_ANMRR] = CBIR_Retrieve(realIm_dbs_path,realIm_dbs_colorfeat, '.jpg', 20)
[realIm_jpg_dbs_rgbfeat_AF1, realIm_jpg_dbs_rgbfeat_ANMRR] = CBIR_Retrieve(realIm_jpg_dbs_path,realIm_jpg_dbs_rgbfeat, '.jpg', 20)
[realIm_jpg_dbs_labfeat_AF1, realIm_jpg_dbs_labfeat_ANMRR] = CBIR_Retrieve(realIm_jpg_dbs_path,realIm_jpg_dbs_labfeat, '.jpg', 20)
[realIm_jpg_dbs_colorfeat_AF1, realIm_jpg_dbs_colorfeat_ANMRR] = CBIR_Retrieve(realIm_jpg_dbs_path,realIm_jpg_dbs_colorfeat, '.jpg', 20)
[realIm_jp2_dbs_rgbfeat_AF1, realIm_jp2_dbs_rgbfeat_ANMRR] = CBIR_Retrieve(realIm_jp2_dbs_path,realIm_jp2_dbs_rgbfeat, '.jp2', 20)
[realIm_jp2_dbs_labfeat_AF1, realIm_jp2_dbs_labfeat_ANMRR] = CBIR_Retrieve(realIm_jp2_dbs_path,realIm_jp2_dbs_labfeat, '.jp2', 20)
[realIm_jp2_dbs_colorfeat_AF1, realIm_jp2_dbs_colorfeat_ANMRR] = CBIR_Retrieve(realIm_jp2_dbs_path,realIm_jp2_dbs_colorfeat, '.jp2', 20)
%% realIm_dbs. Texture feature Retrieval
[realIm_dbs_lbpfeat_AF1, realIm_dbs_lbpfeat_ANMRR] = CBIR_Retrieve(realIm_dbs_path,realIm_dbs_lbpfeat, '.jpg', 20)
[realIm_dbs_glcmfeat_AF1, realIm_dbs_glcmfeat_ANMRR] = CBIR_Retrieve(realIm_dbs_path,realIm_dbs_glcmfeat, '.jpg', 20)
[realIm_dbs_texturefeat_AF1, realIm_dbs_texturefeat_ANMRR] = CBIR_Retrieve(realIm_dbs_path,realIm_dbs_texturefeat, '.jpg', 20)
[realIm_jpg_dbs_lbpfeat_AF1, realIm_jpg_dbs_lbpfeat_ANMRR] = CBIR_Retrieve(realIm_jpg_dbs_path,realIm_jpg_dbs_lbpfeat, '.jpg', 20)
[realIm_jpg_dbs_glcmfeat_AF1, realIm_jpg_dbs_glcmfeat_ANMRR] = CBIR_Retrieve(realIm_jpg_dbs_path,realIm_jpg_dbs_glcmfeat, '.jpg', 20)
[realIm_jpg_dbs_texturefeat_AF1, realIm_jpg_dbs_texturefeat_ANMRR] = CBIR_Retrieve(realIm_jpg_dbs_path,realIm_jpg_dbs_texturefeat, '.jpg', 20)
[realIm_jp2_dbs_lbpfeat_AF1, realIm_jp2_dbs_lbpfeat_ANMRR] = CBIR_Retrieve(realIm_jp2_dbs_path,realIm_jp2_dbs_lbpfeat, '.jp2', 20)
[realIm_jp2_dbs_glcmfeat_AF1, realIm_jp2_dbs_glcmfeat_ANMRR] = CBIR_Retrieve(realIm_jp2_dbs_path,realIm_jp2_dbs_glcmfeat, '.jp2', 20)
[realIm_jp2_dbs_texturefeat_AF1, realIm_jp2_dbs_texturefeat_ANMRR] = CBIR_Retrieve(realIm_jp2_dbs_path,realIm_jp2_dbs_texturefeat, '.jp2', 20)
%% realIm_dbs. Color feature + Texture feature Retrieval
[realIm_dbs_jointfeat_AF1, realIm_dbs_jointfeat_ANMRR] = CBIR_JointFeature_Retrieve(realIm_dbs_path, realIm_dbs_colorfeat, realIm_dbs_texturefeat, '.jpg', 20)
[realIm_jpg_dbs_jointfeat_AF1, realIm_jpg_dbs_jointfeat_ANMRR] = CBIR_JointFeature_Retrieve(realIm_jpg_dbs_path, realIm_jpg_dbs_colorfeat, realIm_jpg_dbs_texturefeat, '.jpg', 20)
[realIm_jp2_dbs_jointfeat_AF1, realIm_jp2_dbs_jointfeat_ANMRR] = CBIR_JointFeature_Retrieve(realIm_jp2_dbs_path, realIm_jp2_dbs_colorfeat, realIm_jp2_dbs_texturefeat, '.jp2', 20)
%% texture. Texture feature Retrieval
[texture_dbs_lbpfeat_AF1, texture_dbs_lbpfeat_ANMRR] = CBIR_Retrieve(texture_dbs_path,texture_dbs_lbpfeat, '.tif', 9)
[texture_dbs_glcmfeat_AF1, texture_dbs_glcmfeat_ANMRR] = CBIR_Retrieve(texture_dbs_path,texture_dbs_glcmfeat, '.tif', 9)
[texture_dbs_texturefeat_AF1, texture_dbs_texturefeat_ANMRR] = CBIR_Retrieve(texture_dbs_path,texture_dbs_texturefeat, '.tif', 9)
[texture_jpg_dbs_lbpfeat_AF1, texture_jpg_dbs_lbpfeat_ANMRR] = CBIR_Retrieve(texture_jpg_dbs_path,texture_jpg_dbs_lbpfeat, '.jpg', 9)
[texture_jpg_dbs_glcmfeat_AF1, texture_jpg_dbs_glcmfeat_ANMRR] = CBIR_Retrieve(texture_jpg_dbs_path,texture_jpg_dbs_glcmfeat, '.jpg', 9)
[texture_jpg_dbs_texturefeat_AF1, texture_jpg_dbs_texturefeat_ANMRR] = CBIR_Retrieve(texture_jpg_dbs_path,texture_jpg_dbs_texturefeat, '.jpg', 9)
[texture_jp2_dbs_lbpfeat_AF1, texture_jp2_dbs_lbpfeat_ANMRR] = CBIR_Retrieve(texture_jp2_dbs_path,texture_jp2_dbs_lbpfeat, '.jp2', 9)
[texture_jp2_dbs_glcmfeat_AF1, texture_jp2_dbs_glcmfeat_ANMRR] = CBIR_Retrieve(texture_jp2_dbs_path,texture_jp2_dbs_glcmfeat, '.jp2', 9)
[texture_jp2_dbs_texturefeat_AF1, texture_jp2_dbs_texturefeat_ANMRR] = CBIR_Retrieve(texture_jp2_dbs_path,texture_jp2_dbs_texturefeat, '.jp2', 9)