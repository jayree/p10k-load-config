# Code snippet based on https://github.com/romkatv/powerlevel10k/blob/c21961b53c137253020aeffca2b132fdd6bcb116/internal/wizard.zsh#L1410-L1427
if [[ -e $__p9k_zshrc ]]; then
  zshrc_content="$(<$__p9k_zshrc)" || quit -c
  local lines=("${(@f)zshrc_content}")
  local __p9k_cfg_path_o=${ZDOTDIR:-~}/.p10k.zsh
  local f0=$__p9k_cfg_path_o
  local f1=${(q)f0}
  local f2=${(q-)f0}
  local f3=${(qq)f0}
  local f4=${(qqq)f0}
  local g1=${${(q)__p9k_cfg_path_o}/#(#b)${(q)HOME}\//'~/'}
  local h1=${(@M)lines:#(#b)[^#]#([^[:IDENT:]]|)source[[:space:]]##($f1|$f2|$f3|$f4|$g1)(|[[:space:]]*|'#'*)}
  if [[ -n $h1 ]]; then
    # Code snippet based on https://github.com/romkatv/powerlevel10k/blob/f85a3a56524f79c52ce367e9d55a2ef275b76155/internal/wizard.zsh#L1449-L1454
    local zshrc_backup="$(mktemp ${TMPDIR:-/tmp}/.zshrc.XXXXXXXXXX)"
    cp -p $__p9k_zshrc $zshrc_backup
    local zshrc_backup_u=${${TMPDIR:+\$TMPDIR}:-/tmp}/${(q-)zshrc_backup:t}
    local lines=("${(@)lines/#(#b)([[:space:]]#)$h1(  |)/# $match[1]$h1$match[2]$match[2]}")
    local tmp=$__p9k_zshrc.${(%):-%n}.tmp.$$
    {
      >$tmp print -lr -- "$lines[@]" || return
      zf_mv -f -- $tmp $__p9k_zshrc || return
      } always {
      zf_rm -f -- $tmp
    }
    # Code snippet based on https://github.com/romkatv/powerlevel10k/blob/f85a3a56524f79c52ce367e9d55a2ef275b76155/internal/wizard.zsh#L1718-L1723
    if [[ -n $zshrc_backup_u ]]; then
      print -rP "%Bp10k-load-config%b: See "%B${__p9k_zshrc_u//\\/\\\\}%b" changes:"
      print -rP  "
  %2Fdiff%f %B$zshrc_backup_u%b %B$__p9k_zshrc_u%b
      "
      print -rP  "Restart your terminal for the change to take effect."
    fi
    
  else
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  fi
fi