# UAS drones

Suite à [une demande sur Georezo](https://georezo.net/forum/viewtopic.php?pid=356726#p356726), nous avons récupéré les données le 1er décembre depuis le site <https://www.sia.aviation-civile.gouv.fr/produits-numeriques-en-libre-disposition/donnees-zones-geographiques-uas.html> et en vigueur du 01/12/22 au 28/12/22 inclus.

Nous ne prévoyons pas de les mettre à jour en permanence. De ce fait, il faut les prendre comme des restrictions sur une date donnée à ne pas utiliser pour **un usage réel passé la date du 28/12/22** car selon [la documentation](https://www.sia.aviation-civile.gouv.fr/pub/media/news/file//g/u/guide_utilisation_ds_uas_1.pdf), il n'y a jamais plus de 28 jours avant une nouvelle mise à jour (il y a même sur une période une coexistence de 2 jeux de données pour éviter des problèmes de recouvrement)

## Exécution pour générer les données

Il faut changez les chemins de fichier dans le fichier `process.sh` et il faut avoir sur sa machine les utilitaires [`jq`](https://stedolan.github.io/jq/), avoir node.js installé sur votre machine. En effet, il est nécessaire pour l'usage de `ndjson-map`, `ndjson-reduce` (tous les 2 fournis par <https://github.com/mbostock/ndjson-cli>) et de Turf (`npm install @turf/turf`)

Il faut ensuite lancer le script avec

```
./process.sh
```

PS: nous sommes sous un système Linux qui gère les différences entre les guillemets simples et doubles.

## Projet QGIS

Il s'agit du fichier `sia.qgz`. Il consomme les données transformées en établissant une relation 1 à n entre le CSV et le GeoJSON.

<img src="apercu_sia_drones.png"/>

Il faut aussi noter que nous avons rajouté des couches issues du Geoportail/de l'IGN relatives aux restrictions DRONES sous forme raster (WMS) et vecteur (WFS) ainsi qu'un fond de plan OpenStreetMap, vous verrez des écarts. Par exemple, les centres de communes sont marqués avec restriction alors que ce n'est pas le cas côté fichier transformé. Nous laissons aux personnes spécialistes du domaine drônes, tirer les enseignements pour choisir les jeux de données les plus adaptés à leur besoin. Nous avons volontairement zoomé car la couche WFS de l'IGN bien que non visible est appelée dès l'ouverture et est gourmande en ressource réseau.

Les URL des services WMS, WFS de l'IGN ajoutés sont disponibles sur <https://geoservices.ign.fr/services-web-experts-transports>


Vous pouvez potentiellement utiliser les données d'altitude minimum et maximum ainsi que [la documentation officiel du jeu de données UAS du SIA](https://www.sia.aviation-civile.gouv.fr/pub/media/news/file//g/u/guide_utilisation_ds_uas_1.pdf) si vous souhaitez construire les volumes 3D depuis le jeu de données créé.
