\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sharifthesis}[2017/08/03 Sharif Thesis v1.5.1]

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
	\lehead{\leftmark}\rohead{\rightmark}
	\cefoot*{\pagemark}\cofoot*{\pagemark}
}\else%
\newpairofpagestyles{ThesisPagestyle}{
	\lohead{\leftmark}\rohead{\rightmark}
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

\RequirePackage[xindy]{glossaries} % must be after hyperref for links.

\RequirePackage{harveyballs}

\RequirePackage{multicol,float,array}
\RequirePackage{url}
% The order of package inclusions is important
\RequirePackage[localise]{xepersian}

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
		{\begin{multicols}{2}\begingroup \flushleft \linespread{1.8}\selectfont}%
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
		{\begin{multicols}{2}\begingroup \flushright \linespread{1.8}\selectfont}%
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
	\LTRmulticolcolumns
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
