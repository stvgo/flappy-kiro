FROM node:20-alpine
WORKDIR /app
RUN npm install -g serve
COPY . /app/public

# Serve config for pygbag / WASM headers
RUN echo '{ \
  "headers": [ \
    { "source": "**/*.js", "headers": [{ "key": "Cross-Origin-Embedder-Policy", "value": "require-corp" }, { "key": "Cross-Origin-Opener-Policy", "value": "same-origin" }] }, \
    { "source": "**/*.wasm", "headers": [{ "key": "Content-Type", "value": "application/wasm" }] }, \
    { "source": "/", "headers": [{ "key": "Cross-Origin-Embedder-Policy", "value": "require-corp" }, { "key": "Cross-Origin-Opener-Policy", "value": "same-origin" }] } \
  ] \
}' > /app/public/serve.json

EXPOSE 3000
CMD ["serve", "-s", "public", "-l", "3000", "--no-clipboard"]