(defvar shlisp-opcodes
  '("horn"
    "saw"
    "toggle"
    "togo"
    "swoop"
    "mount"
    "smoke"
    "dust"
    "fog"
    "haze"
    "swamp"
    "string"
    "comb"
    "zither"
    "wave"
    "water"
    "salt"
    "horse"
    "slew"
    "wheel"
    "slave"
    "pulse"
    "sauce"
    "salsa"
    "press"
    "leak"
    "reflect"
    "return"
    "and"
    "xor"
    "negwon"
    "dirac"
    "arab"))
  
(defvar shlisp-nuts
  '("left"
    "right"
    "square"
    "modo"
    "srate"
    "mul"
    "add"
    "tar"
    "bend"
    "jump"
    "pan"
    "short"))

(defvar shlisp-butts
  '("corp"
    "bar"
    "wind"
    "major"
    "minor"
    "lights"
    ))
  
(defvar shlisp-font-lock-defaults
  `((
     ( "^;.*$" . font-lock-comment-face)
     ( "-?\\b[0-9]+\\b" . font-lock-warning-face)
     ( ,(regexp-opt shlisp-nuts 'strings) . font-lock-builtin-face)
     ( ,(regexp-opt shlisp-opcodes 'strings) . font-lock-keyword-face)
     ( ,(regexp-opt shlisp-butts 'strings) . font-lock-string-face)
     ( "[abcdefgh]\\b" . font-lock-constant-face)
     )))


;; command to comment/uncomment text
(defun shlisp-comment-dwim (arg)
 "Comment or uncomment current line or selection."
 (interactive)

 ;; If there's no text selection, comment or uncomment the line
 ;; depending whether the WHOLE line is a comment. If there is a text
 ;; selection, using the first line to determine whether to
 ;; comment/uncomment.
 (let (p1 p2)
   (if (region-active-p)
       (save-excursion
	 (setq p1 (region-beginning) p2 (region-end))
	 (goto-char p1)
	 (if (wholeLineIsCmt-p)
	     (shlisp-uncomment-region p1 p2)
	   (shlisp-comment-region p1 p2)
	   ))
     (progn
       (if (wholeLineIsCmt-p)
	   (shlisp-uncomment-current-line)
	 (shlisp-comment-current-line)
	 )) )))

(defun wholeLineIsCmt-p ()
  (save-excursion
    (beginning-of-line 1)
    (looking-at "[ \t]*//")
    ))

(defun shlisp-comment-current-line ()
  (interactive)
  (beginning-of-line 1)
  (insert ";")
  )

(defun shlisp-uncomment-current-line ()
  "Remove “;” (if any) in the beginning of current line."
  (interactive)
  (when (wholeLineIsCmt-p)
    (beginning-of-line 1)
    (search-forward ";")
    (delete-backward-char 1)
    ))

(defun shlisp-comment-region (p1 p2)
  "Add “;” to the beginning of each line of selected text."
  (interactive "r")
  (let ((deactivate-mark nil))
    (save-excursion
      (goto-char p2)
      (while (>= (point) p1)
        (shlisp-comment-current-line)
        (previous-line)
        ))))

(defun shlisp-uncomment-region (p1 p2)
  "Remove “;” (if any) in the beginning of each line of selected text."
  (interactive "r")
  (let ((deactivate-mark nil))
    (save-excursion
      (goto-char p2)
      (while (>= (point) p1)
        (shlisp-uncomment-current-line)
        (previous-line) )) ))

(define-derived-mode shlisp-mode emacs-lisp-mode "shlisp"
  "shlisp mode is a major mode for editing shlisp files"
  
  (setq font-lock-defaults shlisp-font-lock-defaults)
  
  (setq comment-start ";")

  ;; modify the keymap
  (define-key shlisp-mode-map [remap comment-dwim] 'shlisp-comment-dwim)

  )

(defun shlisp-run-shlisp ()
  "Send the current file to the shnth."
  (interactive)
  (let* (
	(fName (buffer-file-name))
	(progName "shlisp.app") ; must be in your $PATH
	(cmdStr (concat progName " " fName))
	)
    (when (buffer-modified-p)
      (when (y-or-n-p "Buffer modified. Do you want to save first?")
	(save-buffer) ) )
    (message cmdStr)
    (progn
      (message "Running…")
      (shell-command cmdStr "*run-current-file output*" )
      )
    (message "Sent code to shnth")
    )
)

(global-set-key (kbd "M-s") 'shlisp-run-shlisp)

(provide 'shlisp-mode)

(add-to-list 'auto-mode-alist '("\\.shlsp\\'" . shlisp-mode))