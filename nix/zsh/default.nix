{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    enableAutosuggestions = true;
    history.size = 10000;
    history.share = true;

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra = ''
      # autoSuggestions config
      # unsetopt correct # autocorrect commands
      # setopt hist_ignore_all_dups # remove older duplicate entries from history
      # setopt hist_reduce_blanks # remove superfluous blanks from history items
      # setopt inc_append_history # save history entries as soon as they are entered

      # auto complete options
      # setopt auto_list # automatically list choices on ambiguous completion
      # setopt auto_menu # automatically use menu completion
      # zstyle ':completion:*' menu select # select completions with arrow keys
      # zstyle ':completion:*' group-name "" # group results by category
      # zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

      # bind keys      
      bindkey  "^[[3~"  delete-char
      bindkey "^[[1;5C" forward-word    # ctrl ->
      bindkey '^I' forward-word         # tab
      bindkey "^[[1;5D" backward-word   # ctrl <-
      bindkey '^[[Z' backward-word      # shift+tab
      bindkey '\e[H' beginning-of-line   # Home
      bindkey '\e[F' end-of-line         # End
      bindkey '\e[1~' beginning-of-line
      bindkey '\e[4~' end-of-line
      bindkey '^ ' autosuggest-accept   # ctrl+space    

      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet   

      # Exports
      export JAVA_HOME=/usr/lib/jvm/default 
      export EDITOR="code --wait"


      # fzf
      #source < (fzf - -zsh)

    '';

    oh-my-zsh = {
      enable = true;
      # Standard OMZ plugins pre-installed to $ZSH/plugins/
      # Custom OMZ plugins are added to $ZSH_CUSTOM/plugins/
      # Enabling too many plugins will slowdown shell startup
      plugins = [
        "git"
        "sudo" # press Esc twice to get the previous command prefixed with sudo https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
      ];
      extraConfig = ''
        # Display red dots whilst waiting for completion.
        COMPLETION_WAITING_DOTS="true"
      '';
    };

    shellAliases = {
      # Overrides those provided by OMZ libs, plugins, and themes.
      # For a full list of active aliases, run `alias`.

      #-------------Bat related------------
      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";

      #------------Navigation------------
      prj = "cd $HOME/projects";
      scripts = "cd $HOME/Apps/scripts";
      nixcfg = "cd $HOME/src/nix-config";
      l = "eza -lah";
      la = "eza -lah";
      ll = "eza -lh";
      ls = "eza";
      lsa = "eza -lah";

      vim = "nvim";

      #-----------Others------------------
      get_idf = ". $HOME/esp/esp-idf/export.sh";
      dblog = "sh $HOME/Apps/pgLogs.sh";
      tsinit = "sh $HOME/Apps/tsinit.sh";
      bfmt = "numfmt --to=iec-i --suffix=B --format=\"%9.2f\"";
      g = "googler";

      #-----------Remotes----------------
      #TODO
    };
  };
}
