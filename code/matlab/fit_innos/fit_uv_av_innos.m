function fit_uv_av_innos(to_fit,init_par,npars_est,n_var,file_prefix)

npop = 1000;
paramstoest = 1:npars_est;

uv_av_opt = @(x) uv_av_mobj_innos(x,n_var,to_fit);

lb = zeros(1,npars_est);
ub = 1*ones(1,npars_est);

first_pop = scaled_lhsdesign(npop, npars_est, [lb(paramstoest);ub(paramstoest)]);
pop=first_pop;
if ~isempty(init_par)
    pop(1:size(init_par,1),:)=init_par;
end

first_scores = NaN(npop,2);

% Calculate scores for each initial population
tic
parfor fs_idx=1:npop
    first_scores(fs_idx,:) = uv_av_opt(pop(fs_idx,:));
end
toc
disp('1st scores done')

options1 = optimoptions('gamultiobj','UseParallel', true, ...
    'PopulationSize', npop);%,'PlotFcn',@gaplotpareto);

options2 = options1;
options2.MaxTime = 600; % maximum GA time
options2.Display = 'none';
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=first_scores;
options2.MaxStallGenerations = 100;
options2.MaxGenerations = 300;
% options2.Display = 'iter';
options2.CrossoverFcn={'crossoverheuristic'};
%options2.CrossoverFcn={'crossoverscattered'};
tic
[x,fval,exitflag,output,population,scores] = gamultiobj(uv_av_opt, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);
toc
disp('1st done')

lb = zeros(1,npars_est);
ub = 5*ones(1,npars_est);

first_pop = scaled_lhsdesign(npop, npars_est, [lb(paramstoest);ub(paramstoest)]);
pop=first_pop;
pop(1:size(x,1),:)=x;

first_scores = NaN(npop,2);
% Calculate scores for each initial population
tic
parfor fs_idx=1:npop
    first_scores(fs_idx,:) = uv_av_opt(pop(fs_idx,:));
end
toc
disp('2nd scores done')

options1 = optimoptions('gamultiobj','UseParallel', true, ...
    'PopulationSize', npop);%,'PlotFcn',@gaplotpareto);

options2 = options1;
options2.MaxTime = 600; % maximum GA time
options2.Display = 'none';
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=first_scores;
options2.MaxStallGenerations = 100;
options2.MaxGenerations = 300;
% options2.Display = 'iter';
%options2.CrossoverFcn={'crossoverheuristic'};
options2.CrossoverFcn={'crossoverscattered'};
tic
[x,fval,exitflag,output,population,scores] = gamultiobj(uv_av_opt, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);
toc
disp('2nd done')

INNOS.x=x;
INNOS.fval=fval;
INNOS.scores=scores;

save([file_prefix '_INNOS.mat'],'INNOS')
