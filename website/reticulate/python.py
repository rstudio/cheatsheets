import pandas as pd
import matplotlib as mpl
import seaborn as sns

tips = sns.load_dataset("tips",)
print(tips.iloc[0:5])

sns.set()
sns.lmplot(x = "total_bill", y = "tip", 
           hue = "smoker", data = tips)
mpl.pyplot.show()
