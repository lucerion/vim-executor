*vim-executor.txt*    Vim plugin that execute shell command and redirect output
                    to a new buffer

Author:             Alexander Skachko <alexander.skachko@gmail.com>
Homepage:           https://github.com/lucerion/vim-executor
Version:            0.2.0 (2016-12-20)
Licence:            BSD-3-Clause (see LICENSE)

===============================================================================
CONTENTS                                                         *vim-executor*

Install                                                  |vim-executor-install|
Commands                                                |vim-executor-commands|
Options                                                  |vim-executor-options|
Changelog                                              |vim-executor-changelog|
License                                                  |vim-executor-license|

===============================================================================
INSTALL                                                  *vim-executor-install*

Vundle                                https://github.com/VundleVim/Vundle.vim
>
    Plugin 'lucerion/vim-executor'
<
Pathogen                                https://github.com/tpope/vim-pathogen
>
    cd ~/.vim/bundle
    git clone https://github.com/lucerion/vim-executor
<
NeoBundle                             https://github.com/Shougo/neobundle.vim
>
    NeoBundle 'lucerion/vim-executor'
<
vim-plug                                 https://github.com/junegunn/vim-plug
>
    Plug 'lucerion/vim-executor'
<
Manual
>
    git clone https://github.com/lucerion/vim-executor
<
    copy all of the files into your ~/.vim directory

===============================================================================
COMMANDS                                                *vim-executor-commands*

                                                                        *:Exec*

:[range]Exec[!] {command}     Execute shell {command} and open new buffer
                              with the command output.
                              If one line selected this line will be executed
                              as a command, with more than one - plugin will
                              pass lines to a command as an argument.
                              If ! is given, buffer with result will not opened.

===============================================================================
OPTIONS                                                  *vim-executor-options*

                                                          *g:executor_position*

Result buffer position.

Positions: 'top', 'bottom', 'left', 'right', 'tab'
Default: 'bottom'

                                                       *g:executor_buffer_name*

A pattern for a buffer name. {command} will be replaced with executed command,
{filename} with current file name.

Default: '{command}'

                                                      *g:executor_reuse_buffer*

Reuse buffer with results instead of opening new one.

Default: 0

                                                        *g:executor_exec_async*

Enable/disable async command execution (only for vim version > 8.0).

Default: 1

===============================================================================
CHANGELOG                                              *vim-executor-changelog*

0.2.0 (2016-12-20)~

  Changes
    * async execution for vim version > 8.0 added

0.1.0 (2016-12-12)~

  First release

===============================================================================
LICENSE                                                  *vim-executor-license*

Copyright © 2016, Alexander Skachko
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

===============================================================================
vim:tw=78:ts=4:ft=help:norl:
