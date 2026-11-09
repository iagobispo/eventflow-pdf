# Gotenberg: converte HTML em PDF com Chromium. Serviço interno do EventFlow no Railway.
FROM gotenberg/gotenberg:8

# Porta fixa 3000 (defina PORT=3000 no Railway).
# Basic auth ligado: usuário e senha vêm de GOTENBERG_API_BASIC_AUTH_USERNAME / _PASSWORD.
# LibreOffice e webhooks desligados: só precisamos de HTML → PDF.
CMD ["gotenberg", \
     "--api-port=3000", \
     "--api-timeout=60s", \
     "--api-enable-basic-auth", \
     "--chromium-auto-start", \
     "--libreoffice-disable-routes", \
     "--webhook-disable", \
     "--log-format=json"]
