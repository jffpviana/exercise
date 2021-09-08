# Identification of sites that define the north vs south aliens

## Brief description of the contents of this repository
- data - data files generated during analysis.
- functions - additional functions created for analysis.
- metadata - metadata of samples.
- plots - plots generated during analysis.
- raw_data - original counts data of moifications A and B for north and sourth aliens.
- results - results tables and plots.
- scripts - analysis scripts.

## Approach

### Phase 1
My approach was to use an appropriate statistical model to identify significant differences between the two groups (south and north). 
First, I formated the data (_scripts/phase1/1.format_data.r_). The data provided contains counts of either modification A or B for each site and each sample. I calculated the proportion of modification A for each site and sample using the following formula:

_proportion A = counts A/(counts A + counts B)_

The script for this step can be found in _scripts/phase1/2.proportions.r_ and the output is in _data/alien_proportionA.csv_.

Next, I also calculated the total counts (i.e. coverage) for each site and each sample by adding the counts of modification A and the counts of modification B. This can later inform us about samples that have lower, and perhaps unreliable, number of counts. The script for this step is in _scripts/phase1/3.coverage.r_.

I then inspected the proportion data to look at the overall distribution of data (_scripts/phase1/4.exploring_data.r_). I plotted a histogram and a density plot, which can be found in _plots/modifications_distribution.pdf_. 
The data resembles a guassian distribution, except for a peak around 1 (only modification A). Based on this observation I decided to use a linear regression to look for statistical differences between the two groups of samples at each site, where propotion of A is the independent variable and region (north vs south) is the dependent/explanatory variable. In this case north is coded as 0 and south is coded as 1. The script for this step is in _scripts/phase1/5.linear_regression.r_.

On this first, exploratory phase I decided to perform the test to all sites without excluding low coverage or non-variable sites. We can then inspect the results and decided if we want to exclude those at a later stage.

The results table ordered from most significant (lowest p-value) to least significant site can be found in _results/alien_linear_regression.xlsx_. This also includes the False Discovery Rate (FDR) corrected p-values. Given that we are repeating the linear regression across so many sites it is important to correct for the multiple tests we are doing as this increases our probability of identifying false positives.
Even though this approach identified a few sites that have a p-value < 0.05, the FDR corrected p-values are not significant. This is most likely due to a low statistical power (limited number of samples compared to the large amount of sites tested). Given our limited amount of samples methods such as FDR or Bonferroni threshold are probably too stringent for an initial exploratory analysis. 

I plotted the qq-plot showing the theoretical quantiles vs experimental quantiles (p-value) (script: _scripts/phase1/6.qq_plots.r_; plot: _plots/qq_linear_regression.pdf_). For easier visualisation I plotted the -log10 transformation of both p-values and theoretical quantiles.
This will help us identify if the results showed inflation. In a well powered analysis we can expect the p-values to strongly correlate with the theoretical quantiles, except for the most significant ones which should depart from the line. In an inflated analysis, many p-values depart from the line and are lower than expected by chance.
The qq-plot for this analysis doesn't suggest inflation. There is also a suggestion that the top 15 sites might be truly different between samples, even though the p-values don't deviate much from the line. This confirms that our analysis is under-powered.

In an attempt to improve the confidence in the results I performed a second phase.

### Phase 2

My first attempt was to remove sites that do not vary much across samples. These sites are unlikely to show significantly different levels of modifications A and B between north and south. By removing these from the analysis we can marginall improve out power by performing fewer tests.

In _phase2/1.nonvariable_filter.r_ I identified which sites were non-variable across samples. I defined a non-variable site as showing less than a 0.05 (5%) shift in modification A proportion between the 10th and 90th percentiles. No sites were identified as non-variable so I didn't remove any at this stage.

I then attempted to identify sites with lower coverage (_scripts/phase2/2.coverage_filter.r_). These sites show fewer total counts and calculating the proportion of modifications for these sites might not be reliable. I kept sites that have at least 10 total counts in at least 2 samples per group (north and south). 154 sites were removed. The resulting filtered dataset can be found in _data/alien_proportionA_filter10cov.csv_.

Finally I performed the linear regression again on the filtered selection of sites (_scripts/phase2/3.linear_regression_filtered.r_) and re-did the qq-plot (script: _scripts/phase2/4.qq_plots.r_; plot: _plots/qq_linear_regression_filtered10cov.pdf_). 
The results of the linear regression can be seen in _results/alien_linear_regression_filtered10cov.xlsx_.
Removing lowly covered sites did not improve the FDR corrected p-values enough to identify any statistical significant sites.

I added a script to plot the boxplots + scatter plots of the top most significant sites (_scripts/phase2/5.boxplots.r_).

The plots for the sites with pvalue < 0.01 can be observed in _results/boxplots_linear_regression_filtered10cov.pdf_. 











 
