\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sharifthesis}[2015/06/13 Sharif Thesis v1.2.0]

\LoadClass[12pt,a4paper,BCOR=.7cm,headsepline,bibliography=totoc,chapterprefix=true]{scrbook}

\DeclareOption{MScThesis}{\def\@fordegree{\if@Latin M. Sc. Thesis\else پایان‌نامه‌ی کارشناسی ارشد\fi}}
\DeclareOption{PhDThesis}{\def\@fordegree{\if@Latin Ph. D. Thesis\else پایان‌نامه‌ی دکتری\fi}}
\DeclareOption{PhDProposal}{\def\@fordegree{\if@Latin Ph. D. Research Proposal\else پیشنهاد پژوهشی دکتری\fi}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\ProcessOptions\relax

\RequirePackage{amsmath,amsthm,scrpage2,rotating,scrhack}

\renewcommand\headfont{\small\itshape}
\renewcommand*\sectfont{\normalcolor\bfseries}

\setcounter{secnumdepth}{3}

\setkomafont{chapter}{\normalfont\huge\bfseries\centering}
\renewcommand*{\chapterheadstartvskip}{\vskip51pt}
\renewcommand*{\chapterformat}{\Huge\chapapp\ \thechapter\\[5pt]}
\renewcommand*{\chapterheadendvskip}{\vskip40pt}

\RequirePackage[left=2.5cm,bottom=2.5cm,right=3cm,top=3cm,footskip=1cm]{geometry}
\sloppy\parindent1.5em


\newcommand{\PrepareForMainContent}{\cleardoubleemptypage\pagestyle{ThesisPagestyle}\mainmatter%
\renewcommand{\chaptermark}[1]{\markboth{\chaptername~\thechapter:~##1}{}}
\renewcommand{\sectionmark}[1]{\markright{بخش~\thesection:~##1}}}

\newcommand{\PrepareForBibliography}{\cleardoubleemptypage\pagestyle{plain}\backmatter}

\newcommand{\PrepareForLatinPages}{\cleardoubleemptypage\pagestyle{empty}\latin}

\newenvironment{abstract}[1]
{\def\@pkeywords{#1}\cleardoubleemptypage\begin{center}\Large\bfseries\st@title\end{center}\subsection*{\if@Latin Abstract\else چکیده\fi}\begin{quote}\setlength{\baselineskip}{0.8cm}}
{\end{quote}\paragraph*{\if@Latin Keywords\else کلیدواژه‌ها\fi:}{\@pkeywords.}\cleardoubleemptypage}

\newenvironment{قدردانی}
{\cleardoubleemptypage\centerline{\Large\bfseries قدردانی}\begin{quote}}
{\end{quote}\cleardoubleemptypage}

\newenvironment{تصویب}
{\def\BigSkip{\par\vskip6\bigskipamount}\def\SmallSkip{\par\vskip2\bigskipamount}
\def\dashes{\tiny\normalcolor.. ... .. ... .. ... ... .. ... .. ... .. ... ...}
\def\signat{\normalfont\bfseries امضاء\dashes\\[1cm]}
\def\داور%
##1##2{{\normalfont\bfseries ##1:} & {\large##2} & \signat}
\cleardoubleemptypage\begin{center}
\normalfont\bfseries به نام خدا\SmallSkip\st@normaluniversity\BigSkip{\large\@fordegree}
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
  \def\@subject{\vskip0.1cm\@fordegree\\\st@subject}
  \ifx\st@titlelineone\undefined
    \def\@title{\vskip0.1cm{\@titlepagesize\@thetitle\\}{\st@title}}
  \else
    \def\@title{\vskip0.1cm{\@titlepagesize\@thetitle\\}{\st@titlelineone\\}{\st@titlelinetwo}}
  \fi
  \def\@author{{\@titlepagesize\@by}\\{\st@author} \\[3\bigskipamount]%
    {\@titlepagesize\@undersup}\\{\st@supervisor}%
    \ifdefined\st@consult\\[3\bigskipamount]{\@titlepagesize\@undercons}\\{\st@consult}\if@Latin\\[4\bigskipamount]\else\\[3\bigskipamount]\fi\else\if@Latin\\[7\bigskipamount]\else\\[6\bigskipamount]\fi\fi}
  \def\@date{\ifdefined\st@date\st@date\else\if@Latin\latintoday\else\today\fi\fi\vspace{-100pt}}
  \origin@lmaketitle
  \newcommand\date[1]{\def\st@date{##1}}
  \newcommand\title[1]{\def\st@title{##1}}
  \newcommand\author[1]{\def\st@author{##1}}
  \newcommand\subject[1]{\def\st@subject{##1}}}
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
\def\@thetitle{\if@Latin \hspace*{\fill}\else عنوان\fi}
\def\@undersup{\if@Latin Supervisor:\else استاد راهنما\fi}
\def\@undercons{\if@Latin Under consult of:\else استاد مشاور\fi}
\def\@by{\if@Latin By:\else نگارش\fi}
\newtheorem{theorem}{قضیه}[chapter]
\renewcommand\thetheorem{\thechapter\@SepMark\arabic{theorem}}
\newtheorem{definition}[theorem]{تعریف}
\newtheorem{contract}[theorem]{پیمان}
\newtheorem{proposition}[theorem]{گزاره}
\newtheorem{lemma}[theorem]{لم}
\newtheorem{remark}[theorem]{تذکر}
\newtheorem{example}[theorem]{نمونه}

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


\newpagestyle{pagenumberonlyPagestyle}
{% header definition
	(0pt,0pt)
	{}{}{}
	(0pt,0pt)
}{% footer definition
	(0pt,0pt)
	{\hfill\pagemark\hfill}% even pages
	{\hfill\pagemark\hfill}% odd pages
	{\hfill\pagemark\hfill}% one-sided layout pages
	(0pt,0pt)
}
\renewpagestyle{plain}
{% header definition
	(0pt,0pt)
	{}{}{}
	(0pt,0pt)
}{% footer definition
	(0pt,0pt)
	{\hfill\pagemark\hfill}% even pages
	{\hfill\pagemark\hfill}% odd pages
	{\hfill\pagemark\hfill}% one-sided layout pages
	(0pt,0pt)
}
\newpagestyle{ThesisPagestyle}
{% header definition
	(0pt,0pt)
	{\leftmark\hfill}% even pages
	{\hfill\rightmark}% odd pages
	{\leftmark\hfill\rightmark}% one-sided layout pages
	(\textwidth,0.45pt)
}{% footer definition
	{\hfill\pagemark\hfill}% even pages
	{\hfill\pagemark\hfill}% odd pages
	{\hfill\pagemark\hfill}% one-sided layout pages
	(0pt,0pt)
}

\RequirePackage[table]{xcolor}
% Colors for hyperref
    \definecolor{darkred}{rgb}{0.5,0,0}     % Web color: Maroon
    \definecolor{darkgreen}{rgb}{0,0.5,0}   % Web color: Green
    \definecolor{darkblue}{rgb}{0,0,0.5}    % Web color: Navy
% end of colors

\RequirePackage[xetex,colorlinks,bookmarksnumbered,linkcolor=darkblue,citecolor=darkred,urlcolor=darkgreen]{hyperref}
\RequirePackage{subcaption}
\RequirePackage[all]{hypcap} % fix hyperref to point to the figure/table instead of its caption. Must be loaded after hyperref and subcaption.

\RequirePackage[xindy,sanitize={name=true,description=false,symbol=true}]{glossaries} % must be after hyperref for links.

\RequirePackage{multicol,float,array}
% The order of package inclusions is important
\RequirePackage[localise]{xepersian}

\RequirePackage{url}
%% Define a new 'leo' style for the package that will use a smaller font.
\def\url@leostyle{%
  \@ifundefined{selectfont}{\def\UrlFont{\sf}}{\def\UrlFont{\small\ttfamily}}}
%% Now actually use the newly defined style.
\urlstyle{leo}

\RequirePackage{xifthen}% Provides \isempty test which is used for glossary

% equivalent commands and environments
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

\settextfont[Scale=1]{XBZar}
\setlatintextfont[Scale=1]{Linux Libertine}
\setdigitfont{Yas}

\interfootnotelinepenalty=10000 % prevent LaTeX from splitting footnotes across pages

\defpersianfont\نستعلیق[Scale=1]{IranNastaliq}
\defpersianfont\نستعلیق‌درشت[Scale=5]{IranNastaliq}

\renewcommand{\listfigurename}{فهرست شکل‌ها}
\renewcommand{\listtablename}{فهرست جدول‌ها}
\renewcommand{\contentsname}{سرخط‌ها}


% Glossary

\glsdisablehyper % disable hyperlinks

\newglossarystyle{persian-to-english}{%
%	\glossarystyle{listdotted}% the base style
	\renewenvironment{theglossary}%
		{\begin{multicols}{2}\begingroup \flushleft }%
		{\endgroup \end{multicols}}%
	\renewcommand*{\glossaryheader}{}%
	\renewcommand*{\glsgroupheading}[1]{}%
	\renewcommand*{\glsgroupskip}{}%
	% \glossaryentryfield{label}{formatted name}{description}{symbol}{number list}
	\renewcommand*{\glossaryentryfield}[5]{%
		\glstarget{##1}{##2}% persian term
		\dotfill%dots
		\space \lr{##3} \\%translation term
	}%
	\renewcommand*{\glossarysubentryfield}[6]{%
		\glossaryentryfield{##2}{##3}{##4}{##5}{##6}%
	}%
}
\newglossarystyle{english-to-persian}{%
	\renewenvironment{theglossary}%
		{\begin{multicols}{2}\begingroup \flushright }%
		{\endgroup \end{multicols}}%
	\renewcommand*{\glossaryheader}{}%
	\renewcommand*{\glsgroupheading}[1]{}%
	\renewcommand*{\glsgroupskip}{}%
	% \glossaryentryfield{label}{formatted name}{description}{symbol}{number list}
	\renewcommand*{\glossaryentryfield}[5]{%
		\glstarget{##1}{##2}%translation term
		\dotfill%dots
		\space \rl{##3} \\%persian term
	}%
	\renewcommand*{\glossarysubentryfield}[6]{%
		\glossaryentryfield{##2}{##3}{##4}{##5}{##6}%
	}%
}

\newglossary{p2e-terms}{fa.gls}{fa.glo}{واژه‌نامه‌ی فارسی به انگلیسی} % persian to english
\newglossary{e2p-terms}{en.gls}{en.glo}{English to Persian Glossary} % english to persian

\newcommand{\newterm}[3][]{% params: [key]{persian}{english}
\ifthenelse{\isempty{#1}}{\def\key{#2}}{\def\key{#1}}%
\newglossaryentry{en:\key}{type={e2p-terms}, name={#3}, description={#2}}% english glossary
%\newglossaryentry{fa:\key}{type={p2e-terms}, name={#2}, plural={#4}, description={#3}}% persian glossary
\newglossaryentry{fa:\key}{type={p2e-terms}, name={#2}, description={#3}}% persian glossary
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
	\phantomsection % hyperref: enable hyperlinking from the table of contents to this point
	\addcontentsline{toc}{chapter}{#1} % add a line in the Table of Contents (first option, toc), it will be like the ones 
	\renewcommand{\glossarymark}[1]{\markboth{##1}}% correct handling of page header
	\printglossary[type={p2e-terms},style={persian-to-english},title={#1}]%
}}
\newcommand{\printenglishglossary}[1][واژه‌نامه‌ی انگلیسی به فارسی]{{%
	\phantomsection % hyperref: enable hyperlinking from the table of contents to this point
	\addcontentsline{toc}{chapter}{#1} % add a line in the Table of Contents (first option, toc), it will be like the ones 
	\renewcommand{\glossarymark}[1]{\markboth{##1}}% correct handling of page header
	\begin{latin}%
	\printglossary[type={e2p-terms},style={english-to-persian},title={\rl{#1}}]%
	\end{latin}%
}}

% Reset the first-use flag of the transaltion glossareis
\newcommand{\resettranslations}{\glsresetall[e2p-terms,p2e-terms]}

%\ترجمه[نمونه‌های]{نمونه}{example}
\newcommand{\trans}[3][]{% params: [actual form]{persian}{english}
\newterm{#2}{#3}% add to glossary
\term[#1]{#2}% and cite it
}

%\نام[نویسنده‌ی کتاب فلان]{اِسمیت}{Smith}
\newcommand{\name}[3][]{% Just maps a name by translitaration (independent of glossary)
\ifthenelse{\isempty{#1}}%
{\emph{#2}\LTRfootnote{#3}}% if #1 is empty
{\emph{#2}\LTRfootnote{#3; #1}}% if #1 is not empty
}

%abbreviation support may be added here...

\eqcommand{رچ}{rl}
\eqcommand{چر}{lr}

\eqcommand{بارهها}{itemize}
\eqcommand{باره}{item}

\eqcommand{نوواژه}{newterm}
\eqcommand{واژه}{term}
\eqcommand{ترجمه}{trans}
%مورد زیر در xepersian تعریف شده و نیازی به تعریف دوباره‌ی آن در اینجا نیست.
%\eqcommand{نام}{name}


\endinput
