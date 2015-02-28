import time
import urllib2

def fetch(url, id):
    response = urllib2.urlopen(url + "/ep/pad/export/" + id + "/latest?format=txt")
    code = response.read()
    return code

if (len(sys.argv) < 4):
    print "Usage: python fetch.py <PAD_URL> <PAD_ID> <OUTPUT> <DELAY>
else:
    pad_url = sys.argv[1] 
    pad_id = sys.argv[2]
    pad_out = sys.argv[3]
    pad_del = sys.argv[4] if len(sys.argv) > 4 else 2

    // loop forever
    while (1):

        //fetch the code
        pad_txt = fetch(pad_url, pad_id)
        pad_size = len(pad_txt)

        //print pad_txt
        f = file(pad_out,'w')
        f.write(pad_txt)
        f.close()

        //sleep some
	time.sleep(5)
    

