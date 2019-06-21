%%2ndlvl batching
%%@Author: Cristina Perez
%% Day: 06/05/2019
%% Description: saves SPM for 2nd lvl analysis


warning off;
spm('defaults', 'FMRI');
spm_jobman('initcfg');


load('spm_2ndlvl')

second_lvl = pwd;
cd ..
rhythm_param
cd ..
cd data
data = pwd;
cd 2ndlvl
secondlvl = pwd;
numcond = 5;






contrasts = {'oddball_silence','fast_slow','slow_fast','complex_simple','simple_complex'};
for i = 1:numcond
    
        % for this study 2 runs only kept for 2ndlvl
    file_name = strcat('con_000', num2str(i),'.nii');
    
    
    %different implementation from Dr Lee but seems to work
    k1 = fullfile(data, param(1).name, 'design','rhythm', file_name);
    k2 = fullfile(data, param(4).name, 'design','rhythm', file_name);
    k3 = fullfile(data, param(5).name, 'design','rhythm', file_name);
    k4 = fullfile(data, param(7).name, 'design','rhythm', file_name);
    k5 = fullfile(data, param(8).name, 'design','rhythm', file_name);
    k = [k1;k2;k3;k4;k5];
    kc = cellstr(k);
  
%directory is a folder named after contrast in 2ndlvl
dir_cont = fullfile(secondlvl, contrasts{i});
matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(dir_cont);

%need to load in 5 (one per subject) per contrast
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = kc;

%     Save files

 
    filename = fullfile(secondlvl, contrasts{numcond}, 'build_contrasts_2ndlvl.mat');
    save(filename, 'matlabbatch');
    
    % Run job
    spm_jobman('run', matlabbatch);
    
end







