files = [
  'ackrc',
  'agignore',
  'bash_profile',
  'bashrc',
  'bashrc.aliases',
  'bashrc.prompt',
  'bin',
  'emacs.d',
  'gemrc',
  'gitconfig',
  'gitignore',
  'gitmessage',
  'offlineimaprc',
  'offlineimap.py',
  'rspec',
  'vimrc',
]

if File.exist?(File.expand_path('~/.bash_profile'))
  File.delete(File.expand_path('~/.bash_profile'))
end

def source(file)
  File.expand_path("~/.#{ file }")
end

def target(file)
  File.expand_path("~/.dotfiles/#{ file }")
end

files.each do |file|
  if File.exist?(target(file))
    print "skipping #{ target(file) }: "
    if File.symlink?(target(file))
      puts "already linked"
    else
      puts "file already exists. delete or move before reinstalling."
    end
  else
    puts "linking #{ target(file) }"
    File.symlink(source_file, target_file)
  end
end
