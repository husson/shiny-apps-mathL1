# Serveur ShinyR avec applications personnalisées

- Copiez ce dépôt :
  - git clone plmlab.math.cnrs.fr:/plmshift/shiny-custom.git
  - ou bien en cliquant "Fork" sur la page d'accueil de ce dépôt
- Dans le dossier ShinyApps, éditez vos applications Shiny
- Connectez-vous sur https://plmshift.math.cnrs.fr, créez une applications Shiny R depuis le catalogue
- Renseignez l'URL de votre dépôt shiny-custom
- Patientez et ensuite connectez-vous sur l'URL de votre déploiement

# Récupération depuis PLMShift, via cle SSH, si votre dépôt est privé

Si votre dépôt Shiny Custom est privé, PLMShift devra posséder un secret (ici une clé SSH) afin d'accéder à votre dépôt

cf: https://docs.openshift.com/container-platform/3.11/dev_guide/builds/build_inputs.html#source-clone-secrets

- Générer la clé :
```
ssh-keygen -C "openshift-source-builder/shiny@plmlab" -f shiny-at-plmlab -N ''
```
- Ajout de la clé publique dans les préférences du dépôt mon_depot/shiny-custom (Settings->Repository->Deploy Keys)
- Ajout de la clé privé dans PLMShift
```
oc project mon_projet
oc create secret generic shiny-at-plmlab --from-file=ssh-privatekey=shiny-at-plmlab --type=kubernetes.io/ssh-auth
oc annotate secret/shiny-at-plmlab 'build.openshift.io/source-secret-match-uri-1=git@plmlab.math.cnrs.fr:/mon_depot/shiny-custom.git'
```

