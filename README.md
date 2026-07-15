# Souzadex 

A **Souzadex** é uma galeria colaborativa, uma pokédex, de fotos do Souza
(Vitor Souza), geradas por IA.
Cada Souza da galeria foi enviado por alguém da comunidade via pull request.

🔗 **Galeria:** https://souzadex.audibert.dev

## Como contribuir

1. Coloque a imagem em [`souzas/`](souzas/) — o nome do arquivo é o nome do
   Souza (ex: `Souza Chun-Li.png`).
2. Adicione uma linha no **final** da lista em [`souzas.js`](souzas.js):
   ```js
   { file: "Souza Chun-Li.png", author: "seu-usuario-do-github" },
   ```
3. Abra o PR com o título `Souza: <Nome do Souza>`.

O número do seu Souza é a posição dele na lista — para sempre. 🏆

Regras completas em [CONTRIBUTING.md](CONTRIBUTING.md).

## Licença

O código está sob a licença [MIT](LICENSE). As imagens pertencem aos seus
autores.
