# modelAverageR
Package to average regression models.

The package analyses your data using multi-model selection with model averaging. AICc and BIC values are used to evaluate models. Lower AICc and BIC values indicates a better fit. To adjust for the intrinsic uncertainty over which model is the true ‘best’ model, models in the top model set (those with the smallest AICc and BIC values) to generate model-averaged effect sizes and confidence intervals. Parameter estimates and confidence intervals are provided with the full global model to robustly report a variable's effect in a model. This package relies on the work from the ‘MuMIn’ package. Visualizations are generated using the package ‘ggplot2’.

# To install:
```r
install.packages('devtools')

devtools::install_github("josephmbarnby/modelAverageR")
```
# Test out a dummy model for averaging:

### Generate some synthetic data
```r
x <- rnorm(n = 1000, mean = 2, sd = 0.2)

y <- rnorm(n = 1000, mean = 0, sd = 0.5)

z <- rnorm(n = 1000, mean = 5, sd = 1)

Age <- sample(20:65, 1000, replace = T)

myDF <- data.frame(
x = x,
y = y,
z = z,
Age = Age,
ID = 1:1000
)

print(head(myDF))
```
```
         x          y        z Age ID
1 1.794459  0.3321375 5.613330  57  1
2 1.980460  0.2286129 5.932073  56  2
3 2.214344  0.6256977 4.806339  27  3
4 2.324796 -0.4556733 4.663179  41  4
5 2.067373  0.6626385 6.047488  54  5
6 2.024276  0.4419657 5.564300  36  6
```
### Create a formula
```r
formula <- as.formula(x ~ y + z + Age)
```
### Run the comparison (no scaling)

The function won't automatically scale your variables and will keep them as you left it unless told otherwise.

```r

modelAverage(formula = formula, dat = myDF, REML = F, plot = F)

print(xTest)
```

### Run the comparison (with scaling)

If you would like it to also scale your variables, you need to include the 'scale = T' flag and then also specify in your data frame which columns you want the function to scale for you using the 'include' argument. The vector you pass to 'include' must match your column names in your dataframe.

```r

modelAverage(formula = formula, dat = myDF, REML = F, scale = T, include = c('x', 'y', 'z', 'Age'), plot = F)

```
### Run the comparison (with a plot)

You can also plot your regression output using the 'plot' argument which will automatically order your variables from highest (>0) to lowest (<0) beta coefficients. The plot function operate irrespective of whether you want to scale your variables or not.

```r

modelAverage(formula = formula, dat = myDF, REML = F, scale = T, include = c('x', 'y', 'z', 'Age'), plot = T)

```
