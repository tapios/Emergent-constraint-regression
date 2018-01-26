load('Brient-Schneider-2016-DV-data')

nmodels     = length(ECS);          % number of models
nboot_obs   = size(dadT_obs, 2);    % size of bootstrap sample of observations

% scatter plot and regression line
figure(1)
clf
scatter(mean_dadT_mod, ECS)
modlabel = cellstr(num2str([1:nmodels]'));
text(mean_dadT_mod, ECS, modlabel);
hold on
[B, stats]  = robustfit(mean_dadT_mod, ECS);
plot(mean_dadT_mod, B(1)+B(2)*mean_dadT_mod)

% regression estimate of ECS PDF by bootstrap
%regression  = 'robust';             % regression method ('robust, 'ols') 
regression  = 'ols';      
nboot       = 10000;                % size of bootstrap sample;
ECSboot = zeros(nboot, 1);
for j=1:nboot
    ib      = randsample(nmodels, nmodels, 1); 
    switch regression
        case 'robust'   % robust regression
            [B, stats] = robustfit(dadT_mod(ib, randsample(nboot_obs, 1)), ECS(ib));
            %[B, stats] = robustfit(mean_model_obs(ib), ECS(ib));
            sigma      = stats.s;
        case 'ols'      % ordinary least squares
            [B, BINT, R, RINT, STATS] = regress(ECS(ib), [ones(nmodels, 1) mean_dadT_mod(ib)]);
            sigma      = sqrt(STATS(4));
    end
    
    % predicted ECS (with normal errors)
    ECSboot(j) = B(1)+B(2)*dadT_obs(1, randsample(nboot_obs, 1)) + sigma*randn(1);
    %ECSboot(j) = B(1)+B(2)*mean_dadT_obs + sigma*randn(1);  % prediction from mean obs
end
ECSboot    = sort(ECSboot);

figure(2)
clf
histogram(ECSboot)

% some statistics
ECS_med    = median(ECSboot);
conf_int   = .66;
[ECSboot(round((1-conf_int)/2*nboot)), ECS_med, ECSboot(round((1+conf_int)/2*nboot))]

max(find(ECSboot<2.61))/nboot

