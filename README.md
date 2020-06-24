# Jeux de données pour le serveur WMS/WMTS/TMS ROK4

Jeux disponibles sous forme d'images Docker sur [Docker Hub](https://hub.docker.com/r/rok4/dataset)

## rok4/dataset:bdalti-martinique

1 pyramide, 1 couche

* Type : pyramide raster
    * Zone : Martinique
    * Nom de couche : ALTI
    * Tile Matrix Set : UTM20W84MART_1M_MNT
    * Niveau du bas : 6 (25m)
    * Source des données : [Alti (250m)](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#bd-alti)

Volume à monter : /pyramids/ALTI

## rok4/dataset:bdortho5m-martinique

2 pyramides, 2 couches

* Type : pyramide raster
    * Zone : Martinique
    * Nom de couche : BDORTHO
    * Tile Matrix Set : PM
    * Niveau du bas : 15
    * Source des données : [BDOrtho (5m)](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#bd-ortho-5-m)

* Type : pyramide raster à la demande
    * Zone : Martinique
    * Nom de couche : BDORTHO-WOD
    * Tile Matrix Set : UTM20W84MART_2.5m
    * Niveau du bas : 15

Volume à monter : /pyramids/BDORTHO

## rok4/dataset:geofla-martinique

1 pyramide, 1 couche

* Type : pyramide vecteur
    * Zone : Martinique
    * Nom de couche : LIMADM
    * Tile Matrix Set : PM
    * Niveau du bas : 18
    * Source des données : [GEOFLA](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#geofla)

Volume à monter : /pyramids/LIMADM

## Tile Matrix Sets utilisé

* [PM](https://github.com/rok4/rok4/blob/master/config/tileMatrixSet/PM.tms)
* [UTM20W84MART_1M_MNT](https://github.com/rok4/rok4/blob/master/config/tileMatrixSet/UTM20W84MART_1M_MNT.tms)
* [UTM20W84MART_2.5m](https://github.com/rok4/rok4/blob/master/config/tileMatrixSet/UTM20W84MART_2.5m.tms)

# Construction des images de données

## Génération des pyramides

La génération se fait en utilisant l'image rok4/rok4generation disponible sur [Docker Hub](https://hub.docker.com/r/rok4/rok4generation)

Le script `generate.sh` facilite le lancement des générations :
* `generate.sh BDORTHO` génère les deux pyramides présentes dans l'image `rok4/dataset:bdortho5m-martinique`, dans le dossier `pyramids/BDORTHO`. Les données ne sont pas dans le projet mais sont disponibles à l'URL [suivante](https://wxs.ign.fr/vmqhn9nk3nolzlhytv1nfx63/telechargement/prepackage/BDORTHO-JP2-5M_PACK_D972_2017-01-01%24BDORTHO_2-0_RVB-5M00_JP2-E100_RGAF09UTM20_D972_2017-01-01/file/BDORTHO_2-0_RVB-5M00_JP2-E100_RGAF09UTM20_D972_2017-01-01.7z) (130Mo)
* `generate.sh ALTI` génère les deux pyramides présentes dans l'image `rok4/dataset:bdalti-martinique`, dans le dossier `pyramids/ALTI`
* `generate.sh LIMADM` génère les deux pyramides présentes dans l'image `rok4/dataset:geofla-martinique`, dans le dossier `pyramids/LIMADM`
* `generate.sh ALL` les génère toutes

La création d'un descripteur de couche par défaut se fait automatiquement à la fin de la génération, à côté du descripteur de pyramide. Cela permet de pouvoir directement conteneurisé le dossier et qu'il soit utilisable avec l'image de ROK4SERVER

## Compilation des images

```bash
docker build -t rok4/dataset:bdortho5m-martinique -f BDORTHO.Dockerfile .
docker build -t rok4/dataset:geofla-martinique -f LIMADM.Dockerfile .
docker build -t rok4/dataset:bdalti-martinique -f ALTI.Dockerfile .
```
