# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/mturquette/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# typo? fuck
eval (thefuck --alias | tr '\n' ';')
#set -g fish_user_paths "/usr/local/opt/gnupg@2.1/bin" $fish_user_paths
