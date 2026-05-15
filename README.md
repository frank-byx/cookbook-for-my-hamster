This is a cookbook written in LaTeX. Install pdfTeX to build the project into a pdf file.

Run `./build.sh` from the project directory to generate a pdf for the entire project, which will be copied to the project directory.

Pass in a relative path to a specific tex file as an argument to generate a pdf for only that subfile:
```
./build.sh tex/recipes.tex
```