# Main tex file (without tex extension)
SRC=main

# Commands and options
TEX=xelatex
BIB=biber
GLS=bib2gls

# Output PDF minor version
PDFMINORVER=5

# Specified xdvipdfmx to set PDF minor version from default (4) to another version. -E option: allways embed fonts regardless of lice. -halt-on-error
# Shell-escape is needed for gnuplot environment.
TEXOPTIONS=-halt-on-error -shell-escape -interaction=nonstopmode -synctex=-1 -output-driver='xdvipdfmx -E -V $(PDFMINORVER) ' 

# Included tex files (not the main file)
TEX0=sharifthesis.cls \
	./general/thesis_content.tex ./general/translitaration.tex \
	./general/abstract.tex ./general/abstract-en.tex \
	./general/preamble.tex ./general/glossaries.tex \
	./introduction/introduction.tex \
	./introduction/writing.tex ./introduction/structure.tex \
	./future_works/future_works.tex



# Biblography items
BIB0=./resources/resources.bib

# SVG graphics
SVG0=
SVGOUT=$(addsuffix .pdf,$(basename $(SVG0))) \
	$(addsuffix .pdf_tex,$(basename $(SVG0)))

IMAGES=img



all: $(SRC).pdf

# Convert SVG files to PDF+LaTeX
img/%.pdf img/%.pdf_tex: img/%.svg
	inkscape --export-area-drawing --without-gui --file=$< --export-pdf=$@ --export-latex

# Build the main file
$(SRC).pdf: $(SRC).tex $(TEX0) $(BIB0) $(SVG0) $(SVGOUT) Makefile
	rm -fv $(SRC).pdf $(SRC).bbl $(SRC).glstex
	$(TEX) $(TEXOPTIONS) $<
	$(BIB) $(SRC)
	$(GLS) $(SRC)
	$(TEX) $(TEXOPTIONS) $<
	while grep --fixed-strings "Rerun to" $(SRC).log || grep --fixed-strings "Please rerun LaTeX" $(SRC).log ; do $(TEX) $(TEXOPTIONS) $< ; done
	$(TEX) $(TEXOPTIONS) $<
	@echo -e "===========================\nWarnings:\n"
	@grep 'Warning\|Error\|Underful\|Overful' $(SRC).log | sort

once: $(SRC).tex $(TEX0) $(BIB0) $(SVG0) $(SVGOUT) Makefile
		$(TEX) $(TEXOPTIONS) $<

view: $(SRC).pdf
	evince $< &

markdown: TODO.markdown
	markdown $< > TODO.html

cleanall: clean cleansvg cleanfig

clean:
	rm -fv $(SRC).pdf *.log *.aux *.auxlock *.bbl *.bcf *.glsdefs *.run.xml *.blg *.out *.dvi *.synctex *.toc *.lof *.lot *.maf *.mtc* *.glg *.glo *.gls *.glstex $(SRC).xdy *~ images/*~ $(SRC)-gnuplottex-fig* *.dep *.dpth $(SRC)-figure*.xdy */*.aux

cleansvg:
	rm -fv $(SVGOUT)

cleanfig:
	rm -fv $(SRC)-figure*.pdf

# PHONY targets - make no output file
.PHONY : all once view cleanall clean cleansvg cleanfig

