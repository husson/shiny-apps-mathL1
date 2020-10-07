# Applications pédagogiques ShinyR 

- [Coefficient de corrélation](https://coef-correlation-irmar.apps.math.cnrs.fr)
- [Loi binomiale](https://loi-binomiale-irmar.apps.math.cnrs.fr)
- [Loi exponentielle](https://loi-exponentielle-irmar.apps.math.cnrs.fr)
- [Loi de Fisher](https://loi-fisher-irmar.apps.math.cnrs.fr)
- [Loi du Khi2](https://loi-khi2-irmar.apps.math.cnrs.fr)
- [Loi normale](https://loi-normale-irmar.apps.math.cnrs.fr)
- [Loi de Poisson](https://loi-poisson-irmar.apps.math.cnrs.fr)
- [Loi student](https://loi-student-irmar.apps.math.cnrs.fr)
- [Loi uniforme](https://loi-uniforme-irmar.apps.math.cnrs.fr)
- [Vecteurs gaussiens](https://vec-gaussiens-irmar.apps.math.cnrs.fr)

## Commandes openshift pour mémoire

### Création du projet 

```bash
oc new-project irmar
oc project irmar
```

### Options du template shiny-centos7

```bash
oc process --parameters shiny-centos7 -n openshift
```

### Création des applications

```bash
for app in coef-correlation loi-binomiale loi-exponentielle loi-fisher loi-khi2 loi-normale loi-poisson loi-student loi-uniforme vec-gaussiens
do
oc new-app shiny-centos7 \
    -p SOURCE_REPOSITORY_URL=https://plmlab.math.cnrs.fr/navaro/shiny-custom.git \
    -p APPLICATION_NAME=${app} \
    -p BUILD_MEMORY_REQUEST=1Gi \ 
done
```
