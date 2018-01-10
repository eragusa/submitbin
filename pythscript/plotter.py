#!/bin/python
import matplotlib.pyplot as plt
import numpy as np
import os
import sys


if __name__=="__main__":
    

    print sys.argv[0]
    printall=False
    if(not printall):
            col2plot=[1,2,11,12,13]

    for j in range(1,len(sys.argv)):
        
        filename= sys.argv[j]
        print "Filename: ",filename

        #!
        #!--- Get column number and header lines 
        #!    Print the number of columns for each line in a prov file.
        #!    Number of columns given when ncols is equal for 4 lines.
        #!    Assuming that the header lenght is less than 20 lines
        #!
        
        
        ncols=0
        nrowh=0
        n=21

        command1="awk 'NR<"+ str(n)+" {print NF}' "+filename+">prov"
        os.system(command1)

        prov=np.loadtxt("prov")
        
        for i in range(n-4):
            if (prov[i]==ncols and prov[i+1]==ncols and prov[i+2]==ncols and prov[i+3]==ncols): 
                nrowh=i+1
                break
            ncols=prov[i]

        ncols=prov[i]
        os.system("rm prov")  
    #################################################

        #open file
        data=np.loadtxt(filename,skiprows=int(nrowh))
        if printall:
                for i in range(1,int(ncols)):
                    plt.figure(i)
                    plt.plot(data[:,0],data[:,i])
        else:
                for i in col2plot:
                    plt.figure(i)
                    plt.plot(data[:,0],data[:,i])
        

    plt.draw()
    plt.pause(1)
    raw_input("<Hit enter to close the plots>")
    plt.close('all')

           
        
        
