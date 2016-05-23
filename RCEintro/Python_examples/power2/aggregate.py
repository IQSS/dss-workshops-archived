import numpy as np
import glob
## list all output files in the output directory
output_files = glob.glob("output/out*")

output_values = map(lambda f: np.float(open(f).read()), output_files)
