;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)

;; (when (package! eaf :recipe (:host github
;;                              :repo "manateelazycat/emacs-application-framework"
;;                              :files ("*")
;;                              :build (:not compile)))
;;   (package! all-the-icons)
;;   (package! ctable :recipe (:host github :repo "kiwanami/emacs-ctable"))
;;   (package! deferred :recipe (:host github :repo "kiwanami/emacs-deferred"))
;;   (package! epc :recipe (:host github :repo "kiwanami/emacs-epc")))

(package! doom-snippets  :recipe (:host github
                                  :repo "hlissner/doom-snippets"
                                  :files ("*.el" "*")))

(package! lsp-bridge  :recipe (:host github
                               :repo "manateelazycat/lsp-bridge"
                               :files ("*.el" "*")))

(package! edit-server)

(package! org-roam-ui)

(package! rime)

(package! simple-httpd
  :recipe (
           :host github
           :repo "skeeto/emacs-web-server"
           :files ("simple-httpd-test.el"
                   "simple-httpd.el")))

(package! impatient-mode)

(package! aidermacs)

(package! vterm
  :recipe (
           :host github
           :repo "xhcoding/emacs-libvterm"
           :files ("CMakeLists.txt"
                   "elisp.c"
                   "elisp.h"
                   "emacs-module.h"
                   "etc"
                   "utf8.c"
                   "utf8.h"
                   "vterm.el"
                   "vterm-module.c"
                   "vterm-module.h")))

(package! gptel)

(package! superchat
  :recipe (:host github :repo "yibie/superchat"))

(package! eca
  :recipe (:host github :repo "editor-code-assistant/eca-emacs" :files ("*.el")))

(package! claude-code
  :recipe (:host github :repo "stevemolitor/claude-code.el"))

(package! gemini-cli
  :recipe (:host github :repo "linchen2chris/gemini-cli.el"))

(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el"))

(package! ai-code
  :recipe (:host github :repo "tninja/ai-code-interface.el"))
