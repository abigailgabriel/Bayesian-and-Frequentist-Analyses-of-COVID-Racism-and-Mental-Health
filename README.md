# Perceived COVID-19-Related Racial Discrimination and Mental Health of Asian Americans: A Comparison of Frequentist and Bayesian Approaches

In this project, I examined the relations between perceived COVID-19-related racial discrimination and three mental health measures for Asian American adults using frequentist and Bayesian regression analyses.

## Frequentist Multiple Regression Analyses

Three frequentist multiple linear regression analyses were performed to test the hypothesis that COVID-19-related discrimination would predict poorer mental health among Asian American adults across three outcome variables: the Brief Hypervigilance Scale, Hopkins Symptom Checklist, and Mental Health Inventory. Each multiple regression model contained the following four COVID-19-related racial discrimination predictors: Personal Experience of Racial Cyber-Aggression (PERCA); Online-Mediated Exposure to Racist Reality (OMERR); Vicarious Exposure to Racial Cyber-Aggression (VERCA); and Exposure to COVID-19-Specific Racism (COVID). These three multiple regression models are represented by the following equations:  

BHSi = β0 + β1PERCAi + β2OMERRi + β3VERCAi + β4COVIDi + εi 		(1)

HSCi = β0 + β1PERCAi + β2OMERRi + β3VERCAi + β4COVIDi + εi 		(2)

MHIi = β0 + β1PERCAi + β2OMERRi + β3VERCAi + β4COVIDi + εi 		(3)

## Bayesian Multiple Regression Analyses

Three Bayesian normal theory multiple linear regression analyses were performed to test the same hypothesis that COVID-19-related discrimination would predict poorer mental health among Asian American adults. Each outcome was specified by the following three equations:

BHSi | xi1, xi2, xi3, xi4, β0, β1, β2, β3, β4, σε ~ N(β0 + β1xi1 + β2xi2 + β3xi3 + β4xi4, σε)	(4)

HSCi | xi1, xi2, xi3, xi4, β0, β1, β2, β3, β4, σε ~ N(β0 + β1xi1 + β2xi2 + β3xi3 + β4xi4, σε)	(5)

MHIi | xi1, xi2, xi3, xi4, β0, β1, β2, β3, β4, σε ~ N(β0 + β1xi1 + β2xi2 + β3xi3 + β4xi4, σε)	(6)

Moreover, I employed diffuse prior distributions for β0 and σε: β0 ~ N(0, 30); σε ~ Exponential(1). However, based on findings from meta-analyses on the association between racial discrimination and mental health for Asian Americans (Lee & Ahn, 2011) and racial minorities generally (Paradies et al., 2015), I specified more informative prior distributions for the four COVID-19-related racial discrimination predictors: βj ~ N(.23, .03), where j = 1, 2, 3, 4). For each model, four chains were run for 5,000 iterations following a warmup period of 1,000 iterations.