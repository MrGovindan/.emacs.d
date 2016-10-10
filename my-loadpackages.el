;;; ~/.emacs.d/my-loadpackages.el
; loading package

(load "~/.emacs.d/my-packages.el")

(require 'magit)
(define-key global-map (kbd "C-c m") 'magit-status)

(require 'yasnippet)
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/snippets")
(add-hook 'term-mode-hook (lambda()
    (setq yas-dont-activate-functions t)))

(require 'evil)
(evil-mode 1)

(require 'rtags)
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)

(defun my-rtags-file-jump ()
  (interactive)
  (evil-set-jump)
  (rtags-find-symbol-at-point))
(define-key c++-mode-map (kbd "<f12>") 'my-rtags-file-jump)
;;(define-key c-mode-base-map (kbd "C-]") (function rtags-find-symbol))

(require 'company)
(push 'company-rtags company-backends)
(global-company-mode)
(define-key c-mode-base-map (kbd "C-<tab>") (function company-complete))

(require 'flycheck)
(global-flycheck-mode)

(require 'flycheck-rtags)
(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++ mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(cmake-ide-setup)

(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-night)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'smartparens-config)
(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'c++-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode #'smartparens-mode)

(require 'evil-smartparens)
(add-hook'smartparens-enabled-hook #'evil-smartparens-mode)

(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)