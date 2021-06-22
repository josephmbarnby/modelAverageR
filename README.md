# modelCompareR
Package to average regression models.

The package analyses your data using multi-model selection with model averaging. AICc and BIC values are used to evaluate models. Lower AICc and BIC values indicates a better fit. To adjust for the intrinsic uncertainty over which model is the true ‘best’ model, models in the top model set (those with the smallest AICc and BIC values) to generate model-averaged effect sizes and confidence intervals. Parameter estimates and confidence intervals are provided with the full global model to robustly report a variable's effect in a model. This package relies on the work from the ‘MuMIn’ package. Visualizations are generated using the package ‘ggplot2’.

# To install:
install.packages('devtools')
devtools::install_github("josephmbarnby/modelCompareR")
