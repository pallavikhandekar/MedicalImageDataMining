#Use follwing commands to install package.
#source("http://bioconductor.org/biocLite.R")
#biocLite("CRImage")
#Download and save the sample images folder in current directory
#setwd("<currentdirectory path>")

library("CRImage")
library("jpeg")
f1 = readJPEG("Sampleimages/4143211.jpg")
display(f1)
t=calculateOtsu(as.vector(f1))
print(t)
f2 = f1< (t+0.23) 
display(f2)

