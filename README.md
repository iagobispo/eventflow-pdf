# eventflow-pdf

Gotenberg (HTML → PDF) para o EventFlow. Roda como serviço separado no mesmo projeto do Railway e só é acessado pela API, pela rede interna.

## Subir no Railway

1. Crie o repositório `iagobispo/eventflow-pdf` no GitHub e faça push desta pasta.
2. No projeto do EventFlow no Railway: **+ New → GitHub Repo → eventflow-pdf**.
3. Em **Settings** do serviço:
   - **Service name:** `eventflow-pdf` (o endereço interno fica `eventflow-pdf.railway.internal`).
   - **Networking:** não gere domínio público.
   - **Resources:** 1 vCPU / 1 GB de memória é suficiente.
4. Em **Variables** do serviço:
   ```
   PORT=3000
   GOTENBERG_API_BASIC_AUTH_USERNAME=eventflow
   GOTENBERG_API_BASIC_AUTH_PASSWORD=<gere uma senha longa>
   ```
5. Na **API (eventflow-api)**, adicione:
   ```
   PDF_SERVICE_URL=http://eventflow-pdf.railway.internal:3000
   PDF_SERVICE_USERNAME=eventflow
   PDF_SERVICE_PASSWORD=<a mesma senha>
   ```
   Dica: use referência de variável do Railway, por exemplo
   `PDF_SERVICE_PASSWORD=${{eventflow-pdf.GOTENBERG_API_BASIC_AUTH_PASSWORD}}`.

## Conferir

O deploy fica verde quando `/health` responde. Pela API: `GET /pdf/health` (admin).

## Teste local (opcional, com Docker)

```bash
docker build -t eventflow-pdf .
docker run --rm -p 3000:3000 \
  -e GOTENBERG_API_BASIC_AUTH_USERNAME=eventflow \
  -e GOTENBERG_API_BASIC_AUTH_PASSWORD=teste \
  eventflow-pdf
curl -u eventflow:teste -F files=@index.html http://localhost:3000/forms/chromium/convert/html -o teste.pdf
```
O arquivo HTML precisa se chamar `index.html`.
