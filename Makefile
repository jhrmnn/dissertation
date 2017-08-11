BLDDIR = _build
export max_print_line = 1000000

all: dissertation

dissertation: $(BLDDIR)/dissertation.pdf

$(BLDDIR)/%.pdf: %.tex refs-zotero.bib
	latexmk -pdf -outdir=$(BLDDIR) -interaction=nonstopmode $<

bib: refs-zotero.bib

refs-zotero.bib: FORCE
	-curl -sfo $@ "http://localhost:23119/better-bibtex/collection?/0/References/dissertation.bibtex&exportNotes=false&useJournalAbbreviation=true" && \
		gsed -i '/./,$$!d' $@ && \
		gsed -i 's/an Der {{Waals/an der {{Waals/g' $@ && \
		gsed -i 's/Otero-de-la-Roza, A./Otero{-}de{-}la{-}Roza, A./g' $@

clean:
	rm -rf $(BLDDIR)

FORCE:
