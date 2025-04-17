# Base image
FROM rocker/r-ver:4.3.1

# Installer dépendances système (pour les packages R utilisés)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libsodium-dev \
    libicu-dev \
    zlib1g-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    make \
    pandoc

# Installer renv pour gérer les dépendances
RUN Rscript -e "install.packages('renv', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "install.packages('RPostgres', repos = 'https://cloud.r-project.org')"


# Créer le dossier de travail
WORKDIR /app

# Copier tous les fichiers du projet dans le conteneur
COPY . /app

# Restaurer les packages avec renv
RUN Rscript -e "renv::consent(TRUE); renv::restore(); print(renv::status())"

# Exposer le port utilisé par Plumber
EXPOSE 8080

# Démarrer l'API
CMD ["Rscript", "app/run-plumber.R"]
