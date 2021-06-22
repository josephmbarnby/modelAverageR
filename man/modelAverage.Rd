\name{modelAverage}
\alias{modelAverage}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{modelAverage
%%  modelCompare
}
\description{
%%  The package analyses your data using multi-model selection with model averaging. AICc and BIC values are used to evaluate models. Lower AICc and BIC values indicates a better fit. To adjust for the intrinsic uncertainty over which model is the true ‘best’ model, models in the top model set (those with the smallest AICc and BIC values) to generate model-averaged effect sizes and confidence intervals. Parameter estimates and confidence intervals are provided with the full global model to robustly report a variable's effect in a model. This package relies on the work from the ‘MuMIn’ package. Visualizations are generated using the package ‘ggplot2’.
}
\usage{
modelAverage(x, data = data, modelclass = lm, REML = F, scale = F, include, plot = F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A formula that corresponds to the data in your dataframe.
}
  \item{data}{
A dataframe with columns that correspond to the objects in your formula.
}
  \item{modelclass}{
Whether the model should be a linear model, general linear model, cumulative link model, mixed effects model etc. Default is 'lm'. You must install dependencies for whichever type of model you want to use with the function.
}
  \item{REML}{
Whether you want to average the models using REML rather than AIC or BIC values. Defaults to FALSE.
}
  \item{scale}{
Do you want some variables scaled (keeping the same distribution) to normalise estimates?. Defaults to FALSE. If TRUE, you must specify which variables to include (see below)
}
  \item{include}{
If Scale == TRUE. A vector of character strings which match the column names you want to scale. NB: Will not break the model if Scale == FALSE but will not do anythign either.
}
  \item{threshold}{
The threshold at which algorithm will retain models to average over relative to the best fitting model (quanitifed by the AICc). E.g. if the delta is 2, the function will retain all models that are AICc < 2 away from the best fitting model to average over. Default is 2.
}
  \item{family}{
If using a the glmer model will allow specification of whether a guassian, binomial, gamma, poisson etc. model is to be used. See ?glm and ?gmer for more details.
}
  \item{plot}{
Whether you want a plot of the estimates. Defaults to FALSE.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% Grueber et al., 2011; Wickham, 20160; Burnham & Anderson, 2004; Barton, 2018
}
\author{
%%   J.M. Barnby
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

##Generate some synthetic data
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

##Create a formula
formula <- as.formula(x ~ y + z + Age)

##Run the comparison (no scaling)
modelAverage(formula = formula, data = myDF, REML = F, plot = F)


##Run the comparison (with scaling)
modelAverage(formula = formula, data = myDF, REML = F, scale = F, include = c('x', 'y', 'z', 'Age'), plot = F)

##Run the comparison (with a plot)
modelAverage(formula = formula, data = myDF, REML = F, scale = F, include = c('x', 'y', 'z', 'Age'), plot = T)


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
