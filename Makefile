EMACS ?= emacs

.PHONY: build clean watch

build:
	$(EMACS) -Q --batch -l publish.el --eval "(org-publish-all t)"
	@touch docs/.nojekyll

clean:
	rm -rf docs/*
	@mkdir -p docs

# naive watcher (requires entr): find content static -type f | entr -r make build
watch:
	@echo "Run: find content static -type f | entr -r make build"
