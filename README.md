# Perceived COVID-19-Related Racial Discrimination and Mental Health of Asian Americans: A Comparison of Frequentist and Bayesian Approaches

The weaponization of COVID-19 to produce anti-Chinese rhetoric has resulted in an increase of racism towards Asian Americans living in the United States. In this project, I examined the relations between perceived COVID-19-related racial discrimination and three measures of mental health (i.e., Hypervigilance Scale, Hopkins Symptoms Checklist, Mental Health Inventory) for Asian American adults using frequentist and Bayesian regression analyses. Results from both the frequentist and Bayesian analyses indicated that perceived COVID-19-related racial discrimination predicted increased hypervigilance, psychosomatic symptoms, and psychological distress for Asian Americans. In a comparison of the approaches, the Bayesian regression models consistently produced parameters with smaller standard deviations and larger means of the R^2 distributions.

## Frequentist Multiple Regression Analyses

Three frequentist multiple linear regression analyses were performed to test the hypothesis that COVID-19-related discrimination would predict poorer mental health for Asian American adults across three outcome variables: the Brief Hypervigilance Scale, Hopkins Symptom Checklist, and Mental Health Inventory. Each multiple regression model contained the following four COVID-19-related racial discrimination predictors: Personal Experience of Racial Cyber-Aggression (PERCA); Online-Mediated Exposure to Racist Reality (OMERR); Vicarious Exposure to Racial Cyber-Aggression (VERCA); and Exposure to COVID-19-Specific Racism (COVID). These three multiple regression models are represented by the following equations:  

BHSi = β0 + β1PERCAi + β2OMERRi + β3VERCAi + β4COVIDi + εi 		(1)

HSCi = β0 + β1PERCAi + β2OMERRi + β3VERCAi + β4COVIDi + εi 		(2)

MHIi = β0 + β1PERCAi + β2OMERRi + β3VERCAi + β4COVIDi + εi 		(3)

<img width="492" alt="image" src="https://user-images.githubusercontent.com/86257471/204575744-7a3909ed-3cd6-44f6-81e9-e325c3dcea10.png">


## Bayesian Multiple Regression Analyses

Three Bayesian normal theory multiple linear regression analyses were performed to test the same hypothesis that COVID-19-related discrimination would predict poorer mental health among Asian American adults. Each outcome was specified by the following three equations:

BHSi | xi1, xi2, xi3, xi4, β0, β1, β2, β3, β4, σε ~ N(β0 + β1xi1 + β2xi2 + β3xi3 + β4xi4, σε)	(4)

HSCi | xi1, xi2, xi3, xi4, β0, β1, β2, β3, β4, σε ~ N(β0 + β1xi1 + β2xi2 + β3xi3 + β4xi4, σε)	(5)

MHIi | xi1, xi2, xi3, xi4, β0, β1, β2, β3, β4, σε ~ N(β0 + β1xi1 + β2xi2 + β3xi3 + β4xi4, σε)	(6)

<img width="435" alt="Screen Shot 2022-11-29 at 10 51 54 AM" src="https://user-images.githubusercontent.com/86257471/204577379-b6d12549-7a33-448e-aa02-ef86c1fbea71.png">

<img width="449" alt="Screen Shot 2022-11-29 at 10 52 05 AM" src="https://user-images.githubusercontent.com/86257471/204577424-d643a913-b994-49a9-b4e0-1de010fc2e24.png">

<img width="428" alt="Screen Shot 2022-11-29 at 10 52 10 AM" src="https://user-images.githubusercontent.com/86257471/204577448-07090f5d-fc1b-4086-97c6-e05eb36be7c8.png">


Moreover, I employed diffuse prior distributions for β0 and σε: β0 ~ N(0, 30); σε ~ Exponential(1). However, based on findings from meta-analyses on the association between racial discrimination and mental health for Asian Americans (Lee & Ahn, 2011) and racial minorities generally (Paradies et al., 2015), I specified more informative prior distributions for the four COVID-19-related racial discrimination predictors: βj ~ N(.23, .03), where j = 1, 2, 3, 4). For each model, four chains were run for 5,000 iterations following a warmup period of 1,000 iterations.

## Comparison of Frequentist and Bayesian Analyses

<img width="556" alt="Screen Shot 2022-11-29 at 10 46 41 AM" src="https://user-images.githubusercontent.com/86257471/204576073-a241937c-9b3f-41c4-8d26-9efea3586f78.png">

<img width="561" alt="Screen Shot 2022-11-29 at 10 47 30 AM" src="https://user-images.githubusercontent.com/86257471/204576261-45d7c137-9bcd-4ef4-808e-a733f876a269.png">

<img width="571" alt="Screen Shot 2022-11-29 at 10 47 53 AM" src="https://user-images.githubusercontent.com/86257471/204576335-65549e5a-72fe-48fb-b2d0-855f45941cbc.png">


