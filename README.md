# Applications pédagogiques ShinyR 

- [Coefficient de corrélation](https://coef-correlation-irmar.apps.math.cnrs.fr)
- [Loi binomiale](https://loi-binomiale-irmar.apps.math.cnrs.fr)
- [Loi exponentielle](https://loi-exponentielle-irmar.apps.math.cnrs.fr)
- [Loi de Fisher](https://loi-fisher.apps.math.cnrs.fr)
- [Loi du Khi2](https://loi-khi2.apps.math.cnrs.fr)
- [Loi normale](https://loi-normale.apps.math.cnrs.fr)
- [Loi de Poisson](https://loi-poisson.apps.math.cnrs.fr)
- [Loi student](https://loi-student.apps.math.cnrs.fr)
- [Loi uniforme](https://loi-uniforme.apps.math.cnrs.fr)
- [Vec gaussiens](https://vec-gaussiens.apps.math.cnrs.fr)

- Executez les commandes suivantes (où mon projet sera à remplacer par le nom de votre projet au sein duquel se trouve votre appli shiny):
```
oc project irmar
```

```
oc new-project shiny-irmar
oc process --parameters shiny-centos7 -n openshift

for app in coef-correlation loi-binomiale loi-exponentielle loi-fisher loi-khi2 loi-normale loi-poisson loi-student loi-uniforme vec-gaussiens
do
oc new-app shiny-centos7 \
    -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git \
    -p APPLICATION_NAME=${app} \
    -p BUILD_MEMORY_REQUEST=1Gi
done
