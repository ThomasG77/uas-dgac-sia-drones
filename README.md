# UAS drones

Suite à [une demande sur Georezo](https://georezo.net/forum/viewtopic.php?pid=356726#p356726), nous avons récupéré les données le 1er décembre depuis le site https://www.sia.aviation-civile.gouv.fr/produits-numeriques-en-libre-disposition/donnees-zones-geographiques-uas.html et en vigueur du 01/12/22 au 28/12/22 inclus.

Nous ne prévoyons pas de les mettre à jour en permanence. De ce fait, il faut les prendre comme des restrictions sur une date donnée à ne pas utiliser pour **un usage réel** car selon [la documentation](https://www.sia.aviation-civile.gouv.fr/pub/media/news/file//g/u/guide_utilisation_ds_uas_1.pdf), il n'y a jamais plus de 28 jours avant une nouvelle mise à jour (il y a même sur une période une coexistence de 2 jeux de données pour éviter des problèmes de recouvrement)

## Exécution

Il faut changez les chemins de fichier dans le fichier `process.sh` et il faut avoir sur sa machine les utilitaires [`jq`](https://stedolan.github.io/jq/), avoir node.js installé sur votre machine. En effet, il est nécessaire pour l'usage de `ndjson-map`, `ndjson-reduce` (tous les 2 fournis par https://github.com/mbostock/ndjson-cli) et de Turf (`npm install @turf/turf`)

Il faut ensuite lancer le script avec

```
./process.sh
```

PS: nous sommes sous un système Linux qui gère les différences entre les guillemets simples et doubles.

## Projet QGIS

Il s'agit du fichier `sia.qgz`. Il consomme les données transformées en établissant une relation 1 à n entre le CSV et le GeoJSON.

Il faut aussi noter que nous avons rajouté des couches issues du Geoportail/de l'IGN relatives aux restrictions DRONES sous forme raster (WMS) et vecteur (WFS) ainsi qu'un fond de plan OpenStreetMap, vous verrez des écarts. Par exemple, les centres de communes sont marqués avec restriction alors que ce n'est pas le cas côté fichier transformé. Nous laissons aux personnes spécialistes du domaine drônes, tirer les enseignements pour choisir les jeux de données les plus adaptés à leur besoin.
