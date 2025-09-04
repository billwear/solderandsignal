EMACS ?= emacs

.PHONY: build clean lint

build:
	$(EMACS) -Q --batch -l publish.el --eval "(org-publish-all t)"
	@touch docs/.nojekyll

clean:
	rm -rf docs/*
	@mkdir -p docs

lint:
	@rg -nI '^\s*#\+html_head\b' -i content && \
	  { echo "✗ Found #+HTML_HEAD. Use HTML_HEAD_EXTRA or publish.el."; exit 1; } || \
	  { echo "✓ No file-level HTML_HEAD overrides."; }
