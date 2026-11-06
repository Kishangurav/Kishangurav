name: Generate Snake Animation

on:
  schedule:
    - cron: "0 */12 * * *"
  workflow_dispatch:
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  generate:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Generate snake SVGs
        uses: Platane/snk/svg-only@v3
        with:
          github_user_name: ${{ github.repository_owner }}
          outputs: |
            dist/github-snake.svg?color_snake=#a78bfa&color_dots=#1a1426,#3b1d6e,#5b21b6,#7c3aed,#c4b5fd&color_dot_border=#0a0510
            dist/github-snake-dark.svg?palette=github-dark&color_snake=#a78bfa&color_dots=#1a1426,#3b1d6e,#5b21b6,#7c3aed,#c4b5fd&color_dot_border=#0a0510

      - name: Push to output branch
        uses: crazy-max/ghaction-github-pages@v3.1.0
        with:
          target_branch: output
          build_dir: dist
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
