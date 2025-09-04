# Solder & Signal — Org Publish scaffold

Local build, commit, and publish via GitHub Pages (docs/ on main).

## Quick start

```bash
# clone your repo first, then copy these files in (or unzip the starter)
make build
git add .
git commit -m "site: first publish via org-publish"
git push
```

Then enable GitHub Pages:
- Settings → Pages → Build and deployment → "Deploy from a branch"
- Branch: `main` and Folder: `/docs`
- (Optional) Custom domain: set your domain and add a `CNAME` in `docs/`

## Layout

```
content/   # your .org sources (exported to docs/)
static/    # assets copied as-is to docs/assets
docs/      # published site (GitHub Pages serves from here)
publish.el # org-publish config
Makefile   # build/clean/watch
```

## Local build

```bash
emacs -Q --batch -l publish.el --eval "(org-publish-all t)"
```

## Optional: Custom domain
Put your domain in `docs/CNAME` (already present as placeholder).
