#!/bin/python

print "input one byte for xor calc. input '..' for clear previous result. input 'q' to quit."

crc = 0
while True:
    data = raw_input("> ")
    data = data.strip()
    # debug #print "TEST__%r__TEST" % data
    if data == '..':
        crc = 0
        print "crc ==> 0x00"
    elif data == 'q':
        break
        print "quit."
    else:
        try:
            digit = int(data, 16)
            crc = crc ^ digit
            print "%x ==> %x" % (digit, crc)
	except ValueError:
	    print "Wrong input: not a hex value. Ignored."

