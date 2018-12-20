;; TODO Is the require needed?
(require 'erc-services)

(load ".secrets.el")

(use-package erc
  ;; Sourced from https://www.reddit.com/r/emacs/comments/8ml6na/tip_how_to_make_erc_fun_to_use/
  ;; Which is actually the excellent git repo https://github.com/rememberYou/.emacs.d/blob/master/config.org#irc
  :preface
  (defun my/erc-notify (nickname message)
    "Displays a notification message for ERC."
    (let* ((channel (buffer-name))
           (nick (erc-hl-nicks-trim-irc-nick nickname))
           (title (if (string-match-p (concat "^" nickname) channel)
                      nick
                    (concat nick " (" channel ")")))
           (msg (s-trim (s-collapse-whitespace message))))
      (alert (concat nick ": " msg) :title title)))

  (defun my/erc-preprocess (string)
    "Avoids channel flooding."
    (setq str
          (string-trim
           (replace-regexp-in-string "\n+" " " str))))

  :hook ((ercn-notify . my/erc-notify)
         (erc-send-pre . my/erc-preprocess))

  :custom
  (erc-autojoin-timing 'ident)
  ;; TODO These lines create some sort of margin, no space on laptop screens :|
  ;; (erc-fill-function 'erc-fill-static)
  ;; (erc-fill-static-center 22)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  ;; TODO Not sure what the following does
  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                             "324" "329" "332" "333" "353" "477"))
  :config
  (add-to-list 'erc-modules 'notifications)
  (add-to-list 'erc-modules 'spelling)
  (erc-services-mode 1)
  (erc-notify-mode t)
  (erc-update-modules))
