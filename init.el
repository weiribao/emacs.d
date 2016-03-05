(add-to-list 'load-path "~/.emacs.d/go")

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;;;;
;; Packages
;;;;

(add-to-list 'load-path "~/.emacs.d/rust-mode")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)

;;; Disable large file warning
(setq large-file-warning-threshold nil)

;;; modes
(electric-pair-mode 1)

(require 'evil)
;;;(evil-mode 1)

(global-linum-mode 1)

;;; enable flex matching
;;; https://github.com/lewang/flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(auto-complete-mode 1)

(yas-global-mode 1)

(add-hook 'javascript-mode-hook (lambda () (setq tab-width 4)))

(defun my-go-mode-hook ()
					; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
					; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
					; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
	   "go build -v && go test -v && go vet"))
					; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)
;;; projectile
(projectile-global-mode)
(setq projectile-require-project-root nil)
(setq projectile-enable-caching t)
;; ((nil . ((projectile-globally-ignored-files . '("experiment/*")))))

;; remove trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Key bindings
(global-set-key (kbd "C-x f") 'projectile-find-file)

;;; go
;;(require 'go-mode-load)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(require 'company)                                   ; load company mode
(require 'company-go)                                ; load company mode go backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-hook 'before-save-hook 'gofmt-before-save)

;;(add-hook 'go-mode-hook (lambda ()(local-set-key (kbd \"M-.\") 'godef-jump)))
