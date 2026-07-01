%% nusthesis-neo.cls 2026-07-01
%% Copyright (C) 2026 Foo Yong Qi
% This file is modified based on nusthesis.cls
%
%% nusthesis.cls 2017-11-17
%% Copyright (C) 2017 Qian Lin.
%
% This file is modified based ucbthesis.cls.
%
%% ucbthesis.cls 2014-04-11
%% Copyright (C) 1988-2014 Daniel Gildea, BBF, Ethan Munson, Paul Vojta.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nusthesis-neo}[2017/11/17 v0.1 National University of Singapore Thesis (Neo) Class]

%    ****************************************
%    *               OPTIONS                *
%    ****************************************
%
%  Default options
\newcommand\thes@sidedness{-1}
\newcommand\thes@ptsize{0}
\PassOptionsToClass{a4paper}{memoir}
\DeclareOption{qe}{\newcommand{\QE}{}}
\DeclareOption{review}{\newcommand{\SHOWLINENUMBERS}{}}
\DeclareOption{numcite}{\newcommand{\CITENUMERIC}{}}
\DeclareOption{print}{\newcommand{\GRAYSCALE}{}}
%  The Graduate Division requirements essentially require that theses be
%  formatted as if the oneside option had been used.  In the memoir class,
%  however, twoside is the default.  The following code relies on the memoir
%  class for oneside/twoside formatting, but changes the default to oneside.
%  Ideas for this code were adapted from an answer on stackexchange,
%    http://tex.stackexchange.com/questions/12933/new-options-and-loaded-class-options-bug
%  (accessed on 12 September 2011).
\DeclareOption{twoside}
  {\renewcommand\thes@sidedness{2}\PassOptionsToClass{\CurrentOption}{memoir}\PassOptionsToClass{openright}{memoir}
   \newcommand*{\pagedoublesided}{}}

%  Changing the default point size from 10pt to 12pt uses a similar procedure,
%  but it's messier.
\DeclareOption{9pt}
  {\renewcommand\thes@ptsize{9}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{10pt}
  {\renewcommand\thes@ptsize{10}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{11pt}
  {\renewcommand\thes@ptsize{11}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{12pt}
  {\renewcommand\thes@ptsize{12}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{14pt}
  {\renewcommand\thes@ptsize{14}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{17pt}
  {\renewcommand\thes@ptsize{17}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{20pt}
  {\renewcommand\thes@ptsize{20}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{25pt}
  {\renewcommand\thes@ptsize{25}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{30pt}
  {\renewcommand\thes@ptsize{30}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{36pt}
  {\renewcommand\thes@ptsize{36}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{48pt}
  {\renewcommand\thes@ptsize{48}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{60pt}
  {\renewcommand\thes@ptsize{60}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{*pt}
  {\renewcommand\thes@ptsize{99}\PassOptionsToClass{\CurrentOption}{memoir}}

% Other options are passed on to the memoir class.

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% The \ProcessOptions command causes the execution of every option command
% FOO which is declared and for which the user typed the FOO option in his
% \documentclass.  For every undeclared option BAR there will be a warning
% message. (BBF 10/31/94)

\ProcessOptions\relax

\ifnum\thes@sidedness<0
  \PassOptionsToClass{oneside}{memoir}
  \renewcommand\thes@sidedness{1}
\fi

\ifnum\thes@ptsize=0
  \PassOptionsToClass{12pt}{memoir}
  \renewcommand\thes@ptsize{12}
\fi

% Now load the memoir class, and configure it appropriately.

\LoadClass{memoir}

\setlrmarginsandblock{1.2in}{*}{*}
  \@tempdima=1in  \advance\@tempdima 25pt \advance\@tempdima\normalbaselineskip
  \@tempdimb=.75in  \advance\@tempdimb 30pt
\setulmarginsandblock{\@tempdima}{\@tempdimb}{*}
\AtBeginDocument{\checkandfixthelayout}

\RequirePackage{xparse}

% print vs screen
\NewDocumentEnvironment{printonly}{ +b }{\ifdefined\GRAYSCALE#1\fi}{}
\NewDocumentEnvironment{screenonly}{ +b }{\ifdefined\GRAYSCALE\relax\else#1\fi}{}


% line numbers
\ifdefined\GRAYSCALE
    \def\printlinenumber{\scriptsize\the\mylinecount}
\else
    \def\printlinenumber{\color{ACMRed}\scriptsize\the\mylinecount}
\fi
\newsavebox{\mylinecountbx}%
\newlength\mylinecountbxht%
\newcount\mylinecount%
\mylinecount\@ne\relax%
\def\mymklinecount{%
\savebox{\mylinecountbx}[4em][t]{\parbox[t]{4em}{\normalfont
    \normalsize
    \setlength{\mylinecountbxht}{0pt}%
    \loop{\printlinenumber}\\
    \global\advance\mylinecount by \@ne
    \addtolength{\mylinecountbxht}{\baselineskip}%
    \ifdim\mylinecountbxht<\textheight\repeat
    {\printlinenumber}\hfill
    \global\advance\mylinecount by \@ne}}}%

\def\mylinecountL{%
  \ifdefined\SHOWLINENUMBERS{%
  \mymklinecount
  \begin{picture}(0,0)%
    \put(-40,-22){\usebox{\mylinecountbx}}%
  \end{picture}}%
  \fi}

\def\mylinecountLMaybe{%
  \ifnum\thes@sidedness=1\relax{%
    \ifdefined\SHOWLINENUMBERS{%
      \mymklinecount
      \begin{picture}(0,0)%
        \put(-40,-22){\usebox{\mylinecountbx}}%
      \end{picture}%
    }\fi%
  }\fi%
}

\def\mylinecountR{%
  \ifnum\thes@sidedness=2\relax{%
    \ifdefined\SHOWLINENUMBERS{%
      \mymklinecount
      \begin{picture}(0,0)%
        \put(30,-22){\usebox{\mylinecountbx}}%
      \end{picture}%
    }\fi%
  }\fi%
}


% The Grad. Division requires that "Placement of page numbers must be
% at the center of bottom."

\pagestyle{simple}
\makeevenhead{simple}{\mylinecountL {\footnotesize\sffamily\textcolor{black!70}{\leftmark}}}{}{}
\makeoddhead{simple}{\mylinecountLMaybe}{}{{\footnotesize\sffamily\textcolor{black!70}{\rightmark}}\mylinecountR}
\makeevenfoot{simple}{}{\thepage}{}
\makeoddfoot{simple}{}{\thepage}{}
\aliaspagestyle{book}{simple}
\aliaspagestyle{part}{simple}
\aliaspagestyle{chapter}{simple}
\aliaspagestyle{title}{simple}

% Issue warnings if the settings are not appropriate for a final copy
\ifdefined\SHOWLINENUMBERS\relax
  \ifdraftdoc\else
  \ClassWarningNoLine{nusthesis}{^^J\@spaces
 ****** Use the review option only for drafts. \@spaces\@spaces ******}
\fi\fi


\ifnum\thes@sidedness=2\relax
  \ifdraftdoc\else
  \ClassWarningNoLine{nusthesis}{^^J\@spaces
 ****** Use the twoside option only for drafts or printing. \@spaces\@spaces ******}
\fi\fi

\ifnum\thes@ptsize<12\relax
  \ifdraftdoc\else
  \ClassWarningNoLine{nusthesis}{^^J\@spaces
 ****** Use the \thes@ptsize pt option only for drafts. \@spaces\@spaces
 ******^^J\@spaces
 ****** The Graduate Division requires 12-point type ******^^J\@spaces
 ****** or larger for the final version.\space\@spaces\@spaces\@spaces
 ******}
\fi\fi

% For some environments we switch back to single-spacing, also
% provides \dsp in case you need double-spacing where single-spacing
% is otherwise used.

\newcommand\ssp{\SingleSpacing}
\newcommand\dsp{\setSpacing{2}}
\setlength{\parskip}{0.5\baselineskip}%

% For clear page

\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage{\pagestyle{empty}\origdoublepage}}

\newcommand{\intendclearpage}{
  \ifdefined\pagedoublesided\clearemptydoublepage\else\clearpage\fi}

% Table of contents, lists of figures, and lists of tables should always
% be single-spaced.  If one wants them to be double-spaced instead (in a
% double-spaced document), the original macros are available as
% \memoirtableofcontents, \memoirlistoffigures, and \memoirlistoftables.

\let\memoirtableofcontents=\tableofcontents
\renewcommand\tableofcontents{\begin{SingleSpace}\memoirtableofcontents
  \end{SingleSpace}}

\let\memoirlistoffigures=\listoffigures
\renewcommand\listoffigures{\begin{SingleSpace}\memoirlistoffigures
  \end{SingleSpace}}

\let\memoirlistoftables=\listoftables
\renewcommand\listoftables{\begin{SingleSpace}\memoirlistoftables
  \end{SingleSpace}}


% Customized names:
\newcommand\acknowledgename{Acknowledgments}
\newcommand\declearname{Declaration}

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

\newcommand{\changeabstractname}[1]{%
\renewcommand{\abstractname}{#1}
\addto{\captionsenglish}{\renewcommand{\abstractname}{#1}}
}

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.

% The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% Previous degrees: set in chronological order
\newcommand{\prevdegree}[1]{
\ifdefined\@prevdegreelist    
    \g@addto@macro\@prevdegreelist{,\\#1}
\else
    \def\@prevdegreelist{#1}
\fi
}
\def\@prevdegreeblock{
\ifdefined\@prevdegreelist
    \par\vspace{-10pt}
    \textit{(\@prevdegreelist)}
\else
\fi\par
}

% Advisors
\newcommand{\advisor}[1]{
\ifdefined\@advisorlist    
    \g@addto@macro\@advisorlist{\\#1}
    \ifdefined\@multipleadvisors
        \relax
    \else
        \g@addto@macro\@advisors{s}
    \fi
    \def\@multipleadvisors{}
\else
    \def\@advisors{Advisor}
    \def\@advisorlist{#1}
\fi
}
\def\@advisorblock{
\ifdefined\@advisorlist
    \@advisors:\par\vspace{-10pt}
    \@advisorlist\par
\else
\fi
}

% Examiners
\newcommand{\examiner}[1]{
\ifdefined\@examinerlist    
    \g@addto@macro\@examinerlist{\\#1}
    \ifdefined\@multipleexaminers
        \relax
    \else
        \g@addto@macro\@examiners{s}
    \fi
    \def\@multipleexaminers{}
\else
    \def\@examiners{Examiner}
    \def\@examinerlist{#1}
\fi
}
\def\@examinerblock{
\ifdefined\@examinerlist
    \vspace{5pt}
    \@examiners:\par\vspace{-10pt}
    \@examinerlist\par
\else
\fi
}


% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}

% The declaration date
\def\declaredate#1{\gdef\@declaredate{#1}}

% The declaration signature
\def\declaresign#1{\gdef\@declaresign{#1}}

% Type of document
\def\doctype{\ifdefined\QE{Qualifying-Examination Report}\else{Thesis}\fi}
\def\doctypeshort{\ifdefined\QE{report}\else{thesis}\fi}





% The alwayssingle environment ensures that front matter is always
% single column even in a double-column document.

\newenvironment{alwayssingle}
  {\if@twocolumn \@restonecoltrue\onecolumn \else \@restonecolfalse\newpage \fi}
  {\if@restonecol \twocolumn \else \newpage \fi}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros.

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}

% Set the block letter that will be used in the title page
\def\blocklt#1{\normalfont\sffamily\textbf{\MakeUppercase{#1}}\normalfont}

% Logo
\def\thesislogo{%
\ifdefined\GRAYSCALE
    \includegraphics[width=0.4\textwidth]{pic/nus-logo-black-horizontal.jpg}
\else
    \includegraphics[width=0.4\textwidth]{pic/NUS_logo_full-horizontal.jpg}
\fi}

\def\maketitle{
{\ssp
  \makeatletter
    \setlength{\@tempdima}{28pt}\advance\@tempdima-\baselineskip
    \parskip=\@tempdima minus 4pt
  \makeatother
\begin{alwayssingle}
  \hrule height 0pt
  % Fix things so that they're vertically centered
  % \@tempdima = 2 * ((\stockheight-\textheight) / 2 - \uppermargin) - \topskip
    \@tempdima=\stockheight
    \advance\@tempdima-\textheight
    \advance\@tempdima-2\uppermargin
    \advance\@tempdima-\topskip
    \vspace{\@tempdima}
  \vfill
  \let\footnotesize\small
  \let\footnoterule\relax
  \thispagestyle{empty}
  \setcounter{page}{1}

  \begin{center}
    \thesislogo\\
    \blocklt{\large\@title}\par
    \vspace{14pt minus 4pt}
    by \par
    \blocklt{\@author}
    \@prevdegreeblock
    \vspace{28pt minus 8pt}
    \blocklt{A \doctype\ submitted for the degree of} \par
    \vspace{1pt}
    \blocklt{\@degree}\par
    in \par
    \blocklt{\@field}\par
    in the \par
    \blocklt{Department of Computer Science} \par
    of the \par
    \blocklt{National University of Singapore} \par
    \vspace{28pt minus 8pt}
    \blocklt{\@degreeyear} \par
    \@advisorblock
    \@examinerblock
  \end{center}
  \vfill
  \hrule height 0pt
\end{alwayssingle}

\setcounter{footnote}{0}
}}

% DECLARATION
%
% The declaration environment puts a large, bold, centered
% "Declaration" label at the top of the page.

\def\declarationpage{%
  \intendclearpage
  \thispagestyle{empty}
  \begin{alwayssingle}
  \begin{center}
    {\Large \bfseries \sffamily \MakeUppercase{\declearname}}\par
    \vspace{1in}
    {\setlength{\parskip}{0pt}
    I hereby declare that this \doctypeshort\ is my original work and it has\par 
     been written by me in its entirety. I have duly\par 
    acknowledged all the sources of information which have\par
    been used in the \doctypeshort.\par
    \vspace{1.5em}
    This \doctypeshort\ has also not been submitted for any\par
    degree in any university previously.\par
    \ifdefined \@declaresign
      \vspace{1.2in}
      \begin{figure}[!h]
        \centering\includegraphics[height=1in]{\@declaresign}
      \end{figure}
      \vspace{-0.4in}
    \else 
      \vspace{2.1in}
    \fi
    $\rule{15em}{0.15mm}$ \par
    \vspace{.5em}
    {\normalsize\@author}\par
    \ifdefined\@declaredate
      {\normalsize\@declaredate}\par
    \fi
    }
  \end{center}
  \end{alwayssingle}
  \intendclearpage
}

% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts which,
% in accordance with UC rules, is numbered separately from the rest
% of the rest of the thesis in Arabic. 

\def\abstract{
  \intendclearpage
  \phantomsection\addcontentsline{toc}{chapter}{\abstractname}
  \begin{alwayssingle}
  \begin{center}{
    \ssp\fmfont
    {\large \bfseries \sffamily \MakeUppercase{\abstractname}}\par
    \vspace{.5cm}
    {\sffamily \@title}\par
    \vspace{.1in}
    by\par
    \vspace{.1in}
    {\@author}\par
    \vspace{.1cm}
    {\@degree} in \@field\par
    \vspace{.1cm}
    National University of Singapore\par
  }
  \vspace{.1in}
  \end{center}
}

\def\endabstract{\par\vfil\null\end{alwayssingle}}

% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}
  {\intendclearpage
   \begin{alwayssingle}
   \null\vfil
   \begin{center}\itshape\large}
  {\end{center}
   \vfil\null
   \end{alwayssingle}}

% Convenient for short dedication
\newcommand{\dedicate}[1]{\begin{dedication}#1\end{dedication}}

% ACKNOWLEDGEMENTS
%
% The acknowledgments environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgments}
  {\intendclearpage
   \phantomsection\addcontentsline{toc}{chapter}{\acknowledgename}
   \begin{alwayssingle}
   \begin{center}
   {\large \bfseries \sffamily \MakeUppercase{\acknowledgename}}
   \end{center}
  }
  {\end{alwayssingle}}

% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 3) for the front matter
% that follows the abstract.  It also resets page-numbering for
% the remainder of the thesis (arabic, starting at 1).

\renewenvironment{frontmatter}
  {\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
  {\intendclearpage
   \newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}

% Re-defining \tableofcontents, \listoffigures and \listoftables to 
% avoid self-referencing. 

\renewcommand{\tableofcontents}{
  \intendclearpage
  \phantomsection\pdfbookmark[chapter]{\contentsname}{toc}
  \chapter*{\contentsname}\vspace{2em}\makeatletter\@starttoc{toc}\makeatother}

\renewcommand{\listoffigures}{
  \intendclearpage
  \phantomsection\addcontentsline{toc}{chapter}{List of Figures}
  \chapter*{List of Figures}\vspace{2em}\makeatletter\@starttoc{lof}\makeatother}

\renewcommand{\listoftables}{
  \intendclearpage
  \phantomsection\addcontentsline{toc}{chapter}{List of Tables}
  \chapter*{List of Tables}\vspace{2em}\makeatletter\@starttoc{lot}\makeatother}

% graphics
\RequirePackage{epsfig, epstopdf, graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{xcolor}
%% hyperlinks
\definecolor{ACMBlue}{RGB}{1,130,172}
\definecolor{ACMRed}{RGB}{253,27,20}
\definecolor{ACMPurple}{RGB}{101,1,107}
\definecolor{ACMDarkBlue}{RGB}{9,53,122}
\definecolor{NUSOrange}{RGB}{239,124,0}
\definecolor{NUSBlue}{RGB}{0,61,124}
\definecolor{NUSLightBlue}{RGB}{77,181,255}
% math
\RequirePackage{amssymb, mathrsfs, amsfonts}
\RequirePackage[cmex10]{amsmath}
\RequirePackage[mathscr]{euscript}
\RequirePackage{latexsym}
\RequirePackage{ebproof}

% text formatting
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{csquotes}
\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}

%% title formatting
\newif\ifNoChapNumber

\ifdefined\GRAYSCALE
    \definecolor{OrangeBox}{RGB}{180,180,180}
    \definecolor{BlueBox}{RGB}{180,180,180}
    \definecolor{OrangeTitle}{RGB}{0,0,0}
    \definecolor{BlueTitle}{RGB}{0,0,0}
\else
    \colorlet{OrangeBox}{NUSOrange}
    \colorlet{BlueBox}{NUSBlue}
    \colorlet{OrangeTitle}{NUSOrange}
    \colorlet{BlueTitle}{NUSBlue}
\fi

\makeatletter
\setlength\midchapskip{0pt}
\makechapterstyle{myStyle}
{
    \renewcommand\chapternamenum{}      % erase default style
    \renewcommand\printchaptername{}    % erase default style
    \renewcommand\printchapternum{}     % erase default style
    \renewcommand\chapnumfont{\LARGE\sffamily}
    \renewcommand\chaptitlefont{\Huge\bfseries\sffamily}
    \renewcommand\printchaptertitle[1]{%
      \begin{tikzpicture}
        \node[inner sep=0pt,anchor=north west] (title) at (0,0)
        {\parbox{\textwidth}{{\color{OrangeTitle}{\raggedright\chaptitlefont ##1}}}};
        \coordinate (decobot) at (title.south west);
        \coordinate (decotop) at (title.north west);
        \ifNoChapNumber\else
        \node[inner sep=0pt,anchor=south west] (chapname) at
        ($(title.north west)+(0,0.2)$) {{\color{BlueTitle}{\chapnumfont\@chapapp~\thechapter}}};
        \coordinate (decotop) at (chapname.north west);
        \fi
        \def\DecoAdj{0.2}
        \coordinate (decotop) at ($(decotop)+(-\DecoAdj,\DecoAdj)$);
        \coordinate (decobot) at ($(decobot)+(-\DecoAdj,-\DecoAdj)$);
        \fill[OrangeBox,overlay] (decotop) rectangle ++(-\DecoAdj,-\DecoAdj);
        \fill[BlueBox,overlay] (decotop) rectangle ++(\DecoAdj,\DecoAdj);
        \fill[BlueBox,overlay] (decobot) rectangle ++(\DecoAdj,-\DecoAdj);
        \fill[OrangeBox,overlay] (decobot) rectangle ++(-\DecoAdj,\DecoAdj);
      \end{tikzpicture}
    }
    \renewcommand\printchapternonum{\NoChapNumbertrue}
}

\chapterstyle{myStyle}
\setsecheadstyle{\Large\sffamily\bfseries\raggedright\SingleSpacing}
\setbeforesecskip{-1.5ex plus -.5ex minus -.2ex}
\setaftersecskip{1.3ex plus .2ex}

\setsubsecheadstyle{\large\sffamily\bfseries\raggedright\SingleSpacing}
\setbeforesubsecskip{-1.25ex plus -.5ex minus -.2ex}
\setaftersubsecskip{1ex plus .2ex}

\setsubsubsecheadstyle{\normalsize\sffamily\bfseries\addperiod}
\setbeforesubsubsecskip{1.0\onelineskip
\@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
\setaftersubsubsecskip{-1.5em}%

\setparaheadstyle{\normalsize\itshape\addperiod}
\setbeforeparaskip{1.0\onelineskip
\@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
\setafterparaskip{-1.5em}%

\setsubparaheadstyle{\normalsize\itshape\addperiod}

\makeatother





% ignore trivial warnings
\RequirePackage{silence}
\WarningFilter{biblatex}{File 'english-ieee.lbx'}

% for toc
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

% citations
\def\nuscitestyle{%
\ifdefined\CITENUMERIC{numeric}\else{authoryear}\fi}
\def\nusbibstyle{\ifdefined\CITENUMERIC{numeric}\else{authoryear}\fi}
\RequirePackage[
  backend=biber,
  style=\nusbibstyle,
  citestyle=\nuscitestyle,
  sorting=nyt,
  maxbibnames=99,
  natbib=true,
  doi=true]{biblatex}

\ifdefined\CITENUMERIC{}\else{%
\ExecuteBibliographyOptions{dashed=false}
\DeclareCiteCommand{\parencite}[\mkbibparens]
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
    \printtext[bibhyperref]{\usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand{\cite}
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
    \printtext[bibhyperref]{\usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}
}\fi



\DeclareNameAlias{sortname}{given-family}

\setlength{\bibitemsep}{\baselineskip} 

% fonts
\RequirePackage[scaled=0.9]{helvet}
\RequirePackage{inconsolata}
\usepackage{newtxtext,newtxmath}

\RequirePackage{url}
\RequirePackage{hyperref}

\ifdefined\GRAYSCALE
    \hypersetup{
        colorlinks=false,
        linkbordercolor=NUSLightBlue,
        filebordercolor=violet,
        urlbordercolor=NUSLightBlue,
        citebordercolor=NUSLightBlue
    }
\else
    \hypersetup{
        colorlinks=true,
        linkcolor=NUSBlue,
        filecolor=violet,
        urlcolor=NUSBlue,
        citecolor=NUSBlue
    }
\fi

\urlstyle{sf}

\RequirePackage{bookmark}

% refs
\RequirePackage{cleveref}

\crefformat{chapter}{#2Chapter~#1#3}
\crefrangeformat{chapter}{Chapters~#3#1#4 to~#5#2#6}
\crefmultiformat{chapter}{Chapters~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{section}{#2Section~#1#3}
\crefrangeformat{section}{Sections~#3#1#4 to~#5#2#6}
\crefmultiformat{section}{Sections~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{appendix}{#2Appendix~#1#3}
\crefrangeformat{appendix}{Appendices~#3#1#4 to~#5#2#6}
\crefmultiformat{appendix}{Appendices #2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{subsection}{#2Section~#1#3}
\crefrangeformat{subsection}{Sections~#3#1#4 to~#5#2#6}
\crefmultiformat{subsection}{Sections~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{subsubsection}{#2Section~#1#3}
\crefrangeformat{subsubsection}{Sections~#3#1#4 to~#5#2#6}
\crefmultiformat{subsubsection}{Sections~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{figure}{#2Figure~#1#3}
\crefrangeformat{figure}{Figures~#3#1#4 to~#5#2#6}
\crefmultiformat{figure}{Figures~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{table}{#2Table~#1#3}
\crefrangeformat{table}{Tables~#3#1#4 to~#5#2#6}
\crefmultiformat{table}{Tables~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\crefformat{lemma}{#2Lemma~#1#3}
\crefmultiformat{lemma}{Lemmas~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{lemma}{Lemmas~#3#1#4 to~#5#2#6}

\crefformat{definition}{#2Definition~#1#3}
\crefmultiformat{definition}{Definitions~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{definition}{Definitions~#3#1#4 to~#5#2#6}

\crefformat{theorem}{#2Theorem~#1#3}
\crefmultiformat{theorem}{Theorems~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{theorem}{Theorems~#3#1#4 to~#5#2#6}

\crefformat{corollary}{#2Corollary~#1#3}
\crefmultiformat{corollary}{Corollaries~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{corollary}{Corollaries~#3#1#4 to~#5#2#6}

\crefformat{proposition}{#2Proposition~#1#3}
\crefmultiformat{proposition}{Propositions~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{proposition}{Propositions~#3#1#4 to~#5#2#6}

\crefformat{axiom}{#2Axiom~#1#3}
\crefmultiformat{axiom}{Axioms~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{axiom}{Axioms~#3#1#4 to~#5#2#6}

\crefformat{conjecture}{#2Conjecture~#1#3}
\crefmultiformat{conjecture}{Conjectures~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}
\crefrangeformat{conjecture}{Conjectures~#3#1#4 to~#5#2#6}

\crefformat{equation}{#2Equation~#1#3}
\crefrangeformat{equation}{Equations~#3#1#4 to~#5#2#6}
\crefmultiformat{equation}{Equations~#2#1#3}{ and~#2#1#3}{, #2#1#3}{ and~#2#1#3}

\makeatletter
\AddToHook{cmd/appendix/before}{\def\cref@section@alias{appendix}\def\cref@chapter@alias{appendix}\def\cref@subsection@alias{appendix}\def\cref@subsubsection@alias{appendix}}
\makeatother


%captioning
\RequirePackage{caption}
\captionsetup[table]{position=top}
\DeclareCaptionFormat{sans}{\sffamily\small#1#2#3}
\captionsetup{format=sans}

%% theorems
\let\openbox\relax
\RequirePackage[most]{tcolorbox}
\tcbuselibrary{theorems, skins, breakable}

\ifdefined\GRAYSCALE
    \definecolor{thmcolor}{RGB}{180,180,180}
    \definecolor{defcolor}{RGB}{150,150,150}
    \definecolor{conjcolor}{RGB}{200,200,200}
    \definecolor{proofcolor}{RGB}{120,120,120}
\else
    \colorlet{thmcolor}{NUSOrange}
    \colorlet{defcolor}{ACMPurple}
    \colorlet{conjcolor}{ACMRed}
    \colorlet{proofcolor}{NUSBlue}
\fi

\newtcbtheorem[number within=chapter,crefname={Theorem}{Theorems}]{theorem}{Theorem}%
{%
  fonttitle=\normalfont\scshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{thmcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={[}{]},
  description font=\normalfont,
  parbox=false,
  fontupper=\itshape,
  breakable
}%
{thm}

\newtcbtheorem[use counter from=theorem,crefname={Lemma}{Lemmas}]{lemma}{Lemma}%
{%
  fonttitle=\normalfont\scshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{thmcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={[}{]},
  description font=\normalfont,
  parbox=false,
  fontupper=\itshape,
  breakable
}%
{lem}

\newtcbtheorem[use counter from=theorem,crefname={Corollary}{Corollaries}]{corollary}{Corollary}%
{%
  fonttitle=\normalfont\scshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{thmcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={[}{]},
  description font=\normalfont,
  parbox=false,
  fontupper=\itshape,
  breakable
}%
{cor}

\newtcbtheorem[use counter from=theorem,crefname={Proposition}{Propositions}]{proposition}{Proposition}%
{%
  fonttitle=\normalfont\scshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{thmcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={[}{]},
  description font=\normalfont,
  parbox=false,
  fontupper=\itshape,
  breakable
}%
{prop}

\newtcbtheorem[use counter from=theorem,crefname={Conjecture}{Conjectures}]{conjecture}{Conjecture}%
{%
  fonttitle=\normalfont\scshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{conjcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={[}{]},
  description font=\normalfont,
  parbox=false,
  fontupper=\itshape,
  breakable
}%
{conj}

\newtcbtheorem[use counter from=theorem,crefname={Axiom}{Axioms}]{axiom}{Axiom}%
{%
  fonttitle=\itshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{defcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={(}{)},
  parbox=false,
  description font=\normalfont,
  breakable
}%
{ax}

\newtcbtheorem[use counter from=theorem,crefname={Definition}{Definitions}]{definition}{Definition}%
{%
  fonttitle=\itshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{defcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={(}{)},
  parbox=false,
  description font=\normalfont,
  breakable
}%
{def}

\newtcbtheorem[use counter from=theorem,crefname={Remark}{Remarks}]{remark}{Remark}%
{%
  fonttitle=\itshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{defcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={(}{)},
  description font=\normalfont,
  parbox=false,
  breakable
}%
{rem}

\newtcbtheorem[use counter from=theorem,crefname={Example}{Examples}]{example}{Example}%
{%
  fonttitle=\itshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{defcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  separator sign none,
  description delimiters={(}{)},
  description font=\normalfont,
  parbox=false,
  breakable
}%
{eg}

\newtcolorbox{proof}[1][Proof]{%
  fonttitle=\itshape,
  colback=white,
  coltitle=black,
  boxrule=0pt,
  frame hidden,
  sharp corners,
  enhanced,
  borderline west={1.5pt}{0pt}{proofcolor},
  attach title to upper={.\quad},
  left=1em,
  right=0pt,
  top=0pt,
  bottom=0pt,
  breakable,
  parbox=false,
  title={#1}}%

\ifdefined\GRAYSCALE
    \AtEndEnvironment{proof}{\null\hfill$\square$}
\else
    \AtEndEnvironment{proof}{\null\hfill\textcolor{proofcolor}{$\blacksquare$}}
\fi

\RequirePackage{tabulary} % Automatic table sizing
\RequirePackage{hhline}

\RequirePackage{enumitem}
\setlist{itemsep=10pt, parsep=0pt, topsep=0pt, partopsep=0pt}

%% arrays
\RequirePackage{array}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}

%%% hyphenation
\RequirePackage{soul}
\soulregister\cite7
\soulregister\ref7
\soulregister\pageref7
\soulregister\autoref7
\soulregister\eqref7
%%% Use this command when you need to add a hyphen with hyphenation 
%%% enabled for the individual compound words
\newcommand{\zz}{-\nolinebreak\hspace{0pt}}

% if any page is to be in landscape mode
\RequirePackage{pdflscape}

\newcommand*{\BeforeCaptionVSpace}{1ex}
\newcommand*{\BeforeSubCaptionVSpace}{0.75ex}

%%% Footnotes without indentation
\usepackage[hang,flushmargin]{footmisc} 

\clubpenalty10000
\widowpenalty10000
\raggedbottom

\endinput
