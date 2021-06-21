# DV: Brief Hypervigilance Scale ------
BHSmodel <- lm(BHS ~ PERCA + OMERR + VERCA + COVID, data = Bayesian_Data_Set)
summary(BHSmodel)
confint(BHSmodel, level=0.95)
modelEffectSizes(BHSmodel)

# DV: Hopkins Symptom Checklist ------
HSCmodel <- lm(HSC ~ PERCA + OMERR + VERCA + COVID, data = Bayesian_Data_Set)
summary(HSCmodel)
confint(HSCmodel, level=0.95)
modelEffectSizes(HSCmodel)


# DV: Mental Health Inventory ------
MHImodel <- lm(MHI ~ PERCA + OMERR + VERCA + COVID, data = Bayesian_Data_Set)
summary(MHImodel)
confint(MHImodel, level=0.95)
modelEffectSizes(MHImodel)

