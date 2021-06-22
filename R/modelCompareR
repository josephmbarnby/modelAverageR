
modelCompare <- function(formula, data, modeltype = lm, REML = F, scale = F, include, plot = F){ # X needs to be a formula

  data = as.data.frame(data)

  if(scale){
  include = as.vector(include)
  data[include] = sapply(data[include], scale)
  }

  formula = as.formula(formula)
  #First create overall model #
  modelclass <- as.function(modeltype)
  x <- modelclass(formula = formula, data = data, na.action = na.fail)

  #run MuMIn model averaging
  x.set          <- dredge    (x, REML = REML, trace = 2)
  x.models       <- get.models(x.set, subset = delta<2)
  x.a            <- try(model.avg (x.models, adjusted=FALSE, revised.var=TRUE), silent = T)

  if(class(x.a) == "try-error")
  {
  print(summary(x))
  print(confint(x))
  coefs <- as.data.frame(summary(x)[4])
  coefs$term <- rownames(coefs)
  coefs$conf.low <- confint(x)[,1]
  coefs$conf.high<- confint(x)[,2]
  colnames(coefs)[1] <- c('estimate')
  #summarize global model
  } else {
  print(summary(x.a))
  print(importance(x.a))
  print(confint(x.a))
  coefs <- as.data.frame(summary(x.a)[9])
  coefs$term <- rownames(coefs)
  coefs$conf.low <- confint(x.a)[,1]
  coefs$conf.high<- confint(x.a)[,2]
  colnames(coefs)[1] <- c('estimate')
  }

  #plot models

  if(plot){

  ggplot(coefs %>%
     mutate(term = fct_reorder(term, estimate, .desc = T))) +

    geom_pointrange(aes(x=term, y=estimate, ymin=conf.low, ymax=conf.high)) +
    geom_hline(yintercept = 0, col = "orange") +
    labs(y = 'Estimate')+
    theme_minimal()+
    theme(axis.title.x = element_blank(),
          axis.title = element_text(size =14),
          axis.text = element_text(size =14))
  }
}
