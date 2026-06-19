POSTER = isba2026_poster/poster

.PHONY: all figures poster clean

all: figures poster

figures:
	Rscript isba2026_poster/scripts/build_poster_figures.R

poster:
	lualatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster $(POSTER).tex
	lualatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster $(POSTER).tex

clean:
	rm -f $(POSTER).aux $(POSTER).log $(POSTER).nav $(POSTER).out \
	      $(POSTER).snm $(POSTER).toc $(POSTER).vrb
