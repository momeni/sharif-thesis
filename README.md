#Sharif Thesis

This project provides a template for writing thesis in XeLaTeX according to the style of Sharif University of Technology ([SUT](http://sharif.edu/)). The base description of the thesis style is made available by the [Central Library of the University](http://sharif.edu/~library/Guide_Theses.pdf). All SUT's theses are supposed to be written in Persian. The [XePersian](http://www.ctan.org/tex-archive/macros/xetex/latex/xepersian) package is employed for typesetting Persian text. And scrbook is used as the base document class for the sharifthesis document class.

##Template Organization
The template is organized as follows:
 * sharifthesis.cls: The document class. Probably you don't need to read it for writing your thesis,
 * main.tex: The main file. Read it carefully. Approximately all lines must be changed to reproduce your thesis information like keywords, title, advisor professor, and so on,
 * general folder: includes all codes which are not limited to a particular chapter of the thesis,
   * abstract.tex: The abstract in Persian,
   * abstract-en.tex: The abstract in English,
   * glossaries.tex: List of glossary words. For examples read the main.pdf file,
   * preamble.tex: Includes all related files. Probably you won't need to read it,
   * translitaration.tex: Translitarate English words to Persian alphabet and define English TeX commands for writing them faster,
   * thesis\_content.tex: This file must be updated to include all chapters,
 * img folder: Includes all images (it may have subfolders too),
 * resources: Includes resources.bib for citations. You may want to save PDF of used resources in that folder too,
 * one folder for each chapter of the thesis including a .tex file with the same name. For example find the introduction and future\_work folders.

##Compilation
For compiling TeX files to PDF, issue **make** command. It compiles biber (a biblatex engine) for references, xindy for two glossaries, and XeLaTeX for the PDF file itself. It compiles as many times as required to get all cross-links correctly compiled. In sake of fast compilation, you can use **make once** which just run XeLaTeX one time. For most the time, it's not important to have an updated glossary or references list. So you can **make once** by default and **make** to obtain the really final version. BTW, you need to **make** for the first time. Because with empty glossaries, **make once** won't succeed. Also you should add name of all TeX files to the *TEX0* variable in the Makefile.

##License
    Copyright © 2013-2015 Behnam Momeni

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
    the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see {http://www.gnu.org/licenses/}.

##Acknowledgments
I want to acknowledge works of Mr. Sadegh Dorri for his code which was the corner stone helping to build this template and his ideas and TeX codes continuing to improve this template. I also want to thank Mr. Vafa Khalighi for his great work with [XePersian](http://www.ctan.org/tex-archive/macros/xetex/latex/xepersian) package. Most of TeX-based Persian documents owe to him :) At last, I should thank all the helpful people that I forgot to mention here (if you want to have your name listed here, drop an email).

