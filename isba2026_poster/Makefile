POSTER = isba2026_poster/poster
HIGH_POSTER = isba2026_poster/poster_high_aesthetic

.PHONY: all figures poster high-poster clean

all: figures poster

figures:
	Rscript isba2026_poster/scripts/build_poster_figures.R

poster:
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster $(POSTER).tex
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster $(POSTER).tex

high-poster:
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster $(HIGH_POSTER).tex
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster $(HIGH_POSTER).tex

clean:
	rm -f $(POSTER).pdf $(HIGH_POSTER).pdf
	rm -f $(POSTER).aux $(POSTER).log $(POSTER).nav $(POSTER).out \
	      $(POSTER).snm $(POSTER).toc $(POSTER).vrb \
	      $(HIGH_POSTER).aux $(HIGH_POSTER).log $(HIGH_POSTER).nav \
	      $(HIGH_POSTER).out $(HIGH_POSTER).snm $(HIGH_POSTER).toc \
	      $(HIGH_POSTER).vrb
