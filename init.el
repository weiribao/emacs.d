;;;;
;; Packages
;;;;

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))

(electric-pair-mode 1)
(evil-mode 1)
(linum-mode 1)

;; remove trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
