check-conf:
    bunx renovate -- renovate-config-validator

dry-run:
    bunx renovate --platform=local --dry-run
