if status is-interactive
  . ~/.aliases

  function last_history_item
      echo $history[1]
  end
  abbr -a _ --position anywhere --function last_history_item

  eval (/opt/homebrew/bin/brew shellenv)
end
