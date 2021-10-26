(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(save-place-mode 1)

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
(use-package monokai-theme
  :init
  (load-theme 'monokai t))
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

