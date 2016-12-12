;; Make it so the bell doesn't work
(setq ring-bell-function 'ignore)

;; And don't make backup files...
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Add melpa repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; VIM bindings
(require 'evil)
(evil-mode 1)

;; Add line numbers
(setq linum-format "%4d ")
(add-hook 'find-file-hook (lambda () (linum-mode 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (smyx)))
 '(custom-safe-themes
   (quote
    ("8288b9b453cdd2398339a9fd0cec94105bc5ca79b86695bd7bf0381b1fbe8147" default))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :width normal :family "Inconsolata")))))
