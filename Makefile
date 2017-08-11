BLDDIR = _build
export max_print_line = 1000000

all: dissertation

dissertation: $(BLDDIR)/dissertation.pdf

$(BLDDIR)/%.pdf: %.tex refs-zotero.bib | $(BLDDIR)/chapters
	latexmk -pdf -outdir=$(BLDDIR) -interaction=nonstopmode $<

bib: refs-zotero.bib

refs-zotero.bib: FORCE
	-curl -sfo $@ "http://localhost:23119/better-bibtex/collection?/0/References/dissertation.bibtex&exportNotes=false&useJournalAbbreviation=true" && gsed -f ../utils/clean-zotero-bib.sed -i $@

check_unused:
	@for key in `grep -h @ refs*.bib | sed 's/@[a-z]\{1,\}{\([^,]\{1,\}\),/\1/'`; \
		do \
		[[ -z `grep $$key chapters/*.tex` ]] && echo $$key; \
		done; :

clean:
	rm -rf $(BLDDIR)

$(BLDDIR)/chapters:
	mkdir -p $@

FORCE:
