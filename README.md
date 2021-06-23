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
```r
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
```r

xTest <- modelAverage(formula = formula, dat = myDF, REML = F, plot = F)

print(xTest)
```
$Summary

Call:
model.avg(object = x.models, adjusted = FALSE, revised.var = TRUE)

Component model call: 
lm(formula = x ~ <5 unique rhs>, data = dat, na.action = na.fail)

Component models: 
       df logLik    AICc delta weight
(Null)  2 191.81 -379.60  0.00   0.29
3       3 192.64 -379.26  0.34   0.25
1       3 192.35 -378.68  0.92   0.18
13      4 193.21 -378.38  1.21   0.16
2       3 191.88 -377.73  1.87   0.11

Term codes: 
Age   y   z 
  1   2   3 

Model-averaged coefficients:  
(full average) 
              Estimate Std. Error Adjusted SE z value Pr(>|z|)    
(Intercept)  2.0265650  0.0338890   0.0339103  59.762   <2e-16 ***
z           -0.0033505  0.0057163   0.0057198   0.586    0.558    
Age         -0.0001770  0.0003761   0.0003764   0.470    0.638    
y           -0.0005670  0.0047501   0.0047552   0.119    0.905    
 
(conditional average) 
              Estimate Std. Error Adjusted SE z value Pr(>|z|)    
(Intercept)  2.0265650  0.0338890   0.0339103  59.762   <2e-16 ***
z           -0.0082312  0.0063326   0.0063403   1.298    0.194    
Age         -0.0005138  0.0004874   0.0004880   1.053    0.292    
y           -0.0049333  0.0132202   0.0132362   0.373    0.709    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


$ConfidenceInterval
                   2.5 %       97.5 %
(Intercept)  1.960101968 2.0930279733
z           -0.020657983 0.0041955226
Age         -0.001470208 0.0004426818
y           -0.030875847 0.0210091566

$Importance
                     z    Age  y   
Sum of weights:      0.41 0.34 0.11
N containing models:    2    2    1

### Run the comparison (with scaling)
```r

modelAverage(formula = formula, dat = myDF, REML = F, scale = T, include = c('x', 'y', 'z', 'Age'), plot = F)

```
### Run the comparison (with a plot)
```r

modelAverage(formula = formula, dat = myDF, REML = F, scale = T, include = c('x', 'y', 'z', 'Age'), plot = T)

```
