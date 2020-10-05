# Applications pédagogiques ShinyR 

- Executez les commandes suivantes (où mon projet sera à remplacer par le nom de votre projet au sein duquel se trouve votre appli shiny):
```
oc project irmar
```

```
oc new-project shiny-irmar
oc process --parameters shiny-centos7 -n openshift
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p APPLICATION_NAME=coef-correlation -p SOURCE_REPOSITORY_TAG=coef_correlation -p BUILD_MEMORY_REQUEST=1Gi

oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_binomiale -p APPLICATION_NAME=loi-binomiale -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_exponentie-p APPLICATION_NAME=loi-exponentielle -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_fisher    -p APPLICATION_NAME=loi-fisher -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_khi2      -p APPLICATION_NAME=loi-khi -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_normale   -p APPLICATION_NAME=loi-normal -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_poisson   -p APPLICATION_NAME=loi-poisso -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_student   -p APPLICATION_NAME=loi-studen -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=loi_uniforme  -p APPLICATION_NAME=loi-uniform -p BUILD_MEMORY_REQUEST=1Gi
oc new-app shiny-centos7 -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git -p SOURCE_REPOSITORY_TAG=vec_gaussiens -p APPLICATION_NAME=vec-gaussien -p BUILD_MEMORY_REQUEST=1Gi
for app in `cat apps`
do
echo "${app}"
done

