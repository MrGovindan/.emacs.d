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

;;(require 'google-c-style)
;;(add-hook 'c-mode-common-hook 'google-c-style)
;;(add-hook 'c-mode-common-hook 'google-make-newline-indent)

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

;;(require 'flycheck-google-cpplint)
;;(eval-after-load 'flycheck
  ;;'(progn
     ;;(require 'flycheck-google-cpplint)
     ;;(flycheck-add-next-checker 'rtags
				;;'c/c++-googlelint 'append)))

;;(custom-set-variables
 ;;'(flycheck-c/c++-googlelint-executable "/usr/local/bin/cpplint.py")
 ;;'(flycheck-googlelint-verbose "3")
 ;;'(flycheck-googlelint-root "/home/jesse/Documents/GamesGalore/src"))

(cmake-ide-setup)

(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-night)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'smartparens-config)
;(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'c++-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)

(require 'evil-smartparens)
(add-hook'smartparens-enabled-hook #'evil-smartparens-mode)

(require 'helm)
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

