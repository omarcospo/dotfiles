;; -*- lexical-binding: t -*-

;; theme
(defun set-custom-fonts ()
  "Set the custom fonts for `default` and `variable-pitch` faces."
  (set-frame-parameter nil 'alpha-background 90)
  (set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 150 :weight 'regular)
  (set-face-attribute 'variable-pitch nil :font "Iosevka Nerd Font" :height 150 :weight 'regular))

;; Apply font settings to the initial frame
(set-custom-fonts)

;; Apply font settings to all new frames
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (set-custom-fonts))))

(defadvice load-theme (before theme-dont-propagate activate)
  "Disable theme before loading new one."
  (mapc #'disable-theme custom-enabled-themes))

(use-package doom-themes
  :config
  (load-theme 'doom-tomorrow-night t)
  (custom-set-faces
   '(default ((t (:background "#1C1E1F"))))
   '(window-divider ((t (:foreground "#3D4043"))))))

;; evil
(use-package general)

(use-package evil
  :init
  (setq evil-undo-system 'undo-fu
        evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-i-jump nil
        evil-want-C-u-scroll t)
  :config
  (with-eval-after-load 'evil
    (dolist (state '(normal insert visual motion operator replace emacs))
      (define-key (symbol-value (intern (format "evil-%s-state-map" state))) (kbd "C-k") nil)
      (define-key (symbol-value (intern (format "evil-%s-state-map" state))) (kbd "C-w") nil)
      (define-key (symbol-value (intern (format "evil-%s-state-map" state))) (kbd "C-d") nil)
      (define-key (symbol-value (intern (format "evil-%s-state-map" state))) (kbd "C-a") nil)
      ))
  (dolist (mode '(eshell-mode git-rebase-mode term-mode))
	  (add-to-list 'evil-emacs-state-modes mode))
  (add-to-list 'evil-normal-state-modes 'messages-buffer-mode)
  (add-to-list 'evil-insert-state-modes 'vterm-mode)
  (evil-mode 1))

(use-package undo-fu
  :custom
  (undo-limit 67108864)
  (undo-strong-limit 100663296)
  (undo-outer-limit 1006632960))

(use-package undo-fu-session
  :config
  (undo-fu-session-global-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode)
  :general
  (:states '(normal)
           "s" 'evil-surround-edit))

(use-package visual-regexp-steroids
  :custom
  (vr/auto-show-help nil)
  (vr/default-replace-preview t)
  :general
  (:states '(normal visual emacs motion)
           :keymaps 'override
           "C-e" 'vr/replace))

(defun kill-window ()
  (interactive)
  (if (>= (count-windows) 2)
      (progn (kill-buffer (current-buffer))
		         (delete-window))
    (kill-buffer (current-buffer))))

(general-define-key
 :states '(normal visual emacs motion insert)
 :keymaps '(dict-mode-map helpful-mode-map dired-mode-map image-mode-map special-mode-map messages-buffer-mode-map elfeed-show-mode-map)
 "q" 'kill-window)

;; leader
(general-create-definer leader
  :keymaps 'override
  :states '(normal visual operator motion)
  :prefix "SPC")

(general-create-definer local
  :keymaps 'override
  :states '(normal visual operator motion)
  :prefix "n")

(leader
  "SPC" 'execute-extended-command
  ;; File operations
  "f" 'nil
  "ff" 'find-file
  "fs" 'save-buffer
  "fr" 'consult-recent-file
  ;; Toggle
  "t" 'nil
  "tl" 'toggle-truncate-lines
  ;; Buffer operations
  "b" 'nil
  "bb" 'switch-to-buffer
  "bk" 'kill-current-buffer
  "br" 'revert-buffer-quick
  ;; Window operations
  "w" 'nil
  "ws" 'split-window-below
  "wv" 'split-window-right
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wc" 'evil-window-delete)

;; everywhere
(general-def
  "C-h" 'beginning-of-line
  "C-l" 'end-of-line
  "C-q" 'keyboard-escape-quit)

;; insert
(general-def :states 'normal
  "C-d" 'evil-scroll-down)

(general-def :states 'insert
  "C-h" 'delete-backward-char
  "C-q" 'evil-normal-state)

;; completion hard

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (use-package yasnippet-snippets)
  (add-to-list 'yas-snippet-dirs (concat user-cache-dir "snippets/"))
  (yas-global-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 0)
  (company-tooltip-align-annotations t)
  (company-require-match 'never)
  (company-idle-delay 0.1)
  (company-show-numbers nil)
  (company-dabbrev-other-buffers nil)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil)
  (company-quickhelp-delay nil)
  :general
  (:keymaps 'company-active-map
            "C-j" 'company-select-next
            "C-k" 'company-select-previous
            "C-f" 'company-complete
            "C-d" 'company-quickhelp-manual-begin
            "C-h" 'evil-delete-backward-char)
  :config
  (defun company-mode/backend-with-yas (backend)
    "Add yasnippet to the given BACKEND."
    (if (and (listp backend) (member 'company-yasnippet backend))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  (straight-use-package 'company-quickhelp)
  (company-quickhelp-mode))

;; menu
(use-package vertico
  :defer t
  :general
  (:keymaps 'vertico-map
	          "C-j" 'vertico-next
	          "C-k" 'vertico-previous
	          "C-f" 'vertico-exit)
  (:keymaps 'minibuffer-local-map
	          "C-h" 'minibuffer-backward-kill)
  :custom
  (vertico-resize 'fixed)
  (vertico-cycle t)
  (vertico-count 10)
  (marginalia-annotator '(built-in))
  (history-length 35)
  :init
  (defun minibuffer-backward-kill (arg)
    "When minibuffer is completing a file name delete up to parent folder, otherwise delete normally"
    (interactive "p")
    (if minibuffer-completing-file-name
	      (when (string-match-p "/." (minibuffer-contents))
	        (zap-up-to-char (- arg) ?/))
      (unless (or (get-text-property (point) 'read-only)
		              (eq (point) (point-min))
		              (get-text-property (1- (point)) 'read-only))
	      (delete-char -1))))
  (straight-use-package 'marginalia)
  (vertico-mode)
  (marginalia-mode))

(use-package prescient
  :custom
  (prescient-persist-mode +1)
  (completion-styles '(basic))
  (prescient-history-length 1000))

(use-package vertico-prescient
  :after prescient
  :config (vertico-prescient-mode))

(use-package company-prescient
  :after prescient
  :config (company-prescient-mode))

(use-package corfu-prescient
  :after prescient
  :config (corfu-prescient-mode))

(use-package consult
  :defer t
  :custom
  (consult-buffer-sources '(consult--source-buffer consult--source-recent-file))
  (consult-preview-key nil)
  :general
  (:keymaps 'override
            :states '(normal visual operator motion)
            "f" 'consult-line))

(use-package evil-nerd-commenter
  :general
  (:keymaps 'override
            :states '(normal visual operator motion)
            "gc" 'evilnc-comment-or-uncomment-lines))

;; helpful describe
(use-package helpful
  :custom
  (helpful-max-buffers 1)
  (read-symbol-positions-list nil)
  :config
  (leader
    "hs" 'helpful-symbol
    "ha" 'helpful-at-point
    "hv" 'helpful-variable
    "hf" 'helpful-function
    "hk" 'helpful-key))

(use-package which-key
  :custom
  (which-key-idle-delay 0.0)
  (which-key-add-column-padding 0)
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-separator " - ")
  (which-key-side-window-slot 0)
  (which-key-min-display-lines 1)
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))

;;git interface
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (transient-default-level 5)
  (magit-diff-refine-hunk nil)
  (magit-save-repository-buffers nil)
  (magit-revision-insert-related-refs nil)
  (transient-display-buffer-action 'display-buffer-below-selected)
  (magit-bury-buffer-function #'magit-mode-quit-window)
  :general
  (:keymaps 'magit-status-mode-map
            "p"   'magit-push
            "C-d" 'evil-scroll-down
            "C-u" 'evil-scroll-up
            "v"   'evil-visual-line
            "j"   'magit-next-line
            "k"   'magit-previous-line
            "l"   'magit-section-toggle
            "h"   'magit-diff-visit-file
            "C-r" 'magit-refresh-all
            "C-l" 'magit-log-all)
  (:keymaps 'magit-log-mode-map
            "l" 'magit-show-commit
            "j"   'evil-next-line
            "k"   'evil-previous-line)
  :init
  (leader "g" 'magit-status))

(use-package diff-hl
  :custom
  (diff-hl-show-staged-changes nil)
  (global-diff-hl-mode))

;;formatting
(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode))

(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode))

;;parentheses
(use-package smartparens
  :custom
  (sp-show-pair-from-inside t)
  (sp-cancel-autoskip-on-backward-movement nil)
  :hook (prog-mode . smartparens-mode))

(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode)
  :custom
  (hl-paren-colors '("red1" "orange1" "cyan1" "green1"))
  (hl-paren-background-colors '(nil nil nil)))

;;completion
(use-package eterm-256color)

(use-package vterm
  :custom
  (vterm-term-environment-variable "eterm-color")
  (vterm-kill-buffer-on-exit t)
  (vterm-buffer-name "vterm")
  (vterm-max-scrollback 5000)
  (vterm-timer-delay 0)
  (confirm-kill-process 'nil))

(use-package vterm-toggle
  :init
  (leader "v" 'vterm-toggle)
  :general
  (:keymaps 'vterm-mode-map
            :states 'insert
            "C-y" 'vterm-yank
            "C-v" 'vterm-toggle
            "C-p" 'vterm-yank-pop
            "C-h" 'vterm-send-backspace
            "C-j" 'vterm-send-C-j)
  :config
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 (reusable-frames . visible)
                 (window-height . 0.30))))

(use-package marginalia
  :config
  (marginalia-mode))

(use-package embark-consult)
(use-package embark
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (defun with-minibuffer-keymap (keymap)
    (lambda (fn &rest args)
      (minibuffer-with-setup-hook
          (lambda ()
            (use-local-map
             (make-composed-keymap keymap (current-local-map))))
        (apply fn args))))

  (defvar embark-completing-read-prompter-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "<tab>") 'abort-recursive-edit)
      map))

  (advice-add 'embark-completing-read-prompter :around
              (with-minibuffer-keymap embark-completing-read-prompter-map))

  (defun embark-act-with-completing-read (&optional arg)
    (interactive "P")
    (let* ((embark-prompter 'embark-completing-read-prompter)
           (embark-indicators '(embark-minimal-indicator))
           (embark-cycle-key nil))  ;;;Disable cycling
      (embark-act arg)))
  :general
  (:states '(normal visual)
           "C-w" 'embark-act-with-completing-read))

(use-package dired
  :ensure nil
  :straight dired-hide-dotfiles dired-ranger
  :config
  (add-hook 'dired-mode-hook 'dired-omit-mode)
  (add-hook 'dired-mode-hook 'auto-revert-mode)
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  :custom
  (sudo-edit-local-method "su")
  (dired-recursive-deletes 'always)
  (dired-recursive-copies 'always)
  (dired-create-destination-dirs 'always)
  (dired-auto-revert-buffer t)
  (dired-dwim-target t)
  (dired-hide-details-hide-symlink-targets nil)
  (dired-omit-verbose nil)
  (dired-use-ls-dired nil)
  (dired-listing-switches "-vlAh --group-directories-first")
  (dired-omit-files "\\.bbl$\\|\\.tex$\\|\\.xml$\\|\\.bcf$\\|\\.run$\\|\\.out$\\|\\.log$\\|\\.fdb_latexmk$\\|\\.xdv$\\|\\.fls$\\|\\.srt$")
  (large-file-warning-threshold nil)
  (dired-clean-confirm-killing-deleted-buffers nil)
  (dired-no-confirm 'byte-compile load chgrp chmod chown copy move hardlink symlink shell touch)
  (image-dired-thumb-size 150)
  (auto-revert-verbose 'nil)
  :init
  (require 'dired-x)
  (defun dired-next ()
    (interactive)
    (when (not (eq (line-number-at-pos) (line-number-at-pos (- (point-max) 1))))
	    (next-line)))
  (defun dired-prev ()
    (interactive)
    (when (not (eq (line-number-at-pos) 2))
	    (previous-line)))
  (defun dired-up-directory ()
    "`dired-up-directory' in same buffer."
    (interactive)
    (find-alternate-file ".."))
  (defun dired-find-file ()
    "Replace current dired buffer with file buffer or open it externally if needed."
    (interactive)
    (let* ((path (dired-get-file-for-visit))
	         (file (file-name-nondirectory path))
	         (name (file-name-base file))
	         (ext (file-name-extension file)))
	    (pcase ext
	      ((or "opus" "ogg" "mp3" "mp4" "mov" "mpg" "mpeg"
	           "xlsx" "pdf" "epub" "djvu" "ps"
	           "gif" "png" "jpg" "jpeg" "webp" "svg")
	       (message "Opening %s externally" file)
	       (call-process-shell-command (format "xdg-open \"%s\" &" path)))
	      ((or "bz" "bz2" "tbz" "tbz2" "gz" "tgz" "xz" "tar")
	       (progn (message "Extracting %s..." file)
		            (call-process-shell-command (format "tar xfv \"%s\" &" path))))
	      ((or "docx")
	       (progn (message "Converting %s..." file)
		            (call-process-shell-command (format "pandoc \"%s\" -o \"%s\" &" path (concat name ".odt")))))
	      ((or "zip" "7z" "rar")
	       (progn (message "Extracting %s..." file)
		            (call-process-shell-command (format "unzip \"%s\" -d \"%s\" &" path (concat name "/")))))
	      (_ (find-alternate-file path)))))
  (defun dired-copy-path ()
    "Copy selected file/directory path."
    (interactive)
    (let ((path (dired-get-file-for-visit)))
	    (kill-new path)
	    (message "Copied path - %s" path)))
  (defun sudo-find-file (file-name)
    "Like find file, but opens the file as root."
    (interactive "FSudo find: ")
    (let ((tramp-file-name (format "/sudo:root@%s:%s" system-name (expand-file-name file-name))))
	    (find-file tramp-file-name)
	    (recentf-add-file tramp-file-name)))
  (defun sudo-edit-file ()
    "Edit current file as root."
    (interactive)
    (let ((tramp-file-name (format "/sudo:root@%s:%s" system-name (expand-file-name buffer-file-name))))
	    (find-file tramp-file-name)
	    (recentf-add-file tramp-file-name)))
  :general
  (:states 'normal
           :keymaps 'dired-mode-map
           "j" 'dired-next
           "k" 'dired-prev
           ;;-- NAVIGATION
           "u"   'evil-scroll-up
           "d"   'evil-scroll-down
           "h"   'dired-up-directory
           "l"   'dired-find-file
           "C-l" 'dired-find-file-other-window
           ;;-- MARKING
           "f"   'dired-mark
           "n"   'dired-unmark
           "t"   'dired-toggle-marks
           ;;-- INTERFACE
           "s"   'dired-hide-dotfiles-mode
           "C-h" 'dired-hide-details-mode
           ;;-- CREATE
           "c d" 'dired-create-directory
           "c f" 'dired-create-empty-file
           ;;-- COPY/MOVE
           "o"   'dired-do-hardlink
           "y"   'dired-ranger-copy
           "Y"   'dired-do-copy
           "C-y" 'dired-copy-path
           "x"   'dired-ranger-move
           ;;-- PASTE
           "p"   'dired-ranger-paste
           ;;-- DELETE
           "C-d" 'dired-do-delete
           ;;-- EXTERNAL
           "a"   'wdired-change-to-wdired-mode
           "i"   'wdired-change-to-wdired-mode
           "M"   'dired-chmod
           "O"   'dired-chown
           "ed"  'epa-dired-do-decrypt
           "ee"  'epa-dired-do-encrypt
           "z"   'dired-do-compress))

(use-package org
  :straight org-appear
  :straight '(ox-typst :host github :repo "jmpunkt/ox-typst")
  :hook (org-mode . org-appear-mode)
  :hook (org-mode . org-indent-mode)
  :config
  (font-lock-add-keywords
   'org-mode
   '(;; Replace lists "-" and "+" with unicode characters
     ("^ *\\([-]\\) " (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))
     ("^ *\\([+]\\) " (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))
     ;; Turn page break in pretty horizontal lines
     ("^-\\{5,\\}$" 0 '(face org-horizontal-rule display (space :width text)))
     ;; Hide heading leading stars
     ("^\\*+ " (0 (prog1 nil (put-text-property (match-beginning 0)
						                                    (match-end 0) 'face
						                                    (list :foreground (face-attribute 'default :background))))))))
  (defface org-horizontal-rule
    '((default :inherit org-hide) (((background light)) :strike-through "gray70") (t :strike-through "gray30"))
    "Face used for horizontal ruler.")
  (dolist (languages
           '(ob-shell ob-emacs-lisp ob-lua ob-gnuplot ox-typst ob-python
                      ob-dot ob-calc org-tempo))
    (require languages))
  (add-to-list 'org-babel-after-execute-hook 'org-redisplay-inline-images)
  :custom
  (org-confirm-babel-evaluate nil)
  (org-link-elisp-confirm-function nil)
  (org-M-RET-may-split-line nil)
  (org-insert-heading-respect-content t)
  (org-return-follows-link t)
  (org-mouse-1-follows-link nil)
  ;; Source block
  (org-src-preserve-indentation nil)
  (org-src-tab-acts-natively nil)
  (org-src-window-setup 'current-window)
  ;; Appearance
  (org-auto-align-tags t)
  (org-blank-before-new-entry nil)
  (org-fontify-quote-and-verse-blocks nil)
  (org-fontify-whole-heading-line nil)
  (org-fontify-whole-block-delimiter-line nil)
  (org-edit-src-content-indentation 0)
  (org-odt-fontify-srcblocks nil)
  (org-hide-leading-stars nil)
  (org-cycle-separator-lines 0)
  (org-descriptive-links t)
  (org-adapt-indentation t)
  (org-cycle-separator-lines 0)
  (org-imenu-depth 3)
  (org-log-done 'time)
  (org-startup-truncated t)
  (org-startup-folded 'content)
  (org-support-shift-select 'always)
  (org-hide-emphasis-markers t)
  (org-todo-window-setup 'current-window)
  (org-log-into-drawer t)
  (org-todo-keywords '((sequence "TODO(t)" "RECALL(r)" "|" "DONE(d)" "WAIT(w)" "CANCELLED(c)" )))
  ;; Images
  (image-use-external-converter t)
  (image-converter 'imagemagick)
  (preview-image-type 'svg)
  (org-startup-with-inline-images t)
  (org-image-actual-width '(500))
  ;; Agenda
  (org-agenda-sorting-strategy '(scheduled-up))
  (org-agenda-include-deadlines t)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-unavailable-files t)
  (org-agenda-window-setup 'current-window)
  (org-agenda-start-on-weekday nil)
  (org-agenda-span 'day)
  (org-agenda-inhibit-startup t))

(savehist-mode 1)
(recentf-mode 1)
