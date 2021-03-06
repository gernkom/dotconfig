(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(save-place-mode 1)
(mouse-wheel-mode -1)
(setq scroll-step 1
      scroll-margin 10
      hscroll-step 1
      hscroll-margin 10
      scroll-preserve-screen-position 'always)
(setq column-number-mode t)
(setq-default display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode)

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
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package rainbow-delimiters
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package highlight-parentheses
  :init (add-hook 'prog-mode-hook 'highlight-parentheses-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(defun gk-flycheck-c-setup ()
  (setq flycheck-clang-language-standard "gnu11"))
(add-hook 'c-mode-hook #'gk-flycheck-c-setup)

(set-frame-font "Cascadia Code-9" nil t)

(defun gk-search (query-url prompt)
  "Open the search url constructed with the QUERY-URL.
PROMPT sets the `read-string prompt."
  (browse-url
   (concat query-url
	   (url-hexify-string
	    (if mark-active
		(buffer-substring (region-beginning) (region-end))
	      (read-string prompt))))))

(defmacro gk-install-search-engine (search-engine-name search-engine-url search-engine-prompt)
  "Given some information regarding a search engine, install the interactive command to search through them"
  `(defun ,(intern (format "gk-%s" search-engine-name)) ()
     ,(format "Search %s with a query or region if any." search-engine-name)
     (interactive)
     (gk-search ,search-engine-url ,search-engine-prompt)))

(gk-install-search-engine "google"  "https://www.google.com/search?q="              "Google: ")
(gk-install-search-engine "youtube" "https://www.youtube.com/results?search_query=" "Search YouTube: ")
(gk-install-search-engine "github"  "https://github.com/search?q="                  "Search GitHub: ")
