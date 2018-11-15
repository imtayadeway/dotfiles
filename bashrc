# Load any supplementary scripts

source ~/.bashrc.d/variables.bash
source ~/.bashrc.d/path.bash
source ~/.bashrc.d/aliases.bash
source ~/.bashrc.d/prompt.bash
source ~/.bashrc.d/utils.bash

### local config settings, if any
if [ -e ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi
