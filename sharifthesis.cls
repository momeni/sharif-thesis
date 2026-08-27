\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sharifthesis}[2028/06/04 Sharif Thesis v1.8.0]

\DeclareOption{MScThesis}{\def\@partialfulfillment{\if@nonlatin این پایان‌نامه به عنوان تحقق بخشی از شرایط دریافت درجه‌ی کارشناسی ارشد است.\else A thesis submitted in partial fulfillment of the requirements for the M.Sc. degree\fi}%
\def\@fordegree{\if@nonlatin پایان‌نامه‌ی کارشناسی ارشد\else M. Sc. Thesis\fi}}

\DeclareOption{PhDThesis}{\def\@partialfulfillment{\if@nonlatin این رساله به عنوان تحقق بخشی از شرایط دریافت درجه‌ی دکتری است.\else A dissertation submitted in partial fulfillment of the requirements for the Ph.D degree\fi}%
\def\@fordegree{\if@nonlatin رساله‌ی دکتری\else Ph.D Dissertation\fi}}

\DeclareOption{PhDProposal}{\def\@fordegree{\if@nonlatin پیشنهاد پژوهشی دکتری\else Ph.D Research Proposal\fi}}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}


\ProcessOptions\relax

\LoadClass[fontsize=12pt,
	paper=A4,pagesize,
	bibliography=totoc,
	chapterprefix=true,
	toc=indented]
	{scrbook}

\RequirePackage{amsmath,amsthm,rotating,scrhack}
\RequirePackage[headsepline=0.45pt]{scrlayer-scrpage}

\renewcommand\headfont{\small\itshape}
\renewcommand*\sectfont{\normalcolor\bfseries}

\setcounter{secnumdepth}{3}

\renewcommand*{\raggedchapter}{\centering}
\renewcommand*{\chapterheadstartvskip}{\vskip51pt}
\renewcommand*{\chapterformat}{\Huge\chapapp\ \thechapter\\[5pt]}
\renewcommand*{\chapterheadendvskip}{\vskip40pt}

\RequirePackage[left=2.5cm,bottom=2.5cm,right=3cm,top=3cm,footskip=1cm]{geometry}
\sloppy\parindent1.5em

\counterwithin*{equation}{chapter}
\newcommand{\PrepareForMainContent}{\cleardoubleemptypage\pagestyle{ThesisPagestyle}\mainmatter%
\renewcommand{\chaptermark}[1]{\markboth{\chaptername~\thechapter:~##1}{}}
\renewcommand{\sectionmark}[1]{\markright{بخش~\thesection:~##1}}}

\newcommand{\PrepareForBibliography}{\cleardoubleemptypage\pagestyle{plain.ThesisPagestyle}\backmatter}

\newcommand{\PrepareForLatinPages}{\cleardoubleemptypage\pagestyle{empty}\latin}

\newenvironment{abstract}[1]
{\def\@pkeywords{#1}\cleardoubleemptypage\begin{center}\Large\bfseries\st@title\end{center}\subsection*{\if@nonlatin چکیده\else Abstract\fi}\begin{quote}\setlength{\baselineskip}{0.8cm}}
{\end{quote}\paragraph*{\if@nonlatin کلیدواژه‌ها\else Keywords\fi:}{\@pkeywords.}\cleardoubleemptypage}

\newenvironment{قدردانی}
{\cleardoubleemptypage\centerline{\Large\bfseries قدردانی}\begin{quote}}
{\end{quote}\cleardoubleemptypage}

\newenvironment{تصویب}
{\def\BigSkip{\par\vskip6\bigskipamount}\def\SmallSkip{\par\vskip2\bigskipamount}
\def\dashes{\tiny\normalcolor.. ... .. ... .. ... ... .. ... .. ... .. ... ...}
\def\signat{\normalfont\bfseries امضاء\dashes\vspace{.7cm}\\}
\def\داور%
##1##2{{\normalfont\bfseries ##1:} & {\large##2} & \signat}
\cleardoubleemptypage\begin{center}
\normalfont\bfseries تصویب‌نامه\SmallSkip به نام خدا\\\st@normaluniversity\BigSkip{\large\@fordegree}\\\SmallSkip{\large\if@nonlatin\mbox{\@partialfulfillment}\else\@partialfulfillment\fi}
\end{center}\SmallSkip\begin{tabular}{rr}
{\normalfont\bfseries عنوان:} & {\large\st@title} \\[\medskipamount]
{\normalfont\bfseries \@by:} & {\large\st@author}
\end{tabular}\BigSkip
{\normalfont\bfseries\large کمیته‌ی ممتحنین:}\SmallSkip\begin{center}
\begin{tabular*}{.9\textwidth}{r r @{\extracolsep{\fill}} l}
{\normalfont\bfseries\@undersup:} & {\large\st@supervisor} & \signat
\ifdefined\st@consult {\normalfont\bfseries\@undercons:} & {\large\st@consult} & \signat\fi
}%above declares the beginning of تصویب environment.
{&& {\normalfont\bfseries تاریخ:} {\normalsize\normalfont\bfseries \dashes}
\end{tabular*}\end{center}}

\let\origin@lmaketitle\maketitle
\def\makethesistitle{
  \def\@titlepagesize{\Large\normalfont}
  \def\@titlehead{\centering\st@logo\\\smallskip\large\st@university}
  \def\@subject{\vskip0.1cm\@fordegree\\\if@nonlatin گرایش \fi\st@subject}
  \ifx\st@titlelineone\undefined
    \def\@title{\vskip0.1cm{\@titlepagesize\@thetitle\\}{\st@title}}
  \else
    \def\@title{\vskip0.1cm{\@titlepagesize\@thetitle\\}{\st@titlelineone\\}{\st@titlelinetwo}}
  \fi
  \def\@author{{\@titlepagesize\@by}\\{\st@author} \\[2\bigskipamount]%
    {\@titlepagesize\@undersup}\\{\st@supervisor}%
    \ifdefined\st@consult\\[3\bigskipamount]{\@titlepagesize\@undercons}\\{\st@consult}\if@nonlatin\\[3\bigskipamount]\else\\[4\bigskipamount]\fi\else\if@nonlatin\\[6\bigskipamount]\else\\[7\bigskipamount]\fi\fi}
  \def\@date{\vspace{100pt}\ifdefined\st@date\st@date\else\if@nonlatin\today\else\latintoday\fi\fi\vspace{-100pt}}
  \origin@lmaketitle
}
\renewcommand\date[1]{\def\st@date{#1}}
\renewcommand\title[1]{\def\st@title{#1}}
\newcommand\titlelineone[1]{\def\st@titlelineone{#1}}
\newcommand\titlelinetwo[1]{\def\st@titlelinetwo{#1}}
\renewcommand\author[1]{\def\st@author{#1}}
\renewcommand\subject[1]{\def\st@subject{#1}}
\newcommand\logo[1]{\def\st@logo{#1}}
\newcommand\university[1]{\def\st@university{#1}}
\newcommand\normaluniversity[1]{\def\st@normaluniversity{#1}}
\newcommand\supervisor[1]{\def\st@supervisor{#1}}
\newcommand\consult[1]{\def\st@consult{#1}}
\def\@thetitle{\hspace*{\fill}}
\def\@undersup{\if@nonlatin استاد راهنما\else Supervisor:\fi}
\def\@undercons{\if@nonlatin استاد مشاور\else Advisor:\fi}
\def\@by{\if@nonlatin نگارش\else By:\fi}
\newtheorem{theorem}{قضیه}[chapter]
\renewcommand\thetheorem{\thechapter\@SepMark\arabic{theorem}}
\newtheorem{definition}[theorem]{تعریف}
\newtheorem{contract}[theorem]{پیمان}
\newtheorem{proposition}[theorem]{گزاره}
\newtheorem{lemma}[theorem]{لم}
\newtheorem{remark}[theorem]{تذکر}
\newtheorem{example}[theorem]{نمونه}

\newcommand{\raisedrule}[2][0em]{\leaders\hbox{\rule[#1]{1pt}{#2}}\hfill}
\newcommand{\copyrightform}[2]{%
\begin{minipage}{\linewidth}\setlength{\baselineskip}{0.85cm}\normalfont
\st@logo\hspace{2cm}
\begin{minipage}{7cm}\centering\vspace*{-1.5cm}
\textbf{\large اظهارنامه}\\
(اصالت متن و محتوای #1‌ی #2)
\end{minipage}

عنوان #1:
\raisedrule{0.4pt}

~
\raisedrule{0.4pt}

نام استاد راهنما:
\raisedrule{0.4pt}
نام استاد راهنمای هم‌کار:
\raisedrule{0.4pt}
نام استاد مشاور:
\raisedrule{0.4pt}

این‌جانب
\raisedrule{0.4pt}
اظهار می‌دارم:
\hfill~

\شروع{شمارش}
	\باره متن و نتایج علمی ارایه‌شده در این #1 اصیل بوده و منحصراً توسط این‌جانب و زیر نظر استادان (راهنما، هم‌کار و مشاور) نام‌برده‌شده در بالا تهیه شده است.
	\باره متن #1 به این صورت در هیچ جای دیگری منتشر نشده است.
	\باره متن و نتایج مندرج در این #1، حاصل تحقیقات این‌جانب به عنوان دانشجوی #2 دانشگاه صنعتی شریف است.
	\باره کلیه‌ی مطالبی که از منابع دیگر در این #1 مورد استفاده قرار گرفته، با ذکر مرجع مشخص شده است.
\پایان{شمارش}

{\par\vskip1\bigskipamount}
\hspace*{9cm}
\begin{minipage}{6cm}
نام دانشجو:
\raisedrule{0.4pt}

\vspace*{0.3cm}
تاریخ:

\vspace*{0.3cm}
امضاء:
\end{minipage}{\par\vskip2\bigskipamount}

نتایج تحقیقات مندرج در این #1 و دستاوردهای مادی و معنوی ناشی از آن (شامل فرمول‌ها، نرم‌افزارها، سخت‌افزارها و مواردی که قابلیت ثبت اختراع دارد) متعلق به دانشگاه صنعتی شریف است. هیچ شخصیت حقیقی یا حقوقی بدون کسب اجازه از دانشگاه صنعتی شریف حق فروش و ادعای مالکیت مادی یا معنوی بر آن یا ثبت اختراع از آن را ندارد. همچنین کلیه‌ی حقوق مربوط به چاپ، تکثیر، نسخه‌برداری، ترجمه، اقتباس و نظایر آن در محیط‌های مختلف اعم از الکترونیکی، مجازی یا فیزیکی برای دانشگاه صنعتی شریف محفوظ است. نقل مطالب با ذکر ماخذ بلامانع است.

{\par\vskip2\bigskipamount}
\begin{minipage}{6cm}
نام استادان راهنما:
\raisedrule{0.4pt}

\vspace*{0.3cm}
تاریخ:

\vspace*{0.3cm}
امضاء:
\end{minipage}\hfill
\begin{minipage}{6cm}
نام دانشجو:
\raisedrule{0.4pt}

\vspace*{0.3cm}
تاریخ:

\vspace*{0.3cm}
امضاء:
\end{minipage}
\end{minipage}}


\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace*{\fill}
\begin{center}
\textit{\rl{[این صفحه آگاهانه خالی گذاشته شده است.]}}
\end{center}
\vspace{\fill}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\def\cleardoubleemptypage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace*{\fill}
\begin{center}
\textit{\rl{[این صفحه آگاهانه خالی گذاشته شده است.]}}
\end{center}
\vspace{\fill}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}


\if@twoside%
\newpairofpagestyles{ThesisPagestyle}{
	\lehead{\leftmark\hfill}\rohead{\hfill\rightmark}
	\cefoot*{\pagemark}\cofoot*{\pagemark}
}\else%
\newpairofpagestyles{ThesisPagestyle}{
	\lohead{\leftmark\hfill}\rohead{\hfill\rightmark}
	\cofoot*{\pagemark}
}\fi

\RequirePackage[table]{xcolor}
% Colors for hyperref
    \definecolor{darkred}{rgb}{0.5,0,0}     % Web color: Maroon
    \definecolor{darkgreen}{rgb}{0,0.5,0}   % Web color: Green
    \definecolor{darkblue}{rgb}{0,0,0.5}    % Web color: Navy
% end of colors

\RequirePackage[xetex,colorlinks,bookmarksnumbered,linkcolor=darkblue,citecolor=darkred,urlcolor=darkgreen]{hyperref}
\RequirePackage{subcaption}
\RequirePackage[all]{hypcap} % fix hyperref to point to the figure/table instead of its caption. Must be loaded after hyperref and subcaption.

\RequirePackage[record,abbreviations]{glossaries-extra} % must be after hyperref for links.
% Entries are kept in a .bib file and sorted by bib2gls, which ships with TeX Live
% and behaves identically on every platform. xindy is no longer needed.

\RequirePackage{harveyballs}

\RequirePackage{multicol,float,array}
\RequirePackage{url}
% The order of package inclusions is important
\RequirePackage[localize]{xepersian}

%% Define a new 'leo' style for the package that will use a smaller font.
\def\url@leostyle{%
  \@ifundefined{selectfont}{\def\UrlFont{\sf}}{\def\UrlFont{\small\ttfamily}}}
%% Now actually use the newly defined style.
\urlstyle{leo}

\RequirePackage{xifthen}% Provides \isempty test which is used for glossary

% equivalent commands and environments
\eqcommand{اظهارنامه}{copyrightform}
\eqcommand{دانشگاه}{university}
\eqcommand{دانشگاه‌عادی}{normaluniversity}
\eqcommand{موضوع}{subject}
\eqcommand{عنوانخطیک}{titlelineone}
\eqcommand{عنوانخطدو}{titlelinetwo}
\eqcommand{استادراهنما}{supervisor}
\eqcommand{استادمشاور}{consult}
\eqcommand{آرم}{logo}
\eqcommand{تقدیم}{dedication}
\eqenvironment{اثبات}{proof}
\eqenvironment{لم}{lemma}
\eqenvironment{قضیه}{theorem}
\eqenvironment{تذکر}{remark}
\eqenvironment{گزاره}{proposition}
\eqenvironment{پیمان}{contract}
\eqenvironment{تعریف}{definition}
\eqenvironment{نمونه}{example}
% Auto-ref names
\def\sectionautorefname{بخش}
\def\subsectionautorefname{بخش}
\def\subsubsectionautorefname{بخش}
\def\chapterautorefname{فصل}
\def\itemautorefname{بند}
\def\figureautorefname{شکل}
\def\equationautorefname{رابطه}
\def\tableautorefname{جدول}
\def\pageautorefname{صفحهٔ}
\def\footnoteautorefname{پاورقی}

% If you cannot install fonts by your system packages,
% an alternative is to copy them in a local folder like "fonts/"
% and then specify it by "Path" option as follows:
%
%\settextfont[
%  Path=fonts/,
%  Scale=1.09,
%  UprightFont = *.ttf,                % regular
%  BoldFont = * Bold.ttf,              % bold
%  ItalicFont = * Italic.ttf,          % italic
%  BoldItalicFont = * Bold Italic.ttf  % bold italic
%]{XBZar}

\settextfont[Scale=1]{XBZar}
%\setlatintextfont[Scale=1]{Linux Libertine}
\setlatintextfont[Scale=1]{Libertinus Serif}
% The Yas font is chosen for its "hollow zero" Persian number.
% Other fonts, e.g., XB Niloofar, do not render Persian zero correctly.
\setdigitfont{Yas}

\interfootnotelinepenalty=10000 % prevent LaTeX from splitting footnotes across pages

\defpersianfont\نستعلیق[Scale=1]{IranNastaliq}
\defpersianfont\نستعلیق‌درشت[Scale=5]{IranNastaliq}

\newcaptionname{english}{\listfigurename}{فهرست شکل‌ها}
\newcaptionname{english}{\listtablename}{فهرست جدول‌ها}
\newcaptionname{english}{\contentsname}{سرخط‌ها}

% Glossary

\glsdisablehyper % disable hyperlinks

\newglossarystyle{persian-to-english}{%
%	\glossarystyle{listdotted}% the base style
	\renewenvironment{theglossary}%
		{\begin{multicols}{2}\begingroup \flushleft \linespread{1.8}\selectfont}%
		{\endgroup \end{multicols}}%
	\renewcommand*{\glossaryheader}{}%
	\renewcommand*{\glsgroupheading}[1]{}%
	\renewcommand*{\glsgroupskip}{}%
	% \glossentry{label}{numberlist}
	\renewcommand*{\glossentry}[2]{%
		\glstarget{##1}{\glossentryname{##1}}% persian term
		\dotfill%dots
		\space \lr{\glossentrydesc{##1}} \\%translation term
	}%
	\renewcommand*{\subglossentry}[3]{%
		\glossentry{##2}{##3}%
	}%
}
\newglossarystyle{english-to-persian}{%
	\renewenvironment{theglossary}%
		{\begin{multicols}{2}\begingroup \flushright \linespread{1.8}\selectfont}%
		{\endgroup \end{multicols}}%
	\renewcommand*{\glossaryheader}{}%
	\renewcommand*{\glsgroupheading}[1]{}%
	\renewcommand*{\glsgroupskip}{}%
	% \glossentry{label}{numberlist}
	\renewcommand*{\glossentry}[2]{%
		\glstarget{##1}{\glossentryname{##1}}% translation term
		\dotfill%dots
		\space \rl{\glossentrydesc{##1}} \\% persian term
	}%
	\renewcommand*{\subglossentry}[3]{%
		\glossentry{##2}{##3}%
	}%
}

\newglossary*{p2e-terms}{واژه‌نامه‌ی فارسی به انگلیسی} % persian to english
\newglossary*{e2p-terms}{English to Persian Glossary} % english to persian

% Persian collation. The JVM has no fa collator, so an explicit rule is required:
% the default would sort پ, چ, ژ, ک and گ after ی. The commas give آ and ا a shared
% primary weight, which is the grouping xindy produced with variant1-utf8, and they
% also fold the Arabic look-alikes ك, ي, ؤ and ة onto their Persian counterparts.
\newcommand{\st@persiansortrule}{%
< ا,آ,أ,إ,ٱ < ب < پ < ت < ث < ج < چ < ح < خ < د < ذ < ر < ز < ژ < س < ش < ص < ض < ط < ظ < ع < غ < ف < ق < ک,ك < گ < ل < م < ن < و,ؤ < ه,ة < ی,ي,ئ}

% \loadglossaryterms{resources/terms}
% Reads the .bib file of terms. Each @dualentry yields both a Persian to English
% and an English to Persian entry, labelled fa:<key> and en:<key> so that the
% \واژه and \ترجمه commands keep working exactly as before. Abbreviations are
% read from the same file and labelled ac:<key>.
\newcommand{\loadglossaryterms}[1]{%
\GlsXtrLoadResources[%
	src={#1},%
	type={p2e-terms},dual-type={e2p-terms},%
	label-prefix={fa:},dual-prefix={en:},%
	match={entrytype=dualentry},%
	sort={custom},sort-rule={\st@persiansortrule},%
	dual-sort={en}%
]%
\GlsXtrLoadResources[%
	src={#1},%
	type={abbreviations},label-prefix={ac:},%
	match={entrytype=abbreviation},%
	sort={en}%
]}

% Terms now live in the .bib file read by \loadglossaryterms, so this only warns.
% The convertgls2bib tool, shipped with bib2gls, converts an existing glossary file.
\newcommand{\newterm}[3][]{% params: [key]{persian}{english}
\PackageWarning{sharifthesis}{\string\newterm\space is obsolete; move the entry to
the .bib file read by \string\loadglossaryterms\space (convertgls2bib does this for you)}%
}

\defglsentryfmt[p2e-terms]{%
  \ifdefempty\glsinsert{% use word itself
    \ifglsused\glslabel{% subsequent usages
        \glsifplural{%
          \glscapscase{\glsentryplural{\glslabel}}%
            {\Glsentryplural{\glslabel}}%
            {\mfirstucMakeUppercase{\glsentryplural{\glslabel}}}%
        }%
        {%
          \glscapscase{\glsentrytext{\glslabel}}%
            {\Glsentrytext{\glslabel}}%
            {\mfirstucMakeUppercase{\glsentrytext{\glslabel}}}%
        }%
    }%
    {% first usage
      \emph{%
        \glsifplural{%
          \glscapscase{\glsentryfirstplural{\glslabel}}%
            {\Glsentryfirstplural{\glslabel}}%
            {\mfirstucMakeUppercase{\glsentryfirstplural{\glslabel}}}%
        }%
        {%
          \glscapscase{\glsentryfirst{\glslabel}}%
            {\Glsentryfirst{\glslabel}}%
            {\mfirstucMakeUppercase{\glsentryfirst{\glslabel}}}%
        }%
      }\LTRfootnote{\glsentrydesc{\glslabel}}%
    }%
  }%
  {% override word with glsinsert
    \ifglsused\glslabel{% subsequent usages
      \glsinsert%
    }%
    {% first usage
      \emph{\glsinsert}\LTRfootnote{\glsentrydesc{\glslabel}}%
    }%
  }%
}

%\term[نمونه‌های]{key}
\newcommand{\term}[2][]{%
\glsadd{en:#2}%
\ifthenelse{\isempty{#1}}{\gls{fa:#2}}{\gls{fa:#2}[#1]}%
}

\newcommand{\printpersianglossary}[1][واژه‌نامه‌ی فارسی به انگلیسی]{{%
	% glossaries-extra adds the table of contents entry itself
	\renewcommand{\glossarymark}[1]{\markboth{##1}}% correct handling of page header
	\printunsrtglossary[type={p2e-terms},style={persian-to-english},title={#1}]%
}}
\newcommand{\printenglishglossary}[1][واژه‌نامه‌ی انگلیسی به فارسی]{{%
	% glossaries-extra adds the table of contents entry itself
	\renewcommand{\glossarymark}[1]{\markboth{##1}}% correct handling of page header
	\begin{latin}%
	\LTRmulticolcolumns
	\printunsrtglossary[type={e2p-terms},style={english-to-persian},title={\rl{#1}}]%
	\end{latin}%
}}

% Reset the first-use flag of the transaltion glossareis
\newcommand{\resettranslations}{\glsresetall[e2p-terms,p2e-terms,abbreviations]}

%\ترجمه[نمونه‌های]{نمونه}{example}
\newcommand{\trans}[3][]{% params: [actual form]{persian}{english}
\term[#1]{#2}% the entry itself now comes from the .bib file
}

%\نام[نویسنده‌ی کتاب فلان]{اِسمیت}{Smith}
\newcommand{\name}[3][]{% Just maps a name by translitaration (independent of glossary)
\ifthenelse{\isempty{#1}}%
{\emph{#2}\LTRfootnote{#3}}% if #1 is empty
{\emph{#2}\LTRfootnote{#3; #1}}% if #1 is not empty
}

% Fix for https://github.com/persiantex/bidi/issues/7
\RequirePackage{xpatch}
\xpatchcmd\scr@dte@tocline
  {\@nameuse{scr@tso@#1@pagenumberbox}}
  {\expandafter\let\expandafter\scr@dte@pagenumberwidth
   \csname scr@tso@#1@pagenumberwidth\endcsname
   \@nameuse{scr@tso@#1@pagenumberbox}}
  {}{\fail}

% abbreviation support
% glossaries-extra typesets abbreviations natively. With the long-short style the
% long form, which is the Persian wording, is printed followed by the abbreviation
% on first use, and the abbreviation alone afterwards, so that the body of the
% thesis stays Persian. The description field carries the English wording, which
% is what the list in the front matter shows.
\setabbreviationstyle[abbreviation]{long-short}

%\abbrv{DOI}
\newcommand{\abbrv}[1]{\gls{ac:#1}}

% Kept so that documents written against the previous release still compile.
\newcommand{\newabbrv}[4][]{% params: [key]{abbreviation}{persian}{english}
\PackageWarning{sharifthesis}{\string\newabbrv\space is obsolete; move the entry to
the .bib file read by \string\loadglossaryterms\space as an @abbreviation}%
}

% The list itself is Latin on both sides, so it is set left to right.
\newglossarystyle{abbreviations}{%
	\renewenvironment{theglossary}%
		{\begin{latin}\begingroup\raggedright}%
		{\endgroup\end{latin}}%
	\renewcommand*{\glossaryheader}{}%
	\renewcommand*{\glsgroupheading}[1]{}%
	\renewcommand*{\glsgroupskip}{}%
	% \glossentry{label}{numberlist}
	\renewcommand*{\glossentry}[2]{%
		\glstarget{##1}{\glossentryname{##1}}% the abbreviation
		\dotfill%dots
		\space \glossentrydesc{##1} \\% its English wording
	}%
	\renewcommand*{\subglossentry}[3]{%
		\glossentry{##2}{##3}%
	}%
}

% A thesis which uses no abbreviation gets neither a heading nor a table of
% contents entry.
\newcommand{\st@printabbrevations}[1]{{%
	% glossaries-extra adds the table of contents entry itself
	\renewcommand{\glossarymark}[1]{\markboth{##1}}% correct handling of page header
	\printunsrtglossary[type=abbreviations,style={abbreviations},title={#1}]%
}}
\newcommand{\printabbrevations}[1][کوته‌نوشت‌ها]{%
	\glsxtrifemptyglossary{abbreviations}{}{\st@printabbrevations{#1}}%
}

\eqcommand{رچ}{rl}
\eqcommand{چر}{lr}

% The فقرات and فقره environment and command are defined by xepersian
% however, بارهها and باره are preferred due to their Persian roots.
\eqcommand{بارهها}{itemize}
\eqcommand{باره}{item}

\eqcommand{نوواژه}{newterm}
\eqcommand{واژه}{term}
\eqcommand{ترجمه}{trans}
\eqcommand{نوکوته‌نوشت}{newabbrv}
\eqcommand{کوته‌نوشت}{abbrv}
\eqcommand{فهرست‌کوته‌نوشت‌ها}{printabbrevations}
%مورد زیر در xepersian تعریف شده و نیازی به تعریف دوباره‌ی آن در اینجا نیست.
%\eqcommand{نام}{name}


\endinput
