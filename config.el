;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "WJain Young"
      user-mail-address "jain_y@126.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
(setq org-roam-directory "~/org-roam")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq lsp-java-vmargs
      (list
       "-noverify"
       "-Xmx1G"
       "-XX:+UseG1GC"
       "-XX:+UseStringDeduplication"
       "-javaagent:E:/msys64/home/jain.y/.doom.d/plugin/lombok-1.18.22.jar"))


(set-selection-coding-system
 (if (eq system-type 'windows-nt)
     'utf-16-le  ;; https://rufflewind.com/2014-07-20/pasting-unicode-in-emacs-on-windows
   'utf-8))

(after! org
  (progn
    ;; org-capture-templates
    (setq org-capture-templates
          '(("t" "Todo" entry (file+headline "~/Documents/TODO/gtd.org" "Tasks")
             "* TODO %?\n  %i" :prepend t)

            ("j" "Journal" entry (file+datetree "~/Documents/notes/src/notes/journal.org" "Journal")
             "* %?\nEntered on %U\n %i\n %a" :prepend t :empty-lines 1)

            ("w" "WorkNote" entry (file+headline "~/Documents/notes/src/notes/worknotes.org" "WorkNotes")
             "* %U %?\n\n  %i" :prepend t :empty-lines 1)

            ("l" "LifeNote" entry (file+headline "~/Documents/notes/src/notes/liftnotes.org" "LiftNotes")
             "* %U %?\n\n  %i" :prepend t :empty-lines 1)

            ("s" "StudyNote" entry (file+headline "~/Documents/notes/src/notes/studynotes.org" "StudyNotes")
             "* %U %?\n\n  %i" :prepend t :empty-lines 1)

            ("p" "Protocol" entry (file+headline "~/Documents/notes/src/notes/webnotes.org" "Inbox")
             "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")

            ("L" "Protocol Link" entry (file+headline "~/Documents/notes/src/notes/webnotes.org" "Inbox")
             "* %? [[%:link][%:description]] \nCaptured On: %U")))

    (setq org-agenda-files (list  "~/Documents/TODO/gtd.org"
                                  "~/Documents/notes/src/notes/liftnotes.org"
                                  "~/Documents/notes/src/notes/journal.org"
                                  "~/Documents/notes/src/notes/worknotes.org"
                                  "~/Documents/notes/src/notes/studynotes.org"))

    (setq org-todo-keywords
          (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                  (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))

    (setq org-roam-capture-ref-templates '(("l" "web" plain "%i\n%?"
                                            :target (file+head "%<%Y%m%d>-${slug}.org"
                                                               "#+title: ${title}")
                                            :unnarrowed t)))
    )
  )



(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! gptel
  :config
  (setq gptel-model "moonshot-v1-8k")
  (setq gptel-default-mode 'org-mode)
  (setq gptel-backend
        (gptel-make-openai "Moonshot"
          :key 'gptel-api-key
          :models '("moonshot-v1-8k"
                    "moonshot-v1-32k"
                    "moonshot-v1-128k")
          :host "api.moonshot.cn")))

(use-package! eaf
  :commands (eaf-open-browser eaf-open find-file)  :init
  :custom
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
  (use-package! ctable)
  (use-package! deferred)
  (use-package! epc)(require 'eaf-file-manager)

  (require 'eaf-browser)
  ;;(require 'eaf-git)
  ;;(require 'eaf-markdown-previewer)
  ;;(require 'eaf-terminal)
  ;;(require 'eaf-pdf-viewer)
  ;;(require 'eaf-mindmap)
  ;;(require 'eaf-org-previewer)
  ;;(require 'eaf-file-manager)
  (when (display-graphic-p)
    (require 'eaf-all-the-icons))

  (define-key key-translation-map (kbd "SPC")
              (lambda (prompt)
                (if (derived-mode-p 'eaf-mode)
                    (pcase eaf--buffer-app-name
                      ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
                                     (kbd "SPC")
                                   (kbd eaf-evil-leader-key)))
                      ("pdf-viewer" (kbd eaf-evil-leader-key))
                      ("image-viewer" (kbd eaf-evil-leader-key))
                      (_  (kbd "SPC")))
                  (kbd "SPC")))))

(use-package! rime
  :config
  (setq default-input-method "rime")
  ;; (setq rime-show-candidate 'posframe)   ;; 使用 posfarme 显示
  (setq rime-show-candidate 'minibuffer) ;; 使用minibuffer 显示 体验最好 不卡
  ;; (setq rime-show-candidate 'popup) ;; 使用popup 显示  卡爆了
  ;; (setq rime-show-candidate 'message)  ;; 使用 message 显示  体验不好  有Bug 上屏不会马上显示
  (set-face-attribute 'rime-default-face       nil :foreground "#d830f2" :background "#f1f1f1") ;; 候选字的样式
  (set-face-attribute 'rime-code-face       nil :foreground "#1bd672" :background "#f1f1f1") ;;  输入的编码的样式
  (set-face-attribute 'rime-candidate-num-face       nil :foreground "#565656" :background "#f1f1f1") ;; 候选序号样式
  (set-face-attribute 'rime-comment-face       nil :foreground "#565656" :background "#f1f1f1") ;; 编码提示颜色

  (setq rime-posframe-properties
        (list :background-color "#333333"
              :foreground-color "#dcdccc"
              :font "Fira Code-18"
              :internal-border-width 10))
  (setq evil-insert-state-message nil)   ;; 在 evil 下进入编辑模式不显示  -- INSERT -- 否第一个打的字将不能正确显示在minibuffer
  (when (or *is-linux* *is-mac*)
    (setq rime-user-data-dir "~/.doom.d/rime")   ;; RIME 的个人输入法方案的配置文件
    (setq rime-librime-root "~/.config/emacs/librime/dist"))
  (when *is-windows*
    (setq rime-user-data-dir "~/.doom.d/rime")   ;; RIME 的个人输入法方案的配置文件
    (cond ((file-exists-p "E:\\msys64\\mingw64\\share\\rime-data")
           (setq rime-share-data-dir "E:\\msys64\\mingw64\\share\\rime-data"))  ;; 这个一定要指定对 不然不能把 rime-user-data-dir 配置的输入法成功编译
          ))  ;; 这个一定要指定对 不然不能把 rime-user-data-dir 配置的输入法成功编译

  (setq flycheck-check-syntax-automatically '(mode-enabled save))  ;; 配置flycheck 仅在模式使能和保存的时候进行check
  (defun my-set-rime-idle-flag ()
    ;; (message "rime idle")
    (setq my-rime-idle-p t))
  (advice-add #'rime--escape :after #'my-set-rime-idle-flag)

  (defun my/org-in-src-block-p()
    (interactive)
    (let* (first-search-result (in-src-block-flag nil) (cur-point (point)))
      (save-excursion
        (end-of-line)
        ;; #+begin_src verilog
        ;; #+end_src
        (when (re-search-backward "\\(#\\+begin_src\\|#\\+BEGIN_SRC\\|#\\+end_src\\|#\\+END_SRC\\)" nil t)
          (setq first-search-result (match-string 1))
          (unless (or (string= first-search-result "#+end_src") (string= first-search-result "#+END_SRC"))
            ;; 前面有 begin_src 如果后面有 end_src 则在 src_block 中
            (goto-char cur-point)
            (if (re-search-forward "\\(#\\+begin_src\\|#\\+BEGIN_SRC\\|#\\+end_src\\|#\\+END_SRC\\)" nil t)
                (progn
                  (setq first-search-result (match-string 1))
                  ;; (message " first-search-result : %s" first-search-result)
                  (unless (or (string= first-search-result "#+begin_src") (string= first-search-result "#+BEGIN_SRC"))
                    ;; 往后找找到end_src , 符合预期 认为在src_block 里
                    ;; (message "in src block")
                    (setq in-src-block-flag t)
                    ))))))
      in-src-block-flag))
  
  (defun my/rime-predicate-org-in-src-block-p ()
    "Whether point is in an org-mode's code source block."
    (and (derived-mode-p 'org-mode)
         (my/org-in-src-block-p)))

  (setq rime-disable-predicates
        '(rime-predicate-evil-mode-p ;; evil 模式的非编辑模式下使用英文
          rime-predicate-after-alphabet-char-p ;; 在英文字符串之后（必须为以字母开头的英文字符串）
          rime-predicate-after-ascii-char-p    ;; 任意英文字符后
          rime-predicate-current-input-punctuation-p ;; 当要输入的是符号时
          ;; rime-predicate-org-in-src-block-p          ;; 当在 org mode 里的代码块时 有BUG
          my/rime-predicate-org-in-src-block-p       ;; 当在 org mode 里的代码块时 时用英文 修复了原始的 rime-predicate-org-in-src-block-p 识别错误的BUG
          rime-predicate-current-uppercase-letter-p ;; 将要输入的为大写字母时
          rime-predicate-punctuation-line-begin-p   ;; 行首要输入符号时
          rime-predicate-hydra-p                    ;; 如果激活了一个 hydra keymap
          ;; rime-predicate-punctuation-after-space-cc-p ;; 当要在中文字符且有空格之后输入符号时
          rime-predicate-tex-math-or-command-p        ;; 在 (La)TeX 数学环境中或者输入 (La)TeX 命令时
          rime-predicate-in-code-string-p           ;; 在代码的字符串中，不含注释的字符串
          rime-predicate-prog-in-code-p))) ;; 在 prog-mode 和 conf-mode 中除了注释和引号内字符串之外的区域
