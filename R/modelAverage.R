
modelAverage <- function(formula, dat, modelclass = 'lm', REML = F, scale = F, include, threshold = 2, family = 'binomial', plot = F){

  dat = data_frame(dat)

  if(scale){
  include = as.vector(include)
  dat[include] = sapply(dat[include], scale)
  }

  zX   = as.formula(formula)

  #First create overall model #
  if       (modelclass == 'lm'){
  x <- lm(formula = zX,   data = dat, na.action = na.fail)
  } else if(modelclass == 'lmer'){
  x <- lmer(formula = zX, data = dat, na.action = na.fail)
  } else if(modelclass == 'clm'){
  x <- clm(formula = zX,  data = dat, na.action = na.fail)
  } else if(modelclass == 'clmm'){
  x <- clmm(formula = zX,  data = dat, na.action = na.fail)
  } else if(modelclass == 'glm'){
  x <- glm(formula = zX,  data = dat, na.action = na.fail, family = family)
  } else if(modelclass == 'glmer'){
  x <- glmer(formula = zX,  data = dat, na.action = na.fail, family = family)
  }

  #run MuMIn model averaging
  x.set          <- dredge    (x, REML = REML, trace = 2)
  x.models       <- get.models(x.set, subset = delta<threshold)
  x.a            <- try(model.avg (x.models, adjusted=FALSE, revised.var=TRUE), silent = T)

  if(class(x.a) == "try-error"){
  coefs <- as.data.frame(summary(x)[4])
  coefs$term <- rownames(coefs)
  coefs$conf.low <- confint(x)[,1]
  coefs$conf.high<- confint(x)[,2]
  colnames(coefs)[1] <- c('estimate')
  list(summary(x), confint(x))
  #summarize global model
  } else {
  coefs <- as.data.frame(summary(x.a)[9])
  coefs$term <- rownames(coefs)
  coefs$conf.low <- confint(x.a)[,1]
  coefs$conf.high<- confint(x.a)[,2]
  colnames(coefs)[1] <- c('estimate')
  return(list(Summary = summary(x.a), ConfidenceInterval = confint(x.a), Importance = importance(x.a)))
  }

  #plot models

  if(plot){

  coefPlot <- ggplot(coefs %>%
     mutate(term = fct_reorder(term, estimate, .desc = T))) +

    geom_pointrange(aes(x=term, y=estimate, ymin=conf.low, ymax=conf.high)) +
    geom_hline(yintercept = 0, col = "orange") +
    labs(y = 'Estimate')+
    theme_minimal()+
    theme(axis.title.x = element_blank(),
          axis.title = element_text(size =14),
          axis.text = element_text(size =14))

  if(class(x.a) == "try-error"){
  return(list(summary(x), confint(x), coefPlot))
  }else{
  return(list(summary(x.a), confint(x.a), coefPlot))
  }
  }
}
