# Applications pédagogiques ShinyR 

- Executez les commandes suivantes (où mon projet sera à remplacer par le nom de votre projet au sein duquel se trouve votre appli shiny):
```
oc project irmar
```

```
oc new-project shiny-irmar
oc process --parameters shiny-centos7 -n openshift
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DIR=coef_correlation -p APPLICATION_NAME=coef_correlation
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_binomiale -p APPLICATION_NAME=loi_binomiale
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_exponentielle -p APPLICATION_NAME=loi_exponentielle
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_fisher -p APPLICATION_NAME=loi_fisher
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_khi2 -p APPLICATION_NAME=loi_khi2
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_normale -p APPLICATION_NAME=loi_normale
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_poisson -p APPLICATION_NAME=loi_poisson
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_student -p APPLICATION_NAME=loi_student
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=loi_uniforme -p APPLICATION_NAME=loi_uniforme
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p CONTEXT_DI    R=vec_gaussiens -p APPLICATION_NAME=vec_gaussiens
