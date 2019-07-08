#!/cm/shared/apps/python/intelpython2/bin/python2.7
import os
import glob
import numpy as np
import discEccanalysis as DE
import matplotlib.pyplot as plt

def makeplots(namedata,binN=30):
    try:
        res=DE.loadHDF5(namedata)
    except:
        print "Something went wrong, no datasim file in this folder"
        return

    res['time']=res['time']/6.2831
    res['sinkTime']=res['sinkTime']/6.2831 
    plt.pcolormesh(res['radProf'],res['time'],res['sigma'],cmap='inferno')
    plt.colorbar()
    plt.xlabel('$R$')
    plt.ylabel('$t/t_{\\rm bin}$')
    plt.savefig('sigmavstR.png')
    plt.clf()

    plt.pcolormesh(res['radProf'],res['time'],res['eprof'],\
        vmax=0.4,cmap='inferno')    
    plt.colorbar()
    plt.xlabel('$R$')
    plt.ylabel('$t/t_{\\rm bin}$')
    plt.savefig('evstR.png')
    plt.clf()

    plt.pcolormesh(res['radProf'],res['time'],res['phaseprof'],cmap='inferno')
    plt.colorbar()
    plt.xlabel('$R$')
    plt.ylabel('$t/t_{\\rm bin}$')
    plt.savefig('phivstR.png')
    plt.clf()

    try:
		plt.pcolormesh(res['radProf'],res['time'],res['eprofA'],\
			vmax=0.4,cmap='inferno')    
		plt.colorbar()
		plt.xlabel('$a$')
		plt.ylabel('$t/t_{\\rm bin}$')
		plt.savefig('eAvstR.png')
		plt.clf()

		plt.pcolormesh(res['radProf'],res['time'],res['phaseprofA'],cmap='inferno')
		plt.colorbar()
		plt.xlabel('$a$')
		plt.ylabel('$t/t_{\\rm bin}$')
		plt.savefig('phiAvstR.png')
		plt.clf()

		plt.pcolormesh(res['radProf'],res['time'],res['discfracA'],cmap='inferno')
		plt.colorbar()
		plt.xlabel('$a$')
		plt.ylabel('$t$')
		plt.savefig('discfracAvstR.png')
		plt.clf()
    except:
        print "did not find some A quantities"


    rmax=np.max(res['radProf'])
    plt.pcolormesh(res['radProf'],res['time'],res['aprof'],cmap='inferno',vmin=0,vmax=rmax)
    plt.colorbar()
    plt.xlabel('$R$')
    plt.ylabel('$t/t_{\\rm bin}$')
    plt.savefig('avstR.png')
    plt.clf()

    try:
		plt.plot(res['time'],res['Ecctot'],label='$e_{\\rm tot}$')
		plt.plot(res['sinkTime'],res['sinkE'],label='$e_{\\rm bin}$')  
		plt.plot(res['time'],res['Ecctot2'],label='$e_{\\rm tot,2}$')
		plt.xlabel('$t/t_{\\rm bin}$')
		plt.ylabel('$e$')
		plt.legend()
		plt.savefig('./eccTot.png')
		plt.clf()


		plt.plot(res['time'],res['eprof'][:,binN],label='$e_{\\rm d}$ at R='+str(res['radProf'][binN])[0:4])
		plt.plot(res['sinkTime'],res['sinkE'],label='$e_{\\rm bin}$')  
		plt.xlabel('$t/t_{\\rm bin}$')
		plt.ylabel('$e$')
		plt.legend()
		plt.savefig('EvstBinDisc.png')
		plt.clf()

		plt.plot(res['time'],res['phaseprof'][:,binN],label='$\\Phi_{\\rm d}$ at R='+str(res['radProf'][binN])[0:4],marker='.')
		plt.plot(res['sinkTime'],res['sinkPhi'],label='$\\Phi_{\\rm bin}$',marker='.')  
		plt.xlabel('$t/t_{\\rm bin}$')
		plt.ylabel('$\\Phi$')
		plt.legend()
		plt.savefig('PhivstBinDisc.png')
		plt.clf()

		plt.plot(res['sinkTime'],res['sinkA'],label='$a_{\\rm bin}$')
		plt.xlabel('$t/t_{\\rm bin}$')
		plt.ylabel('$a$')
		plt.legend()
		plt.savefig('Avst.png')
		plt.clf()  

    except:
        print 'trying to make also sink plots, but no sink found'

    return
 

