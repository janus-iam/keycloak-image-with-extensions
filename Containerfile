ARG KEYCLOAK_VERSION=26.6.1

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} AS builder

# renovate: datasource=github-releases depName=janus-iam/keycloak-totp-admin-api
ARG TOTP_ADMIN_API_VERSION=1.1.0

ADD --chown=keycloak:keycloak --chmod=644 https://github.com/janus-iam/keycloak-totp-admin-api/releases/download/v${TOTP_ADMIN_API_VERSION}/keycloak-totp-admin-api-${TOTP_ADMIN_API_VERSION}.jar /opt/keycloak/providers/keycloak-totp-admin-api-${TOTP_ADMIN_API_VERSION}.jar

RUN /opt/keycloak/bin/kc.sh build \
  --db=postgres \
  --http-relative-path=/auth \
  --health-enabled=true \
  --metrics-enabled=true \
  --telemetry-enabled=true \
  --tracing-enabled=true \
  --event-metrics-user-enabled=true

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
