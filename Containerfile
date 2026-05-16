ARG KEYCLOAK_VERSION=26.6.1

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} AS builder

ADD --chown=keycloak:keycloak --chmod=644 https://github.com/janus-iam/keycloak-totp-admin-api/releases/download/v1.1.0/keycloak-totp-admin-api-1.1.0.jar /opt/keycloak/providers/keycloak-totp-admin-api-1.1.0.jar

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]