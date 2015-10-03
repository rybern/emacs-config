(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(global-set-key (kbd "C-x C-.") 'end-of-buffer)
(global-set-key (kbd "C-x C-,") 'beginning-of-buffer)
(global-set-key (kbd "C-.") 'paredit-forward)
(global-set-key (kbd "C-,") 'paredit-backward)
(global-set-key (kbd "C-<return>") 'newline-and-indent)



;; Custom navigation bindings

;(add-to-list 'load-path "/home/ryan/.emacs.d/libraries/structured-haskell-mode/elisp")
;(require 'shm)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)

(add-hook 'inferior-haskell-mode-hook
          (lambda()
            (local-unset-key (kbd "C-M-l"))
            (local-unset-key (kbd "C-s"))
            (local-unset-key (kbd "C-r"))
            (local-set-key (kbd "C-s") 'comint-previous-input)
            (local-set-key (kbd "C-r") 'comint-next-input)))


;(eval-after-load 'shell
;  '(define-key shell-mode-map (kbd "C-M-l") nil))


;; Custom Minor Mode
(define-minor-mode nav-mode
  "Custom navigation definitions, mostly using hjkl."
  nil
  ;; The indicator for the mode line.
  " CustomNavMode"
  ;; The minor mode keymap
  `(
    (,(kbd "C-j") . previous-line)
    (,(kbd "C-k") . next-line)
    (,(kbd "C-l") . forward-char)
    (,(kbd "C-h") . backward-char)
    (,(kbd "C-M-h") . backward-word)
    (,(kbd "C-M-l") . forward-word)
    (,(kbd "C-M-k") . forward-paragraph)
    (,(kbd "C-M-j") . backward-paragraph)
    (,(kbd "M-k") . scroll-up)
    (,(kbd "M-j") . scroll-down)
    (,(kbd "M-l") . forward-sexp)
    (,(kbd "M-h") . backward-sexp)
    
    (,(kbd "C-f") . kill-line)
    (,(kbd "M-i") . imenu)
    (,(kbd "M-f") . recenter)
    
    )

  :global 1
  :after-hook (raise-minor-mode-map-alist 'nav-mode))

(load "~/.emacs.d/modules/minor-mode-hack.el")
(require 'minor-mode-hack)
;(add-hook nav-mode-hook'
;          (lambda () (raise-minor-mode-map-alist 'nav-mode)))

(nav-mode)

(mapc 'global-unset-key [[up] [down] [left] [right]])



(eval-after-load 'shell
  '(define-key shell-mode-map (kbd "C-s") 'comint-previous-input))
(eval-after-load 'shell
  '(define-key shell-mode-map (kbd "C-r") 'comint-next-input))

(eval-after-load 'inferior-ess-mode
  '(define-key inferior-ess-mode-map (kbd "C-s") 'nil))
(eval-after-load 'inferior-ess-mode
  '(define-key inferior-ess-mode-map (kbd "C-r") 'nil))
(eval-after-load 'inferior-ess-mode
  '(define-key inferior-ess-mode-map (kbd "C-s") 'comint-previous-input))
(eval-after-load 'inferior-ess-mode
  '(define-key inferior-ess-mode-map (kbd "C-r") 'comint-next-input))



;(add-hook 'inferior-haskell-mode-hook
;          '(define-key inferior-haskell-mode-map (kbd "C-s")
;          'comint-previous-input))
(eval-after-load 'inferior-haskell-mode
  '(define-key inferior-haskell-mode-map (kbd "C-r")
  nil))
(eval-after-load 'inferior-haskell-mode
  '(define-key inferior-haskell-mode-map (kbd "C-r")
  'comint-next-input))

                                        ; end



(load "~/.emacs.d/user.el")
(load "~/.emacs.d/modules/filladapt.el")
(load "~/.emacs.d/modules/sos.el")
(load "~/.emacs.d/modules/julia-mode.el")

(load "~/.emacs.d/modules/julia-repl.el")
(setq julia-basic-repl-path "/usr/bin/julia")

(add-hook 'clojure-mode-hook 'cider-jack-in)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""

                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" default)))
 '(delete-selection-mode t)
 '(global-subword-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-doc turn-on-haskell-indent turn-on-haskell-indentation)) t)
 '(next-screen-context-lines 3))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Adds newline for down-navigation, like C-n
(setq next-line-add-newlines t)

;; Add octave support
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
(cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Autocomplete for octave
(add-hook 'octave-mode-hook
(lambda ()
(abbrev-mode 1)
(auto-fill-mode 1)
(if (eq window-system 'x)
(font-lock-mode 1))))
