(let ((gc-cons-threshold most-positive-fixnum))

  ;;custom emacs dir since I'm playing with several configs
  (setq oa-user-emacs-directory "~/.vanillaemacs.d/")
  (setq oa-package-user-dir (concat oa-user-emacs-directory "elpa/"))
  (setq user-emacs-directory oa-user-emacs-directory)

  ;; Set repositories
  (require 'package)
  (setq-default
   ;; load-prefer-newer t
   package-enable-at-startup nil)
  (setq package-user-dir oa-package-user-dir)
  (add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)

  ;; install use-package if not installed
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    ;;      (package-install 'delight t)
    (package-install 'use-package t))
  (require 'use-package)
  (setq-default
   use-package-always-defer t
   use-package-always-ensure t)

  ;; Use latest Org
  ;;(use-package org :ensure org-plus-contrib)
  (use-package org )
  ;; Tangle configuration
  (when window-system
    (blink-cursor-mode 0)                           ; Disable the cursor blinking
    (scroll-bar-mode 0)                             ; Disable the scroll bar
    (tool-bar-mode 0)                               ; Disable the tool bar
    (tooltip-mode 0))                               ; Disable the tooltips

  (setq-default
   ad-redefinition-action 'accept                   ; Silence warnings for redefinition
   confirm-kill-emacs 'yes-or-no-p                  ; Confirm before exiting Emacs
   cursor-in-non-selected-windows t                 ; Hide the cursor in inactive windows
   delete-by-moving-to-trash t                      ; Delete files to trash
   fill-column 80                                   ; Set width for automatic line breaks
   help-window-select t                             ; Focus new help windows when opened
   indent-tabs-mode nil                             ; Stop using tabs to indent
   inhibit-startup-screen t                         ; Disable start-up screen
   initial-scratch-message ""                       ; Empty the initial *scratch* buffer
   left-margin-width 0 right-margin-width 0         ; Add left and right margins
   recenter-positions '(middle top bottom)          ; Set re-centering positions
   scroll-conservatively most-positive-fixnum       ; Always scroll by one line
   scroll-margin 10                                 ; Add a margin when scrolling vertically
   select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
   sentence-end-double-space nil                    ; End a sentence after a dot and a space
   show-trailing-whitespace nil                     ; Display trailing whitespaces
   split-height-threshold 80
   split-width-threshold 160
   tab-width 4                                      ; Set width for tabs
   uniquify-buffer-name-style 'forward              ; Uniquify buffer names
   window-combination-resize t                      ; Resize windows proportionally
   x-stretch-cursor nil                            ; dont' stretch cursor to the glyph width
   ring-bell-function 'ignore)                      ; don't make annoying bell sounds 
  (cd "~/")                                         ; Move to the user directory
  (display-time-mode 1)                             ; Enable time in the mode-line
  (fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
  (mouse-avoidance-mode nil )                    ; Avoid collision of mouse with point
  (put 'downcase-region 'disabled nil)              ; Enable downcase-region
  (put 'upcase-region 'disabled nil)                ; Enable upcase-region
  (set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
  (set-language-environment "UTF-8")

  (use-package zenburn-theme
    :ensure t
    :demand t
    :config
    (load-theme 'zenburn t))

  (use-package evil
    :ensure t
    :hook (after-init . evil-mode))

  (use-package which-key
    :ensure t
    :demand t
    :config (which-key-mode 1))

  (use-package helm
    :ensure t
    :demand t
    :bind (("M-x" . helm-M-x))
    )

  (use-package company
    :ensure t
    )

  (use-package smartparens
    :ensure t
    )

  ;; keybindings using general.el
    (use-package general 
    :ensure t
    :demand t
    :config
    (general-evil-setup t)

    (general-define-key
     :states '(normal visual)
     :prefix "SPC"
     "SPC" 'helm-M-x
     "f" '(:ignore t :which-key "files")
     "fs" 'save-buffer
     "ff" 'helm-find-files
     )
    )

    ;; elisp config
    (add-hook 'emacs-lisp-mode-hook 'company-mode)
    (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)

  (garbage-collect))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company auctex helm evil zenburn-theme which-key use-package org-plus-contrib general))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
