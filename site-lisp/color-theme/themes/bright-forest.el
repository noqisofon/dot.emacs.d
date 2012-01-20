(eval-when-compile 
  (require 'color-theme))

(defun color-theme-bright-forest ()
  (interactive)
  (color-theme-install
   '(color-theme-bright-forest
      ((background-color . "#ffffff")
      (background-mode . light)
      (border-color . "#f9fef5")
      (cursor-color . "#000000")
      (foreground-color . "#000000")
      (mouse-color . "black"))
     (fringe ((t (:background "#f9fef5"))))
     (mode-line ((t (:foreground "#ffffff" :background "#3a6336"))))
     (region ((t (:background "#bcdda7"))))
     (font-lock-builtin-face ((t (:foreground "#b38c42"))))
     (font-lock-comment-face ((t (:foreground "#838b79"))))
     (font-lock-function-name-face ((t (:foreground "#6a5029"))))
     (font-lock-keyword-face ((t (:foreground "#2c782b"))))
     (font-lock-string-face ((t (:foreground "#6a893e"))))
     (font-lock-type-face ((t (:foreground"#569617"))))
     (font-lock-variable-name-face ((t (:foreground "#b7901a"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))

;;(add-to-list 'color-themes '(color-theme-bright-forest "Bright Forest" "ned rihine"))

(provide 'bright-forest)
