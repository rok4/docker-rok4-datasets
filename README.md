# Jeux de données pour le serveur WMS/WMTS/TMS ROK4

## Pyramides

Toutes les données sont sur la Martinique.

| Type de pyramide    | Type de données                                 | TMS utilisé       | Niveau du bas |
| ------------------- | ----------------------------------------------- | ----------------- | ------------- |
| Raster              | [BDOrtho (5m)](http://pro.ign.fr/bdortho-5m)    | PM                | 15            |
| Raster à la demande | BDOrtho (5m), à partir de la pyramide du dessus | UTM20W84MART_2.5m | 15            |
| Raster              | [Alti (250m)](http://pro.ign.fr/bdalti)         | PM                | 10            |
| Vecteur             | [GEOFLA](http://pro.ign.fr/adminexpress)        | PM                | 18            |

## Tile Matrix Sets utilisé

* [PM](./PM.tms)
* [UTM20W84MART_2.5m](./UTM20W84MART_2.5m.tms)
