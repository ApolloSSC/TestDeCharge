# Test de charge pour application NetCore/Net6 (mais pas que !)

Le but de ce repo est de proposer un ensemble d'outils sous Docker pour mesurer les performances de votre application sous différents scénario de charge.

## Les outils
### Monitor
Permet de mesurer les différentes métriques de votre application et les mettre à disposition en tant qu'API.
Pour plus d'informations: https://devblogs.microsoft.com/dotnet/announcing-dotnet-monitor-in-net-6/

### Prometheus
Permet d'agréger des données de différentes sources.
https://prometheus.io/

### Grafana
Permet de visualiser des métriques grâce à des dashboards facilement personnalisables.
https://grafana.com/

### JMeter
Permet de simuler une charge utilisateur selon des plans de test.
https://jmeter.apache.org/

### Docker
Permet de conteneuriser des applications afin de s'abstraire de l'infrastructure sur lesquelles elles fonctionnent.

## Configurer l'environnement

### docker-compose.yml
Vous devez décommenter la partie **app** et renseigner l'image de votre application

Elle doit exposer le port 80.

Changer le **ASPNETCORE_ENVIRONMENT** au besoin.

## Lancer l'environnement
`docker-compose up -d`

## Vérifier que tout fonctionne
Les identifiants de connexion se trouvent dans le **docker-compose.yml**
### Votre application
http://localhost:15000/
### Monitor
http://localhost:52325/metrics
### Prometheus
http://localhost:9090/targets

La target **monitor** doit être UP.
### Grafana
http://localhost:30000/d/9GEjrXHnk/tdc-app?orgId=1&from=now-15m&to=now

## Configurer un test de charge

Télécharger la dernière version de **JMeter** depuis https://jmeter.apache.org/download_jmeter.cgi

Lancer **JMeter** via **jmeter.bat** dans le dossier bin (pour Windows)

Ouvrir le plan de test dans le dossier **docker/jmeter/plans/Test plan.jmx**

Dans un premier temps, nous allons faire un test depuis l'application **JMeter** pour vérifier que le test est correct, mais pour de vrais tests de charge, il faut passer par le container ou la version en ligne de commande.

Un test se compose de:
- **Thread group**: Nombre de processus/utilisateur à simuler
- **HTTP Header Manager**: Permet de paramétrer des headers pour la requête qui va être exécuter
- **HTTP Request Local**: Permet de configurer la requête qui sera appelée si on veut tester sur une application qui tourne en local.
- **HTTP Request Docker**: Permet de configurer la requête qui sera appelée si on veut tester sur une application qui tourne sous Docker.
- **View Result Tree**: Permet de visualiser le résultat des requêtes appelées.

Changer l'url du endpoint dans les **HTTP Request**

Attention a bien activer le **HTTP Request** que vous souhaité utiliser et désactiver l'autre.

Vous pouvez lancer le test en cliquant sur la flêche verte.

Vous devriez voir l'impact du test dans Grafana.

## Lancer un test de charge depuis le container jmeter
Exécuter la ligne `docker exec -it tdc-jmeter jmeter -n -t "/var/lib/jmeter/plans/Test Plan.jmx"` pour lancer le test.