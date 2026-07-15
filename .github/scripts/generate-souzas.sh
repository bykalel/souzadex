#!/usr/bin/env bash
# Regenera souzas.js a partir das imagens em assets/images.
# Para cada imagem, descobre o commit que a adicionou e o usuário
# do GitHub autor desse commit (o autor do PR, em merge/squash).
set -euo pipefail

entries=""
shopt -s nullglob nocaseglob
for f in assets/images/*.{jpg,jpeg,png,gif}; do
  commit=$(git log --diff-filter=A --format=%H -- "$f" | tail -1)
  if [ -z "$commit" ]; then
    # Imagem ainda sem commit (não deve acontecer no CI)
    continue
  fi
  ts=$(git show -s --format=%ct "$commit")
  login=$(gh api "repos/$GITHUB_REPOSITORY/commits/$commit" --jq '.author.login // empty' 2>/dev/null || true)
  if [ -z "$login" ]; then
    login=$(git show -s --format=%an "$commit")
  fi
  entries+="$ts|$(basename "$f")|$login"$'\n'
done
shopt -u nullglob nocaseglob

{
  echo "// Gerado automaticamente pelo workflow update-souzadex — não edite manualmente."
  echo "// Ordem cronológica: o primeiro item é o mais antigo (#1)."
  echo "const SOUZAS = ["
  printf '%s' "$entries" | sort -t'|' -k1,1n | while IFS='|' read -r ts file login; do
    echo "  { file: \"$file\", author: \"$login\" },"
  done
  echo "];"
} > souzas.js

echo "souzas.js gerado:"
cat souzas.js
