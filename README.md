# PCAPHelper
Batch scripts to parse and filter network packets quickly

This code dates back to my time as a packet analyst at a major government organization around 2010. It was originally written in batch, as I hadn't learned Python yet. 

## Why batch?
Through a lot of trial and error, and some not-so-scientific studying on the topic, batch seemed to be the cleanest and fastest performing way to run filters on packets. The scripts in this repo rely on tshark, mergecap, and editcap, which are all packaged with the normal Wireshark install.  Without the GUI layer that Wireshark provides, Tshark is much faster, especially with very large packet captures. I eventually rewrote of this code in Python, but it relied on a number of dependencies that kept changing, necessitating more upkeep of my scripts.  Tshark hasn't changed much over the years - so batch seemed the best way to automate routing filtering actions without the resource penalty of Wireshark and without the overhead of constantly updating the code in Python due to dependency changes.

## USAGE
These are batch (.bat) files for use in Windows. Use them however you want, but they were designed to be on the Desktop for quick access - especially drag-and-drop actions.

The main pcaphelper_vX.X.bat is best used inside of a folder/directory with stored pcaps. This is due to the capabilities of the SEARCH function which iterates over every .pcap file in the folder.  If you attempted to use the script outside the folder, you would have to aim the script at a folder, which is prone to typos and simply takes too much time. These scripts have been optimized for speed - I use them in packet analysis CTFs, so I scripted them around my methodologies for packet analysis in such and environment.

pcaphelper_vX.X.bat should be used directly in the folders containing your target pcap.  All other .bat files are best placed either on the desktop or together in a folder. For all .bat files, you can drag-and-drop your target pcap file(s) right onto the icon for the .bat script (again - time saving so you don't have to type out the complete path).  For merging .bats, they will currently accept up to 9 pcap files at a time.

## LICENSE
Do whatever you want with this code....I really don't care. If you find it useful though, drop me a note. It will make my day...
