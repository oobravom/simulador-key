FROM quay.io/keycloak/keycloak:19.0

ARG VERSION=1.0
ARG REVISION=Final
ARG APLICATIVO=simulador-key
ARG VENDEDOR=TlacoTec
ARG AUTOR=oobravom

ENV KEYCLOAK_ADMIN=simulador-key
ENV KEYCLOAK_ADMIN_PASSWORD=TlacoTec

LABEL \
	org.opencontainers.image.authors="$AUTOR" \
	org.opencontainers.image.vendor="$VENDEDOR" \
	org.opencontainers.image.url="local" \
	org.opencontainers.image.source="https://github.com/$AUTOR/$APLICATIVO" \
	org.opencontainers.image.version="$VERSION" \
	org.opencontainers.image.revision="$REVISION" \
	vendor="$VENDEDOR" \
	name="$APLICATIVO" \
	version="$VERSION-$REVISION" \
	summary="Gestor principal de acceso e identidad para el aplicativo simulador." \
	description="Esta imagen contiene la información inicial para la gestión de acceso e identidad."

WORKDIR /opt/keycloak

COPY import data/import/
COPY conf/simulador-key.conf conf/simulador-key.conf

# Install custom providers
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
RUN bin/kc.sh --config-file=conf/simulador-key.conf build

# Please make sure to use proper certificates in production
COPY conf/simulador-key-server.jks conf/simulador-key-server.jks
COPY conf/simulador-key-client.jks conf/simulador-key-client.jks

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "--config-file=conf/simulador-key.conf", "start", "--import-realm", "--optimized"]
