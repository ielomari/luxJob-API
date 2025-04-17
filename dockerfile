# Base image
FROM rocker/r-ver:4.3.1

# Installer dépendances système (pour les packages R utilisés)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libsodium-dev \
    libicu-dev \
    zlib1g-dev \
    libssl-dev \
    libcurl4-openssl-dev

# Copier tous les fichiers du projet dans le conteneur
COPY app /app

# Copy the renv.lock file to use for package restoration
COPY renv.lock /app/renv.lock

# Créer le dossier de travail
WORKDIR /app


# Install renv and restore R packages
RUN Rscript -e 'install.packages("renv")' && \
    Rscript -e 'renv::consent(provided = TRUE)' && \
    Rscript -e 'renv::restore()'
# Exposer le port utilisé par Plumber
EXPOSE 8080

# Démarrer l'API
CMD ["Rscript", "run-plumber.R"]
