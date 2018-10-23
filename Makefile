.PHONY: clean

clean:
	rm -f build/*

build/.dirstamp:
	mkdir -p build && touch $@

build/%-tmp.tex: %.tex template.tex build/.dirstamp
	sed -e '/@BODY/{r $*.tex' -e 'd}' template.tex > $@

%.pdf: build/%-tmp.tex
	latex -interaction=nonstopmode -halt-on-error -output-directory build $^ && \
	cd build/ && yes q | mpost decay.mp && cd - && \
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory build -jobname $* $^ && \
	pdfcrop build/$*.pdf build/$*.pdf
