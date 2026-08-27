# latexmk configuration for the Sharif thesis template.
#
# latexmk works the same on Linux, macOS, Windows and Overleaf, and decides for
# itself how many times each tool has to run. The Makefile calls it, so both ways
# of building stay available.

$pdf_mode = 5;    # xelatex

# Keep the flags the Makefile has always used, including the PDF minor version.
$xelatex = 'xelatex -halt-on-error -shell-escape -interaction=nonstopmode '
         . '-synctex=-1 -output-driver="xdvipdfmx -E -V 5" %O %S';

$bibtex_use = 2;  # biber, via biblatex

# The glossaries are sorted by xindy, which latexmk knows nothing about. The two
# glossary files are main.fa.glo and main.en.glo, so latexmk sees the base names
# "main.fa" and "main.en" and the language is taken from that suffix.
# variant1-utf8 sorts آ and ا together.
add_cus_dep('glo', 'gls', 0, 'run_xindy');

sub run_xindy {
    my ($base) = @_;
    my ($doc, $lang) = ($base, 'english');
    my $codepage = 'utf8';
    if ($base =~ /^(.*)\.fa$/) { $doc = $1; $lang = 'persian'; $codepage = 'variant1-utf8'; }
    elsif ($base =~ /^(.*)\.en$/) { $doc = $1; }
    return system('xindy', '--language', $lang, '--codepage', $codepage,
                  '--input-markup', 'xindy', '--module', $doc,
                  '--log-file', "$base.glg", '--out-file', "$base.gls",
                  "$base.glo");
}

# Files the tools above leave behind.
$clean_ext = 'fa.glo fa.gls fa.glg en.glo en.gls en.glg glsdefs '
           . 'run.xml bbl synctex.gz xdy';
