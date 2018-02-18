#!/bin/bash
apt-get update; apt-get install -y emacs git;

mkdir -p ~/.emacs.d

cat > ~/.emacs.d/init.el <<- EOM
(load "~/.emacs.d/init-packages")
(show-paren-mode 1)
(setq show-paren-delay 0)
(add-hook 'after-init-hook (lambda () (load-theme 'zenburn)))
(setq linum-format "%3d | ")
(require 'expand-region)
(global-set-key (kbd "C-L") 'er/expand-region)
EOM

cat > ~/.emacs.d/init-packages.el <<- EOM

(require 'package)

(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(add-to-list 'load-path "~/.emacs.d/site-lisp/")


; list the packages you want
(setq package-list
    '(python-environment deferred epc 
        flycheck ctable jedi concurrent company cyberpunk-theme elpy 
        yasnippet pyvenv highlight-indentation find-file-in-project 
        sql-indent sql exec-path-from-shell iedit
        auto-complete popup let-alist magit minimap popup expand-region 
	color-theme-sanityinc-tomorrow gruber-darker-theme zenburn-theme))


; activate all the packages
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

EOM
