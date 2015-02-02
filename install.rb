def files
  [
    "ackrc",
    "agignore",
    "bash_profile",
    "bashrc",
    "bashrc.aliases",
    "bashrc.prompt",
    "bin",
    "emacs.d",
    "gemrc",
    "gitconfig",
    "gitignore",
    "gitmessage",
    "offlineimaprc",
    "offlineimap.py",
    "rspec",
    "vimrc",
  ]
end

def source(file)
  File.expand_path("~/.#{ file }")
end

def target(file)
  File.expand_path("~/.dotfiles/#{ file }")
end

def skip_reason(file)
  if File.symlink?(file)
    "already linked"
  else
    "file already exists. delete or move before reinstalling."
  end
end

def main
  if File.exist?(File.expand_path('~/.bash_profile'))
    File.delete(File.expand_path('~/.bash_profile'))
  end

  files.each do |file|
    if File.exist?(target(file))
      print "skipping #{ target(file) }: #{ skip_reason(target(file)) }"
    else
      puts "linking #{ target(file) }"
      File.symlink(source(file), target(file))
    end
  end
end

main
