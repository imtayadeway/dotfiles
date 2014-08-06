files = [
  'bash_profile',
  'bashrc',
  'bashrc.aliases',
  'bin',
  'emacs.d',
  'gitconfig',
  'gitignore',
  'gitmessage',
  'offlineimaprc',
  'offlineimap.py',
  'rspec'
]

files.each do |file|
  target_file = File.expand_path("~/.#{ file }")
  source_file = File.expand_path("~/.dotfiles/#{ file }")

  if File.exists?(target_file)
    print "skipping #{ target_file }: "
    if File.symlink?(target_file)
      puts "already linked"
    else
      puts "file already exists. delete or move before reinstalling."
    end
  else
    puts "linking #{ target_file }"
    File.symlink(source_file, target_file)
  end
end
