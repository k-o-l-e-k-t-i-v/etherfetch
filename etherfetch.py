import sys
import time
import urllib2
import sys

def fetch(url, id):
    response = urllib2.urlopen(url + '/p/' + id + '/export/txt')
    code = response.read()
    return code

if (len(sys.argv) < 4):
    print "Usage: python etherfetch.py <PAD_URL> <PAD_ID> <OUTPUT> <DELAY>"
else:
    pad_url = sys.argv[1]
    pad_id = sys.argv[2]
    pad_out = sys.argv[3]
    pad_del = sys.argv[4] if len(sys.argv) > 4 else 2

    #loop forever
    while (1):

        #fetch the code
        pad_txt = fetch(pad_url, pad_id)
        pad_size = len(pad_txt)
        #sys.stdout.write(pad_txt)
        #sys.stdout.flush()
        f = open(pad_out,'w+')
        f.write(pad_txt)
        f.close()

	print "fetched %d bytes from %s" % (pad_size, pad_id)

        #sleep some
	time.sleep(5)
    

