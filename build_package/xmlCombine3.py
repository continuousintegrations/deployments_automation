import os.path
import sys
from xml.dom import minidom

def run(filename, directory):
    if(os.path.isfile(filename)):
        fileTemp = minidom.parse(filename)
        print 'Found file manifestTemplate.xml'
    else:
        print 'There is no file manifestTemplate.xml'
        sys.exit()

    rootTemp = fileTemp.getElementsByTagName('root')[0]
    layoutsTemp = rootTemp.getElementsByTagName('layouts')[0]
    portletsTemp = rootTemp.getElementsByTagName('portlets')[0] 
    rolesTemp = rootTemp.getElementsByTagName('roles')[0]
       

    #parsowanie pliku wesjciowego
    print "Looking for manifest.xml files in: %s" % directory
    os.chdir(directory)
    for root, dirs, files in os.walk(directory,topdown=False):
        for file in files:
            if file == "manifest.xml":
                print(os.path.join(root, file))
                data = minidom.parse(os.path.join(root, file))
                for layout in data.getElementsByTagName('layout'):
                    layoutsTemp.appendChild(layout)
                for portlet in data.getElementsByTagName('portlet'):
                    portletsTemp.appendChild(portlet)
                for role in data.getElementsByTagName('role'):
                    rolesTemp.appendChild(role)   

    f = open("manifest_temporary.xml", "w")
    xmlstr = rootTemp.toxml(encoding="utf-8")
    f.write( '<?xml version="1.0" encoding="UTF-8"?>')
    f.write(xmlstr)
    f.close()

     
if __name__ == "__main__":
    run(sys.argv[1], sys.argv[2])
	
