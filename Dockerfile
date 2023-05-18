# Étape 1 : Cloner le dépôt Git
FROM debian:bullseye-slim AS clone_stage
RUN apt-get update -y && apt-get install -y git
RUN git clone https://github.com/diranetafen/static-website-example.git /projet

# Étape 2 : Copier le code source dans une nouvelle image légère
FROM ubuntu:18.04 AS final_stage
LABEL org.opencontainers.image.authors="Abdel-had HANAMI hanami.abdel.had@gmail.com"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx git
WORKDIR /var/www/html/
RUN rm -rf ./*
COPY --from=clone_stage /projet/ .
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
