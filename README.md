# A New LaTeX Template for PhD/Master Thesis of the National University of Singapore (NUS)

This is a fork of Qian Lin's NUS Thesis template: https://github.com/streamjoin/nusthesis, and inspired by the
`acmart` template: https://github.com/borisveytsman/acmart

This set of latex code (mainly the [`nusthesis-neo.cls`](nusthesis-neo.cls)) is an **experimental** template for typesetting
NUS thesis and qualifying-examination (QE) reports, which is **generally** compliant with the university's requirements.
Using this template to organize your thesis content can save a lot of effort spent in formatting. 

A user's guide can be found in [`ch-user-guide.tex`](chapters/ch-user-guide.tex) or Chapter 1 of the compiled document.

You may build `main.tex` to preview a sample thesis generated using this template. This template has not been uploaded to Overleaf, but will be once it has
reached a stable release.

## Compilation

The simplest way is with `latexmk`

```sh
$ latexmk
```

This will produce `main.pdf` as output.

In case you prefer to compile the code manually, please run *exactly* the following commands at the project root (i.e., where the `main.tex` locates at the same directory level).

```sh
$ pdflatex main.tex
$ biber main
$ pdflatex main.tex
$ pdflatex main.tex
```

Note that the parameter to `biber` is the filename *without extension*. Moreover, you must run the second `pdflatex` to generate bibliography and resolve citations, and the third `pdflatex` to generate the bibliography entry in the table of contents. 

### Dependencies 

- LaTeX ([MiKTeX](https://miktex.org/) or [TeX Live](https://www.tug.org/texlive/))
- [biber](http://biblatex-biber.sourceforge.net/ "Biber: A BibTeX replacement for users of BibLaTeX")

## Editing 

Your edit should start with [`main.tex`](main.tex), which is also the compilation entry (as configured in [`latexmkrc`](latexmkrc)). Sources of individual chapters as well as abstract, acknowledgments, appendices, etc., are placed in the [`chapters`](chapters/) folder. Figures are stored in the [`pic`](pic/) folder. 

## Contact 

If you encounter any problem with this template, feel free to [contact me](http://yongqi.foo/) or [create an issue](https://github.com/yonggqiii/nusthesis-neo/issues) in this repository. 

All the best for your submission!
