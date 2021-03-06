(setq windows? (eq system-type 'windows-nt))
(setq mac? (eq system-type 'darwin))

(when mac?
  ;; font
  (set-face-attribute 'default nil :height 150)
  (set-fontset-font (frame-parameter nil 'font)
                    'hangul
                    '("Apple SD Gothic Neo" . "ios10646-1"))
  (setq-default line-spacing 1))

(defun available-font? (font) (member font (font-family-list)))
(when windows?
  ;; font
  (when (available-font? "DejaVu Sans Mono")
    (set-face-attribute 'default nil
                        :font "Dejavu Sans Mono-11"
                        :weight `normal)
    (setq-default line-spacing 3)))

;; 한글
(set-language-environment "Korean")
;; 한글 환경에서는 cp949 인코딩이 디폴트이기 때문.
(prefer-coding-system 'utf-8)

;; startup-message 안 보기
(setq inhibit-startup-message t)
;; *scratch* 버퍼 깨끗하게 시작하기
(setq initial-scratch-message nil)
;; 선택 텍스트를 타이핑할 때, 삭제
(delete-selection-mode t)
;; 라인 넘버 보기
(global-linum-mode t)
;; 컬럼 넘버 보기
(setq column-number-mode t)
;; word-wrap
(global-visual-line-mode t)
;; 커서가 있는 라인 하이라이트
(global-hl-line-mode t)

;; syntax highlighting on
(global-font-lock-mode t)

;; tab -> space
(setq indent-tabs-mode nil)

;; find-file, switch-to-buffer에서 file 이름을 보여주는 mode
(ido-mode t)

(when (fboundp 'menu-bar-mode) (menu-bar-mode t))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; 거슬리는 경고 소리를 끈다.
(setq ring-bell-function 'ignore)

;; 마우스 꺼져. 타이핑을 시작하면 구석으로 마우스 커서를 치운다.
(mouse-avoidance-mode 'banish)

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'sh 'shell)
(defalias 'list-buffers 'ibuffer)

;; M-x - C-xC-m
(global-set-key "\C-x\C-m" 'execute-extended-command)

;;; packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
(package-initialize)

(defvar ohyecloudy/packages '(clojure-mode
                              cider
                              undo-tree
                              paredit
                              evil
                              evil-matchit
                              auto-complete
                              ac-cider
                              highlight-parentheses
                              edit-server
                              markdown-mode
                              yaml-mode
                              solarized-theme
                              pretty-mode
                              magit))

(dolist (pkg ohyecloudy/packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

(add-to-list 'load-path "~/.emacs.d/config")
(load "platform.el")
(load "clojure.el")
(load "backup.el")
(load "vim.el")
(load "ws.el")

;;; auto-complete https://github.com/auto-complete/auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;; highlight-parentheses https://github.com/nschum/highlight-parentheses.el
(require 'highlight-parentheses)
(setq hl-paren-colors nil)
(setq hl-paren-background-colors '("gray"))
;; global로 highlight-parentheses minor mode를 활성화 http://goo.gl/ig5YuY 참고
(define-global-minor-mode global-highlight-parentheses-minor-mode
  highlight-parentheses-mode highlight-parentheses-mode)
(global-highlight-parentheses-minor-mode t)

(setq show-paren-display 0)
(show-paren-mode t)

;;; emacs-server
(require 'server)
(server-start)

;;; edit-server http://www.emacswiki.org/emacs/Edit_with_Emacs
(require 'edit-server)
(edit-server-start)
(setq edit-server-new-frame nil)

;;; solarized-emacs
;;; https://github.com/bbatsov/solarized-emacs
(load-theme 'solarized-light 'NO-CONFIRM)

;;; markdown-mode http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            ;; clojure cider mode에서 쓰는 키와 맞춘다. C-M-x는 입력이 괴로움
            (define-key emacs-lisp-mode-map "\C-c\C-c" 'eval-defun)))

;;; lisp-interaction-mode
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            ;; clojure cider mode에서 쓰는 키와 맞춘다. C-M-x는 입력이 괴로움
            (define-key lisp-interaction-mode-map "\C-c\C-c" 'eval-defun)))

;;; shell
(when windows?
  (let ((bash-dir "C:/Program Files (x86)/Git/bin"))
    (setq explicit-shell-file-name (concat bash-dir "/bash.exe"))
    (setq shell-file-name explicit-shell-file-name)
    (add-to-list 'exec-path bash-dir)
    (setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
    (setenv "SHELL" explicit-shell-file-name)
    (setenv "PATH" (concat bash-dir path-separator (getenv "PATH")))))

;; shell mode hook
(add-hook 'shell-mode-hook
          (lambda ()
            ;; evil-scroll-up과 충돌
            (define-key shell-mode-map "\C-d" nil)))

;;; http://robots.thoughtbot.com/no-newline-at-end-of-file
(setq require-final-newline t)

;;; title bar
(setq frame-title-format "%b")

;;; pretty-mode
(add-hook 'prog-mode-hook 'turn-on-pretty-mode)
