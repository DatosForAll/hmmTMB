all: hmmTMB.so 

hmmTMB.so: hmmTMB.cpp
	$(R_HOME)/bin/Rscript --vanilla -e "TMB::compile('hmmTMB.cpp','-O0 -g -Wno-ignored-attributes', safebounds=FALSE)"
	
clean:
	rm -rf *o