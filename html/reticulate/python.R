library(reticulate)
py_install("seaborn")
use_virtualenv("r-reticulate")

sns <- import("seaborn")

fmri <- sns$load_dataset("fmri")
dim(fmri)

# creates tips
source_python("python.py")
dim(tips)

# creates tips in main
py_run_file("python.py")
dim(py$tips)

py_run_string("print(tips.shape)")




