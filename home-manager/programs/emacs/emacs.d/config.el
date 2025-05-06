(setq inhibit-startup-screen t)
(setq auto-save-default nil)
(setq fringe-mode 0)
(setq make-backup-files nil)
(require 'olivetti)
(add-hook 'org-mode-hook 'olivetti-mode)
(setq olivetti-body-width 80)
(require 'evil)
(evil-mode 1)
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

(defun my-toggle-org-modern ()
  "Toggle org-modern mode based on Evil mode state, only in Org buffers"
  (when (eq major-mode 'org-mode)
    (if (eq evil-state 'insert)
        (org-modern-mode -1)
      (org-modern-mode 1))))

(add-hook 'evil-insert-state-entry-hook 'my-toggle-org-modern)
(add-hook 'evil-normal-state-entry-hook 'my-toggle-org-modern)
(add-hook 'evil-visual-State-entry-hook 'my-toggle-org-modern)

(add-hook 'olivetti-mode-hook
          (lambda ()
            (set-face-attribute 'default nil :height 120)))
(defun my-text-scale-adjust ()
  (let ((width (window-width)))
    (if (> width 160)
        (text-scale-set 2.3)
      (if (> width 120)
          (text-scale-set 1.8)
        (text-scale-set 1.3)))))
(add-hook 'window-configuration-change-hook 'my-text-scale-adjust)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(modus-themes-load-theme 'modus-operandi-tinted)

;; Choose some fonts
 (set-face-attribute 'default nil :family "Iosevka")
 (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
 (set-face-attribute 'org-modern-symbol nil :family "Iosevka")

;; Add frame borders and window dividers
(modify-all-frames-parameters
 '((right-divider-width . 40)
   (internal-border-width . 40)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "◀── now ─────────────────────────────────────────────────")

;; Ellipsis styling
(setq org-ellipsis "…")
(set-face-attribute 'org-ellipsis nil :inherit 'default :box nil)

;; credit: yorickvP on Github
(setq wl-copy-process nil)
(defun wl-copy (text)
(setq wl-copy-process (make-process :name "wl-copy"
                                    :buffer nil
                                    :command '("wl-copy" "-f" "-n")
                                    :connection-type 'pipe
                                    :noquery t))
(process-send-string wl-copy-process text)
(process-send-eof wl-copy-process))
(defun wl-paste ()
(if (and wl-copy-process (process-live-p wl-copy-process))
    nil ; should return nil if we're the current paste owner
    (shell-command-to-string "wl-paste -n | tr -d \r")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)
