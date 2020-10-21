(use-package minitest
  :init
  (setq minitest-use-zeus-when-possible nil)
  (setq minitest-keymap-prefix (kbd "C-c ."))
  (setq minitest-default-env "TESTOPTS='--pride'")
  (setq minitest-default-command '("ruby" "-Ilib:test" "-rbundler/setup" "-rminitest/pride")))
