;; 참고 : http://goo.gl/15KtG (clojure.or.kr)

; theme
(load-file "~/.emacs.d/tomorrow-theme/GNU Emacs/color-theme-tomorrow.el")
(add-to-list 'custom-theme-load-path "~/.emacs.d/tomorrow-theme/GNU Emacs")
(load-theme 'tomorrow-night t)

(setq is-mac (eq system-type 'darwin))

; font
(when is-mac
      (set-face-attribute 'default nil :height 140)
      (set-fontset-font (frame-parameter nil 'font)
			'hangul
			'("Apple SD Gothic Neo" . "ios10646-1")))

; 한글
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)

; startup-message 안 보기
(setq inhibit-startup-message t)
; *scratch* 버퍼 깨끗하게 시작하기
(setq initial-scratch-message nil)
; 컬러 넘버 보기
(setq column-number-mode t)

; 괄호 하이라이팅
(setq show-paren-display 0
     show-paren-style 'expression)
(show-paren-mode t)

; syntax highlighting on
(global-font-lock-mode t)

; tab -> space
(setq indent-tabs-mode nil)

(tool-bar-mode -1)

; evil http://www.emacswiki.org/emacs-en/Evil
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

; clojure-mode https://github.com/technomancy/clojure-mode
(add-to-list 'load-path' "~/.emacs.d/clojure-mode")
(require 'clojure-mode)

; nrepl.el https://github.com/kingtim/nrepl.el
(add-to-list 'load-path' "~/.emacs.d/nrepl.el")
(require 'nrepl)
