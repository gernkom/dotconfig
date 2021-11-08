(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(save-place-mode 1)
(setq scroll-step 1
      scroll-margin 10
      hscroll-step 1
      hscroll-margin 10
      scroll-preserve-screen-position 'always)
(setq column-number-mode t)
(setq-default display-fill-column-indicator-column 79)
(global-display-fill-column-indicator-mode)

(setq url-proxy-services '(("http" . "127.0.0.1:7890")
			   ("https" . "127.0.0.1:7890")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless (bound-and-true-p package--initialized)
  (package-initialize))
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally t)
  (setq use-package-verbose t))
(require 'use-package)
(use-package all-the-icons)
(use-package nord-theme
  :init
  (load-theme 'nord t))
;; (use-package monokai-theme
;;   :init
;;   (load-theme 'monokai t))
(use-package emacs
  :config
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t))

(use-package which-key
  :defer nil
  :diminish
  :init (which-key-mode))

(use-package company
  :config
  (setq company-dabbrev-code-everywhere t
	company-dabbrev-code-modes t
	company-dabbrev-code-other-bufers 'all
	company-dabbrev-downcase nil
	company-dabbrev-ignore-case t
	company-dabbrev-other-buffers 'all
	company-require-match nil
	company-minimum-prefix-length 1
	company-show-numbers t
	company-tooltip-limit 10
	company-idle-delay 0
	company-echo-delay 0
	company-tooltip-offset-display 'scrollbar
	company-begin-commands '(self-insert-command))
  (push '(company-semantic :with company-yasnippet) company-backends)
  :hook ((after-init . global-company-mode)))

(use-package yasnippet
  :diminish
  :init (add-hook 'after-init-hook 'yas-global-mode))
(use-package yasnippet-snippets)

(use-package rust-mode)
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package rainbow-delimiters
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package highlight-parentheses
  :init (add-hook 'prog-mode-hook 'highlight-parentheses-mode))

;; (set-frame-font "JetBrainsMono Nerd Font-9" nil t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(highlight-parentheses rainbow-delimiters cargo rust-mode yasnippet-snippets yasnippet company which-key monokai-theme all-the-icons use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
