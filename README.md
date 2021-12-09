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

## rok4/dataset:pente-martinique

1 pyramide, 1 couche

* Type : pyramide raster
    * Zone : Martinique
    * Nom de couche : PENTE
    * Tile Matrix Set : PM
    * Niveau du bas : 13 (20m)
    * Source des données : [Alti (250m)](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#bd-alti)

Volume à monter : /pyramids/ALTI

## rok4/dataset:bdortho5m-martinique

1 pyramides, 1 couches

* Type : pyramide raster
    * Zone : Martinique
    * Nom de couche : BDORTHO
    * Tile Matrix Set : PM
    * Niveau du bas : 15 (7m)
    * Source des données : [BDOrtho (5m)](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#bd-ortho-5-m)

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

# Construction des images de données

## Génération des pyramides

La génération se fait en utilisant l'image rok4/rok4generation disponible sur [Docker Hub](https://hub.docker.com/r/rok4/rok4generation)

Usage : `generate.sh [<tag image rok4generation>]`

Le script déclenche le lancement des générations de toutes les pyramides :

* la pyramide présente dans l'image `rok4/dataset:bdortho5m-martinique-4`, dans le dossier `pyramids/BDORTHO`. Les données ne sont pas dans le projet mais sont disponibles à l'URL [suivante](https://wxs.ign.fr/vmqhn9nk3nolzlhytv1nfx63/telechargement/prepackage/BDORTHO-JP2-5M_PACK_D972_2017-01-01%24BDORTHO_2-0_RVB-5M00_JP2-E100_RGAF09UTM20_D972_2017-01-01/file/BDORTHO_2-0_RVB-5M00_JP2-E100_RGAF09UTM20_D972_2017-01-01.7z) (130Mo)
* la pyramide présente dans l'image `rok4/dataset:pente-martinique-4`, dans le dossier `pyramids/PENTE`
* la pyramide présente dans l'image `rok4/dataset:bdalti-martinique-4`, dans le dossier `pyramids/ALTI`
* la pyramide présente dans l'image `rok4/dataset:geofla-martinique-4`, dans le dossier `pyramids/LIMADM`

La création d'un descripteur de couche par défaut se fait automatiquement à la fin de la génération, à côté du descripteur de pyramide. Cela permet de pouvoir directement conteneurisé le dossier et qu'il soit utilisable avec l'image de ROK4SERVER

## Compilation des images

```bash
docker build -t rok4/dataset:bdortho5m-martinique-4 -f BDORTHO.Dockerfile pyramids/BDORTHO
docker build -t rok4/dataset:pente-martinique-4 -f PENTE.Dockerfile pyramids/PENTE
docker build -t rok4/dataset:geofla-martinique-4 -f LIMADM.Dockerfile pyramids/LIMADM
docker build -t rok4/dataset:bdalti-martinique-4 -f ALTI.Dockerfile pyramids/ALTI
``` 
