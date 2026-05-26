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
;; - `doom-symbol-font' -- for symbols
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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
(setq org-roam-directory "~/org-roam")

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
          '( (sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
             (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@!)"))))

  (setq org-roam-capture-ref-templates '( ("l" "web" plain "%i\n%?"
                                           :target (file+head "%<%Y%m%d>-${slug}.org"
                                                              "#+title: ${title}")
                                           :unnarrowed t)
                                          ("r" "ref" plain "%i\n%?"
                                           :target (file+head "%<%Y%m%d>-${slug}.org"
                                                              "#+title: ${title}\n\n${body}")
                                           :unnarrowed t))))

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

;; (use-package! eaf
;;   :commands (eaf-open-browser eaf-open find-file)  :init
;;   :custom
;;   (eaf-browser-continue-where-left-off t)
;;   (eaf-browser-enable-adblocker t)
;;   ;; (browse-url-browser-function 'eaf-open-browser)
;;   :config
;;   (use-package! ctable)
;;   (use-package! deferred)
;;   (use-package! epc)(require 'eaf-file-manager)
;; 
;;   ;; (require 'eaf-browser)
;;   ;;(require 'eaf-git)
;;   ;;(require 'eaf-markdown-previewer)
;;   ;;(require 'eaf-terminal)
;;   ;;(require 'eaf-pdf-viewer)
;;   ;;(require 'eaf-mindmap)
;;   ;;(require 'eaf-org-previewer)
;;   ;;(require 'eaf-file-manager)
;;   (when (display-graphic-p)
;;     (require 'eaf-all-the-icons))
;; 
;;   (define-key key-translation-map (kbd "SPC")
;;               (lambda (prompt)
;;                 (if (derived-mode-p 'eaf-mode)
;;                     (pcase eaf--buffer-app-name
;;                       ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
;;                                      (kbd "SPC")
;;                                    (kbd eaf-evil-leader-key)))
;;                       ("pdf-viewer" (kbd eaf-evil-leader-key))
;;                       ("image-viewer" (kbd eaf-evil-leader-key))
;;                       (_  (kbd "SPC")))
;;                   (kbd "SPC")))))

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
  (when (or IS-LINUX IS-MAC)
    (setq rime-user-data-dir "~/.config/rime")   ;; RIME 的个人输入法方案的配置文件
    (setq rime-librime-root "~/.config/emacs/librime/dist"))
  (when IS-WINDOWS
    (setq rime-user-data-dir "~/.config/rime")   ;; RIME 的个人输入法方案的配置文件
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


(use-package! impatient-mode
  :after web-mode
  )

(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  :config
  ;; Set API_KEY in .bashrc, that will automatically picked up by aider or in elisp
  ;; (setenv "ANTHROPIC_API_KEY" "sk-...")
  ;; defun my-get-openrouter-api-key yourself elsewhere for security reasons
  ;; (setenv "OPENROUTER_API_KEY" (my-get-openrouter-api-key))
  ;; (setenv "OLLAMA_API_BASE" "http://192.168.5.241:11434")
  :custom
  ;; See the Configuration section below
  (aidermacs-default-chat-mode 'architect)
  ;; (aidermacs-default-model "ollama/qwen3:30b-a3b-instruct-2507-q4_K_M")
  ;; (aidermacs-editor-model "ollama/qwen3-coder:30b")
  )

(use-package! gptel
  :config
  (setq gptel-default-mode 'org-mode)

  ;; OpenRouter offers an OpenAI compatible API
  (setq gptel--backend-openrouter
        (gptel-make-openai "OpenRouter"               ;Any name you want
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key 'gptel-api-key-from-auth-source
          :models '(x-ai/grok-4.1-fast
                    kwaipilot/kat-coder-pro:free
                    nvidia/nemotron-nano-12b-v2-vl:free
                    alibaba/tongyi-deepresearch-30b-a3b:free
                    meituan/longcat-flash-chat:free
                    openai/gpt-oss-20b:free
                    z-ai/glm-4.5-air:free
                    qwen/qwen3-coder:free
                    moonshotai/kimi-k2:free)))

  ;; Moonshot
  (setq gptel--backend-moonshot
        (gptel-make-openai "Moonshot"
          :host "api.moonshot.cn"
          :endpoint "/v1/chat/completions"
          :key 'gptel-api-key-from-auth-source
          :models '("moonshot-v1-8k"
                    "moonshot-v1-32k"
                    "moonshot-v1-128k")))

  ;; ChatGLM
  (defun gptel--backend-chatglm-header ()
    (let ((token (gptel-api-key-from-auth-source)))
      `(("Authorization" .  ,(concat "Bearer " token)))))
  (setq gptel--backend-chatglm
        (gptel-make-openai "ChatGLM"
          :host "open.bigmodel.cn"
          :endpoint "/api/paas/v4/chat/completions"
          :models '("glm-4.7-flash"
                    "glm-4.6v-flash")
          :stream nil
          :header #'gptel--backend-chatglm-header))

  ;; KatCode
  (setq gptel--backend-katcode
        (gptel-make-openai "KatCode"
          :host "wanqing.streamlakeapi.com"
          :endpoint "/api/gateway/v1/endpoints/chat/completions"
          :key 'gptel-api-key-from-auth-source
          :models '("ep-tk4wbs-1767076969907658453"  ;; KAT-Coder-Pro-V1
                    "ep-xc4wfb-1767076969893416310"  ;; KAT-Coder-Air-V1
                    )))

  ;; LongCat
  (setq gptel--backend-longcat
        (gptel-make-openai "LongCat"
          :host "api.longcat.chat"
          :endpoint "/openai/v1/chat/completions"
          :key 'gptel-api-key-from-auth-source
          :models '("LongCat-Flash-Chat"
                    "LongCat-Flash-Thinking")))

  ;; Ollama
  (setq gptel--backend-ollama-other
        (gptel-make-ollama "Ollama"
          :host "other.ollama.xyz:11434"
          :stream t
          :models '("qwen3:32b"
                    "qwen3-coder:30b"
                    "gpt-oss:20b"
                    )))

  (setq gptel--backend-ollama-cloud
        (gptel-make-ollama "Ollama"
          :host "cloud.ollama.xyz:11434"
          :stream t
          :models '("deepseek-v3.1:671b-cloud"
                    "gpt-oss:20b-cloud"
                    "gpt-oss:120b-cloud"
                    "kimi-k2:1t-cloud"
                    "qwen3-coder:480b-cloud"
                    "glm-4.6:cloud"
                    "minimax-m2:cloud"
                    )))

  (setq-default gptel-backend gptel--backend-chatglm
                gptel-model "glm-4.5-flash")
  )

;; Superchat 配置
(use-package! superchat
  :after gptel
  :commands (superchat-start superchat-new-chat)  ; 确保命令在加载时可用
  :config
  (setq superchat-mode "ollama")
  (setq superchat-default-model "qwen3:32b")
  (setq superchat-lang "中文")
  (setq superchat-data-directory "~/Documents/notes/superchat/")
  (setq superchat-default-directories '"~/Documents/notes")
  (setq superchat-port 8080)

  ;; 定义后端切换函数
  (defun my/gptel-set-openrouter ()
    "切换到 openrouter 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-openrouter
                  gptel-model "x-ai/grok-4.1-fast")
    (message "Switched to OpenRouter backend"))

  (defun my/gptel-set-moonshot ()
    "切换到 moonshot 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-moonshot
                  gptel-model "moonshot-v1-8k")
    (message "Switched to Moonshot backend"))

  (defun my/gptel-set-chatglm ()
    "切换到 ChatGLM 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-chatglm
                  gptel-model "glm-4.7-flash")
    (message "Switched to ChatGLM backend"))

  (defun my/gptel-set-katcode ()
    "切换到 katcode 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-katcode
                  gptel-model "ep-xc4wfb-1767076969893416310")
    (message "Switched to katcode backend"))

  (defun my/gptel-set-longcat ()
    "切换到 longcat 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-longcat
                  gptel-model "LongCat-Flash-Thinking")
    (message "Switched to longcat backend"))

  (defun my/gptel-set-ollama-other ()
    "切换到 Ollama other 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-ollama-other
                  gptel-model "gpt-oss:20b")
    (message "Switched to Ollama-other backend"))

  (defun my/gptel-set-ollama-cloud ()
    "切换到 Ollama cloude 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-ollama-cloud
                  gptel-model "gpt-oss:20b-cloud")
    (message "Switched to Ollama-cloud backend"))

  (defun my/gptel-set-packy-proxy ()
    "切换到 Ollama cloude 后端"
    (interactive)
    (setq-default gptel-backend gptel--backend-packy-proxy
                  gptel-model "claude-haiku-4-5-20251001")
    (message "Switched to packy backend"))


  ;; 快捷键绑定
  (map! :leader
        :prefix ("x" . "AI")
        :desc "Superchat start" "s" #'superchat
        :desc "Switch to OpenRouter" "r" #'my/gptel-set-openrouter
        :desc "Switch to Moonshot" "m" #'my/gptel-set-moonshot
        :desc "Switch to ChatGLM" "c" #'my/gptel-set-chatglm
        :desc "Switch to KatCode" "k" #'my/gptel-set-katcode
        :desc "Switch to LongCat" "L" #'my/gptel-set-longcat
        :desc "Switch to Ollama other" "O" #'my/gptel-set-ollama-other
        :desc "Switch to Ollama cloud" "C" #'my/gptel-set-ollama-cloud
        :desc "Switch to OpenAI" "p" #'my/gptel-set-openai))

(when (modulep! :term vterm)
  (use-package! vterm
    :config
    (when (eq system-type 'windows-nt)
      (setq vterm-shell "E:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64 -i")
      (setq vterm-conpty-proxy-path "~/.doom.d/bin/conpty_proxy.exe"))
    (define-key vterm-mode-map (kbd "C-\\") nil)
    (define-key vterm-mode-map (kbd "C-\\") #'toggle-input-method)
    (when (modulep! :editor evil)
      (evil-define-key '(normal insert) vterm-mode-map (kbd "C-\\") #'toggle-input-method))))

(use-package! eca
  :config
  (setq eca-extra-args '("--verbose" "--log-level" "debug")))

(defvar my/fleet-role-alist
  '((qwen     . "蓝队-主笔")
    (opencode . "蓝队-协作者")
    (gemini   . "红队-评审")
     (claude   . "红队-审查"))
  "角色映射：identifier -> 描述")

(defun my/agent-buffer-content (buf)
  "从 BUF 中提取文本内容，跳过前导 prompt 行。"
  (when (bufferp buf)
    (with-current-buffer buf
      (let* ((str (buffer-substring-no-properties (point-min) (point-max)))
             (lines (split-string str "\n")))
        (string-join
         (cl-remove-if (lambda (l) (string-match-p "^\\(Qwen>\\|OpenCode>\\|Gemini>\\|Claude>\\|Propose>\\|Send>\\|Execute>\\|# \\)" l)) lines)
         "\n")))))

(defun my/agent-collect-red-outputs ()
  "收集所有红队 Agent buffer 的最后一段输出。"
  (let ((red-buffers '("*agent-shell: Gemini*" "*agent-shell: Claude*" "*agent-shell: OpenCode*")))
    (mapcar (lambda (name)
              (let ((buf (get-buffer name)))
                (when buf
                  (with-current-buffer buf
                    (cons name (buffer-substring-no-properties
                                (max (point-min) (- (point-max) 2000))
                                (point-max)))))))
            red-buffers)))

(defun my/agent-shell-all-sessions ()
  "返回所有活跃 agent-shell buffer 列表。"
  (cl-remove-if-not
   (lambda (b) (with-current-buffer b (derived-mode-p 'agent-shell-mode)))
   (buffer-list)))

(defun my/agent-fleet-status ()
  "一键汇总所有 Agent 的当前状态。"
  (interactive)
  (meta-agent-shell-send
   "请立即扫描所有活跃的 agent-shell 会话，给出当前的汇总进度报告，并指出是否有任何 Agent 陷入了死循环或阻塞。"))

(defun my/agent-broadcast (msg)
  "将指令广播给所有 Agent。"
  (interactive "sBroadcast Message: ")
  (dolist (buf (my/agent-shell-all-sessions))
    (with-current-buffer buf
      (agent-shell-send msg))))

(defun my/agent-role (identifier)
  "返回 Agent 的角色描述。"
  (alist-get identifier my/fleet-role-alist "未知"))

(use-package! agent-shell
  :after acp
  :config
  (require 'acp)
  (require 'agent-shell)

  (setq agent-shell-agent-configs
        (list
         (agent-shell-make-agent-config
          :identifier 'qwen
          :mode-line-name "Qwen"
          :buffer-name "Qwen"
          :shell-prompt "Qwen> "
          :shell-prompt-regexp "Qwen> "
          :client-maker
          (lambda (buffer)
            (acp-make-client
             :command "qwen"
             :command-params '("--acp")
             :context-buffer buffer
             :environment-variables
             (list (format "SILICONFLOW_API_KEY=%s"
                           (getenv "SILICONFLOW_API_KEY"))))))
         (agent-shell-make-agent-config
          :identifier 'opencode
          :mode-line-name "OpenCode"
          :buffer-name "OpenCode"
          :shell-prompt "OpenCode> "
          :shell-prompt-regexp "OpenCode> "
          :client-maker
          (lambda (buffer)
            (acp-make-client
             :command "opencode"
             :command-params '("acp")
             :context-buffer buffer)))
         (agent-shell-make-agent-config
          :identifier 'gemini
          :mode-line-name "Gemini"
          :buffer-name "Gemini"
          :shell-prompt "Gemini> "
          :shell-prompt-regexp "Gemini> "
          :client-maker
          (lambda (buffer)
            (acp-make-client
             :command "gemini"
             :command-params '("--acp")
             :context-buffer buffer)))
         (agent-shell-make-agent-config
          :identifier 'claude
          :mode-line-name "Claude"
          :buffer-name "Claude"
          :shell-prompt "Claude> "
          :shell-prompt-regexp "Claude> "
          :client-maker
          (lambda (buffer)
            (acp-make-client
             :command "claude-agent-acp"
             :command-params '()
             :context-buffer buffer
             :environment-variables
             (list (format "ANTHROPIC_API_KEY=%s"
                           (getenv "ANTHROPIC_API_KEY"))))))))
  (setq agent-shell-preferred-agent-config 'qwen
        acp-logging-enabled t))

;; agent 集群
(use-package! meta-agent-shell
  :after agent-shell
  :config
  (defun my/meta-agent-start (&optional arg buffer-name)
    "通过 `agent-shell-start' 启动，支持 meta-instruction 注入。"
    (let ((config (agent-shell--resolve-preferred-config)))
      (unless config
        (user-error "No preferred agent config. Set `agent-shell-preferred-agent-config'"))
      (when (and buffer-name (not (string= buffer-name "")))
        (plist-put config :buffer-name buffer-name))
      (let ((buf (agent-shell-start :config config)))
        (when buf (pop-to-buffer buf)))))

  (setq meta-agent-shell-heartbeat-file "~/heartbeat.org")
  (setq meta-agent-shell-start-function #'my/meta-agent-start)
  (define-key doom-leader-map "om" nil)
  (map! :leader
        (:prefix ("o m" . "meta-agent")
         :desc "Meta-agent session" "m" #'meta-agent-shell-start
         :desc "Project dispatcher" "d" #'meta-agent-shell-jump-to-dispatcher
         :desc "Start heartbeat" "h" #'meta-agent-shell-heartbeat-start
         :desc "Stop heartbeat" "H" #'meta-agent-shell-heartbeat-stop
         :desc "Send heartbeat now" "s" #'meta-agent-shell-heartbeat-send-now
         :desc "Fleet status" "f" #'my/agent-fleet-status
         :desc "Broadcast to all" "b" #'my/agent-broadcast
         :desc "STOP ALL AGENTS" "!" #'meta-agent-shell-big-red-button))

  ;; 红队协调
  (defun my/agent-redteam-review ()
    "从蓝队 buffer 提取内容，内联发送给所有红队 Agent 评审。"
    (interactive)
    (let* ((blue-names '("*agent-shell: Qwen*" "*agent-shell: OpenCode*"))
           (red-specs `(("*agent-shell: Gemini*"  . "你扮演红队评审（侧重逻辑漏洞、安全风险）。请严厉批判以下方案：\n\n")
                        ("*agent-shell: Claude*"   . "你扮演红队评审（侧重执行落地、成本效益）。请无情地找出现实中的不可行之处：\n\n")))
           (draft ""))
      ;; 收集蓝队输出
      (dolist (bn blue-names)
        (let ((buf (get-buffer bn)))
          (when buf
            (setq draft (concat draft
                         (format "===== %s =====\n" bn)
                         (my/agent-buffer-content buf) "\n\n")))))
      (if (string-blank-p draft)
          (message "没有找到蓝队 Agent buffer。请先启动蓝队（Qwen/OpenCode）并生成初稿。")
        ;; 分发给红队
        (dolist (spec red-specs)
          (let ((buf (get-buffer (car spec)))
                (prompt (cdr spec)))
            (when buf
              (with-current-buffer buf
                (agent-shell-send (concat prompt draft))))))
        (message "红队评审已启动：Gemini + Claude 正在围攻初稿。"))))

  (defun my/agent-synthesize ()
    "收集所有红队反馈，发给蓝队主笔做综合修订，生成终稿。"
    (interactive)
    (let* ((blue-buf (get-buffer "*agent-shell: Qwen*"))
           (red-outputs (my/agent-collect-red-outputs))
           (synthesis-prompt "# 综合修订指令

请作为首席编辑，根据以下红队反馈对原始方案进行综合修订：

1. 逐条回应红队的批评（接受/拒绝并说明理由）
2. 输出一份吸收了合理建议的修订版方案
3. 标记出哪些改动是源自信哪个红队的反馈

"))
      (unless blue-buf
        (user-error "没有找到蓝队主笔 buffer (Qwen)。请先启动。"))
      (with-current-buffer blue-buf
        (dolist (ro red-outputs)
          (when ro
            (setq synthesis-prompt (concat synthesis-prompt
                                   (format "\n--- %s 的反馈 ---\n%s\n"
                                           (car ro) (cdr ro))))))
        (agent-shell-send synthesis-prompt))
      (message "综合修订指令已发送给 Qwen。")))

  (defun my/agent-export-to-org (filepath)
    "将 Qwen buffer 的最新一段输出导出为 .org 文件，附带评审 Checklist。"
    (interactive "FExport to org file: ")
    (let* ((qwen-buf (get-buffer "*agent-shell: Qwen*"))
           (content (when qwen-buf
                      (with-current-buffer qwen-buf
                        (buffer-substring-no-properties
                         (max (point-min) (- (point-max) 4000))
                         (point-max)))))
           (org-content (format "#+TITLE: 方案评审终稿
#+DATE: %s
#+AUTHOR: 舰队输出

* 方案内容

%s

* 评审清单

- [ ] 逻辑完整性
- [ ] 安全性评估
- [ ] 执行可行性
- [ ] 成本合理性
- [ ] 可维护性
- [ ] 红队建议已采纳
- [ ] 用户终审确认

* 终审意见

- 批准 / 需修订 / 驳回
- 补充说明：

"
                                (format-time-string "%Y-%m-%d %H:%M")
                                (or content "（无内容）"))))
      (with-temp-file filepath
        (insert org-content))
      (when (fboundp 'find-file)
        (find-file filepath))
      (message "已导出: %s" filepath)))

  (map! :leader
        :prefix ("A" . "agent")
        :desc "Red team review"   "r" #'my/agent-redteam-review
        :desc "Synthesize"        "s" #'my/agent-synthesize
        :desc "Export to org"     "e" #'my/agent-export-to-org))

(use-package! agent-shell-workspace
  :after agent-shell
  :config
  (map! :leader
        :desc "Agent workspace" "A W" #'agent-shell-workspace-toggle))

(use-package! agent-shell-attention
  :after agent-shell
  :config
  (setopt agent-shell-attention-render-function
          #'agent-shell-attention-render-active)
  (agent-shell-attention-mode))

(use-package! agent-shell-manager
  :after agent-shell
  :config
  (map! :leader
        :desc "Agent manager" "A m" #'agent-shell-manager-toggle))

(use-package! agent-shell-sidebar
  :after agent-shell
  :config
  (setq agent-shell-sidebar-width "30%"
        agent-shell-sidebar-position 'right)
  (map! :leader
        :desc "Agent sidebar" "A s" #'agent-shell-sidebar-toggle))

(use-package! agent-shell-web
  :after agent-shell
  :config
  (setq agent-shell-web-port 8888)
  (map! :leader
        :desc "Agent web UI" "A w" #'agent-shell-web-start))
