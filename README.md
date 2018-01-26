# Emergent-constraint-regression
Code for regression analysis for emergent constraints, with data from Brient and Schneider (2016)

Brient-Schneider-2016-DV-data.mat contains data for deseasonalized variability from Fig. 6 in Brient and Schneider (2016):

	•	ECS: equilibrium climate sensitivity from nmod = 29 climate models
	•	dadT_mod(nmod, nboot_mod): dalpha/dT (variation of TLC reflection with SST) for nmod models and nboot_mod stationary bootstrap samples from the models
	•	dadT_obs(nboot_obs): dalpha/dT from observations, for nboot_obs bootstrap samples
	•	mean_dadT_mod(nmod): mean of da/dT for each of nmod models
	•	mean_dadT_obs(nmod): mean of da/dT for observations
	
EC_regression.m contains Matlab code for plotting the data and obtaining a regression-based PDF for the ECS, given the observations.

What is to be kept in mind that the spread of the estimated ECS underestimates the true uncertainties, for a variety of reasons, ranging from the inadequacy of assuming a linear relationship between ECS and da/dT, over selection bias induced by the preprocessing of the data, to the fact that the model ensemble is not adequately representing uncertainty. 
