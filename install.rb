def main
  dotfiles.each { |file| try_linking(file) }
  link_bashrc
end

def dotfiles
  [
    "ackrc",
    "agignore",
    "authinfo.gpg",
    "bashrc",
    "bashrc.d",
    "bin",
    "bundle/config",
    "config/ipod-sync.conf",
    "config/redshift.conf",
    "emacs.d",
    "gemrc",
    "gitconfig",
    "gitignore",
    "gitmessage",
    "lein/profiles.clj",
    "mbsyncrc",
    "offlineimaprc",
    "offlineimap.py",
    "railsrc",
    "rubocop.yml",
    "rspec",
    "tmux.conf",
  ]
end

def try_linking(file)
  if File.exist?(target(file))
    puts "skipping #{ target(file) }: #{ skip_reason(target(file)) }"
  else
    puts "linking #{ target(file) }"
    require "fileutils"
    FileUtils.mkdir_p(File.dirname(target(file)))
    File.symlink(source(file), target(file))
  end
end

def source(file)
  File.expand_path("~/.dotfiles/#{ file }")
end

def target(file)
  File.expand_path("~/.#{ file }")
end

def skip_reason(file)
  if File.symlink?(file)
    "already linked"
  else
    "file already exists. delete or move before reinstalling."
  end
end

def path_for(file)
  File.expand_path(file)
end

def link_bashrc
  if File.exist?(path_for("~/.bash_profile"))
    File.delete(path_for("~/.bash_profile"))
  end

  File.symlink(path_for('~/.bashrc'), path_for('~/.bash_profile'))
end

main
