%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clase que provee el formato pedido por el Departamento de Ingeniería
% Informática de la Universidad de Santiago de Chile para las tesis.
%
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%
%       Copyright (C) 2012, 2013, 2014 Felipe Garay
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\ProvidesClass{memoria}[12/03/2015 v16-2 Formato DIINF]


\LoadClass[10pt, letterpaper]{book}


\usepackage[headheight=4cm, top=4cm, left=4cm, bottom=2.5cm, right=2.5cm]{geometry}
\usepackage{fancyhdr} %para usar fácilmente los headers
\usepackage{graphicx} %usar gráficos, usado para el logo de la USACH
\usepackage[scaled]{helvet} %arial es una versión privativa de helvética

%es-lcroman nos permite usar números romanos en minúsculas
\usepackage[spanish, es-lcroman]{babel} 
\usepackage[utf8]{inputenc}
\usepackage{times}
\usepackage{tocloft}
\usepackage{etoolbox}
\usepackage{ifthen}
\usepackage{listings}
\usepackage{csquotes}


% cargamos biblatex para la bibliografia
\usepackage[style=apa,sortcites=true,sorting=nyt,backend=biber]{biblatex}
\DeclareLanguageMapping{spanish}{spanish-apa}
%\usepackage[backend=bibtex]{biblatex}
\addbibresource{bibliografia.bib}

% Con esto sabemos si debemos mostrar el nombre del capitulo o no en el header.
% Por ejemplo en los indices no debemos mostrar el capitulo
\newtoggle{mostrarcapitulo}
\togglefalse{mostrarcapitulo}


% Si la pagina es par entonces crea una pagina en blanco, si no entonces
% simplemente salto de pagina. Esto es para que los capítulos siempre empiecen
% en la hoja de la derecha
\newcommand{\paginablanco}{
            \newpage
            %check par, si es par incluir los siguiente
            \ifthenelse{\isodd{\value{page}}}
            {}
            {
                    \mbox{}
                    \thispagestyle{empty}
                    \newpage
            }
}


% Genera la portada del informe
% Argumentos: {Titulo}{Autores}{Profesora \\ ayudantes}{fecha}
\newcommand{\portada}[4]{

        \pagestyle{fancy}
        \fancyhf{} %Sin estilo de pagina

        \renewcommand{\headrulewidth}{0pt} %sacamos la linea horizontal del header

        % header central
        \chead{
                \fontsize{14}{17}
                \fontfamily{phv} %helvética
                \selectfont
                \linespread{1.5}
                \textbf{UNIVERSIDAD DE SANTIAGO DE CHILE} \\
                \fontsize{12}{14}
                \selectfont
                \textbf{FACULTAD DE INGENIERÍA} \\
                \textbf{DEPARTAMENTO DE INGENIERÍA INFORMÁTICA}}

        % logo universidad
        \rhead{\includegraphics[height=3cm]{usach.png}}

		\vspace*{0.5cm}
        % titulo
        \begin{center}
                \fontsize{14}{17}
                \fontfamily{phv}
                \selectfont
                \textbf{\uppercase{#1}} \\	% debe estar en mayusculas
        \end{center}


        % autores
        \begin{center}
                \fontsize{10}{11}
                \fontfamily{phv}
                \selectfont
                \textbf{\uppercase{#2}}		% debe estar en mayusculas
        \end{center}

        % el profesor debe esta a la mitad, con vfill llenamos con espacios
        % hasta la mitad
        \vfill

        %profesor guia, ayudantes
        \fontsize{10}{11}
        \fontfamily{phv}
        \selectfont
        \hskip 6.795cm % debe estar desde la mitad hacia la derecha
        \begin{minipage}[b]{0.45\linewidth}
                #3
        \end{minipage}


        % con mas espacios hasta el final de la pagina
        \vfill


        % fecha y lugar
        \begin{center}
                \fontsize{10}{11}
                \fontfamily{phv}
                \selectfont
                Santiago - Chile \\
                #4
        \end{center}

        \paginablanco

        \pagestyle{fancy}
        \fancyhf{} %reset el estilo


        \renewcommand{\headrulewidth}{0.4pt} 

        \newcommand{\nombrecaptitulo}{}

        \fancyhead[LE,RO]{\thepage}
        \fancyhead[RE,LO]{\capituloheading}
        
        \fancyfoot[F]{}
}


% Crea los indices del contenido, figuras y tablas
\newcommand{\indices}{
        %\pagenumbering{roman}

        \newpage
        \fontfamily{ptm} %new times roman

        \renewcommand{\thepage}{\roman{page}} % numeración romana

        % para que los capitulos tengan puntos entre el nombre y la pagina
        \renewcommand{\cftchapdotsep}{\cftdot}

        \setcounter{tocdepth}{3}

        \renewcommand{\contentsname}{\textbf{TABLA DE CONTENIDOS}}
        \tableofcontents
        \thispagestyle{fancy}

        \newpage

        \renewcommand{\cftfigdotsep}{\cftdotsep}

        \renewcommand*\listfigurename{\textbf{ÍNDICE DE FIGURAS}}
        \addcontentsline{toc}{chapter}{ÍNDICE DE FIGURAS}
        \listoffigures
        \thispagestyle{fancy}

        \newpage


        \renewcommand{\cfttabdotsep}{\cftdotsep}

        \renewcommand*\listtablename{\textbf{ÍNDICE DE CUADROS}}
        \addcontentsline{toc}{chapter}{ÍNDICE DE CUADROS}
        \listoftables

        \thispagestyle{fancy}
        

        \newpage

        \renewcommand{\thepage}{\arabic{page}} % Numeración arábiga
        %\pagenumbering{arabic}

}



% ve si es necesario mostrar el capitulo en el heading.
\newcommand{\capituloheading}{
        \iftoggle{mostrarcapitulo}{
                CAPÍTULO \arabic{chapter}: \nombrecaptitulo
        }{}
}


% Genera un capitulo, equivalente a \chapter
% Argumentos: {Titulo del capitulo}
\newcommand{\capitulo}[1]{

        \paginablanco
        
        \fontsize{16}{19}
        \fontfamily{ptm} %new times roman
        \selectfont

        \addtocounter{chapter}{1}

        \noindent\textbf{CAPÍTULO \arabic{chapter}.  \hspace{0.2cm} \uppercase{#1}}
        

        \addcontentsline{toc}{chapter}{CAPÍTULO \arabic{chapter}. \hspace{0.2cm} \uppercase{#1}}

        \renewcommand{\nombrecaptitulo}{\uppercase{#1}}

        \thispagestyle{empty}



        % para que muestre el nombre del capitulo en el heading
        \toggletrue{mostrarcapitulo}

        %resetamos los counters
        \setcounter{figure}{0}
        \setcounter{table}{0}
        \setcounter{section}{0}
        \setcounter{equation}{0}
        \setcounter{subsection}{0}


        % fuente estándar para el texto
        \fontsize{10}{11}
        \fontfamily{ptm} %new times roman
        \selectfont
}

% crea una sección, equivalente a \seccion
% Argumentos: {Titulo de la sección}
\newcommand{\seccion}[1]{

        \fontsize{14}{17}
        \fontfamily{ptm} %new times roman
        \selectfont
        
        \addtocounter{section}{1}
        \setcounter{subsection}{0}

        \noindent\textbf{\arabic{chapter}.\arabic{section} \hspace{0.2cm}  \uppercase{#1}}

        \addcontentsline{toc}{section}{\arabic{chapter}.\arabic{section} \hspace{0.5cm}\uppercase{#1}}

        \fontsize{10}{11}
        \fontfamily{ptm} %new times roman
        \selectfont

}



% crea una subseccion, equivalente a \subseccion
% Argumentos: {Titulo de la subseccion}
\newcommand{\subseccion}[1]{

        \fontsize{12}{14}
        \fontfamily{ptm} %new times roman
        \selectfont
        
        \addtocounter{subsection}{1}

        \textbf{\arabic{chapter}.\arabic{section}.\arabic{subsection} \hspace{0.2cm} #1}

        \addcontentsline{toc}{subsection}{\arabic{chapter}.\arabic{section}.\arabic{subsection} \hspace{0.2cm} #1}


        \fontsize{10}{11}
        \fontfamily{ptm} %new times roman
        \selectfont

}


% crea una subsubseccion, equivalente a \subsubseccion
% Argumentos: {Titulo de la subsubseccion}
\newcommand{\subsubseccion}[1]{

        \fontsize{12}{14}
        \fontfamily{ptm} %new times roman
        \selectfont
        
        \addtocounter{subsubsection}{1}

        \emph{\arabic{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}  #1}

        \addcontentsline{toc}{subsubsection}{\arabic{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection} #1}

        \fontsize{10}{11}
        \fontfamily{ptm} %new times roman
        \selectfont

}



% Define una tabla
% Argumentos {caption}{tabla}
\newcommand{\tabla}[2]{
        \fontsize{12}{14}
        \fontfamily{ptm} %new times roman
        \selectfont

        \addtocounter{table}{1}


        \begin{center}
                \emph{Tabla \arabic{chapter}.\arabic{table}: #1} \\
                        #2
        \end{center}

        \addcontentsline{lot}{table}{Tabla \arabic{chapter}.\arabic{table}: #1} 

        \fontsize{10}{11}
        \fontfamily{ptm} %new times roman
        \selectfont
}


% Define una figura
% Argumentos {CAPTION}{FIGURA}
\newcommand{\figura}[2]{

        \addtocounter{figure}{1}

        \begin{center}
                {#2 \\}
                \emph{Figura \arabic{chapter}-\arabic{figure}: #1} \\
        \end{center}

        \addcontentsline{lof}{figure}{Figura \arabic{chapter}-\arabic{figure}: #1}


}


% crea una bibliografia con el estilo apa y la base de datos bibliografia.bib
\newcommand{\bibliografia}{
        \capitulo{Bibliografía}
        \printbibliography[heading=none]
}


\newcommand{\bibliografiasincita}{
        \capitulo{Bibliografía}
        \printbibliography[heading=none]
}

\renewcommand{\baselinestretch}{1.5} %interlineado 1.5
