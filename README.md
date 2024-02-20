# Documentation sur DBT


### Condtions préalables

`python3` ou `python`

### Le Début
Dans votre WSL, créez le dossier `dbt`.<br> 
Dans ce dossier-là, on doit écrit
```
python3 -m venv dbt_venv
```

Ça va nous créer le dossier dbt_venv qui va être utile pour créer l'environnement<br>
Pour acitver l'environnement, on écrit 
```
cd dbt_venv
source bin/activate
```
### Installation de dbt et d'adapter de snowflake

Commençons par installer dbt et dbt-snowflake
```
pip install dbt-snowflake
```
Vous pouvez vérifier si tout est bien installé en écrivant `dbt --version`. Vous devez avoir cette image-là:
```
Core:
  - installed: 1.7.8
  - latest:    1.7.8 - Up to date!

Plugins:
  - snowflake: 1.7.2 - Up to date!
```

### Initiation de Project

Pour faire le porjet, écrivez `dbt init`. Il va vous demender de choisir l'adapteur de snowflake. Choisissez son numéro. <br>
Pour bien configurer où on peut avoir l'information de configuration, vous pouvez regarder cette vidéo: `https://www.youtube.com/watch?v=w5JUGXqSbe4`

Pour le moment, vous devriez avoir 
```
account: jazbnsx-uo63135
user: alimrtdinch312
database: SNOWFLAKE_SAMPLE_DATA
warehouse: COMPUTE_WH
role: accountadmin
schema: TPCH_SF1
```

### profiles.yml

Pour accéder au fichier `profiles.yml`, vous pouvez regarder la documentation de `dashboard_store`<br>
Le contenue de fichier `profiles.yml` doit être semblé à celui-là:

```
adapter type: snowflake
adapter version: 1.7.2
Configuration:
profiles.yml file [OK found and valid]
dbt_project.yml file [OK found and valid]
Required dependencies:
- git [OK found]

Connection:
account: jazbnsx-uo63135
user: alimrtdinch312
database: SNOWFLAKE_SAMPLE_DATA
warehouse: COMPUTE_WH
role: accountadmin
schema: TPCH_SF1
authenticator: None
private_key_path: None
oauth_client_id: None
query_tag: None
client_session_keep_alive: False
host: None
port: None
proxy_host: None
proxy_port: None
protocol: None
connect_retries: 1
connect_timeout: None
retry_on_database_errors: False
retry_all: False
insecure_mode: False
reuse_connections: None
Registered adapter: snowflake=1.7.2
Connection test: [OK connection ok]

All checks passed!
```
Le contenue de votre fichier `profiles.yml` doit ressembé à celui-là:

```
oms_dbt_proj:
  outputs:
    dev:
      account: jazbnsx-uo63135
      database: SNOWFLAKE_SAMPLE_DATA
      password: votreMotDePass
      role: accountadmin
      schema: TPCH_SF1
      threads: 3
      type: snowflake
      user: alimrtdinch312
      warehouse: COMPUTE_WH
  target: dev
```



