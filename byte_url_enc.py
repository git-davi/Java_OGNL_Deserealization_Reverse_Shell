import sys

def str_byte_url_enc(string) :
    bytes_urlenc = ''
    for byte in string.encode('utf-8') :
        bytes_urlenc += '%'+str(hex(byte))[2:]
    return bytes_urlenc

payload = sys.argv[1]
print(str_byte_url_enc(payload))