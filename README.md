# A series of mainstream machine learning algorithms implement on FPGA.

<pre>
__     __        _                 _        
\ \   / /__ _ __(_)_ __ ___   __ _| | _____ 
 \ \ / / _ \ '__| | '_ ` _ \ / _` | |/ / _ \
  \ V /  __/ |  | | | | | | | (_| |   <  __/
   \_/ \___|_|  |_|_| |_| |_|\__,_|_|\_\___|
 </pre>

### Configurable parameters
|ANN|DT|k-NN|SVM|
|----------|----------|----------|----------|
|Data width(max=13); <br> Number of in-puts(max=16);<br> Number of hidden lay-ers(max=4);<br> Number of neurons in each hidden lay-er(max=8);<br> Number of tar-gets(max=16);<br> Activation functions |Data width(max=13);<br> Number of depth(max=5);<br> Number of leaf nodes(max=64);<br> Number of targets(max=16) |Data width(max=13);<br> Number of in-puts(max=16);<br> Number of neigh-bors(max=16); <br>Number of tar-gets(max=16)|Data width(max=13);<br> Number of in-puts(max=16); <br>Number of tar-gets(max=16)|