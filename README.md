# TablemasterG2

`TablemasterG2` generates (nice) "experimental data" tables from SHELXL generated CIFs (Crystallographic Information File).
The program is written in PureBasic.

## Use is simple:

1. Open up to 5 CIFs with the `Load CIF n` buttons.

2. Decide if you want to include `Temperature` and `Moiety Formula`.

3. Decide if you want units in `[unit]` or more SI-like style `/unit` style by checking `SI Units`.

4. A plain text overview is displayed in the preview window. RTF, LaTeX and Markdown outputs will look differently from plain text but contain essentially the same information. 

5. Adapt the page orientation to your needs. The `Auto` feature changes the orientation to `Landscape` if the table exceeds 4 columns.

6. Copy the resulting table as RTF (useful for MS Word or Libre Office Writer), LaTeX, plain (Unicode) text, plain text with Markdown formatting with the `Copy Format` buttons.

7. It is also possible to save the resulting table in one of the above formats by clicking the appropriate `Save Format` button.


## Other options

* `Clear all`: Clears everything.
* `Help`	 : Displays this help.
* `About`	 : Version and license.
* `Exit`	 : Exit.


## Limitations

* `TablemasterG2` can handle SHELXL generated CIFs only (starting from SHELXL-97).

* The CIF should be free of errors, otherwise outputs will be senseless or the program will crash.

* If the space group is not given in the way `TablemasterG2` can handle it, the space group will be replaced by `?`. Recent SHELXL versions insert the space group automatically. The format is recognized by the program. 

* Tables can exceed the size of a A4 page in the LaTeX output. In this case you have to reduce the number of columns, change the page orientation or use the `tabularx` environment (has to be inserted manually in the `.tex` file). 

* The number of recognized CIF items is fixed in the source code.

## Compilation

* `TablemasterG2.pb`, `help.txt`, `license.txt` should be in the same folder. 

* Open `TablemasterG2.pb` with PureBasic. 

* Choose `Create Executable...` in the `Compiler` menu.

* Tested with PureBasic 5.50, Windows 10 (x64) and Linux (x64).

## License

BSD 3-Clause License

Copyright (c) 2016, Sebastian Dechert
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
