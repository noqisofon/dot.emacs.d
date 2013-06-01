;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil; -*-

;; init-global.el -- Emacs init setting elisp file

;; Copyright (c) 2009-2012 ned rihine

;; Author: ned rihine <ned.rihine@gmail.com>
;; Keyword: tools

;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
 
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <http:;;www.gnu.org/licenses/>.

;; カレントディレクトリの初期位置を設定します。
(cd "~/")

;; 起動時のメッセージを表示しません。
(setq inhibit-startup-message t)
;; *scratch* のメッセージを空にします。
(setq initial-scratch-message nil)

;; エラー時に画面をフラッシュさせないようにします。
(setq ring-bell-function 'ignore)

;; オートセーブを有効にします。
(auto-save-mode t)
;; auto-fill モードを有効にします。
(setq-default auto-fill-function 'do-auto-fill)

;; キー入力を記憶しておきます。
(open-dribble-file "~/.emacs_dribble")

;; 他のソフトで保存した内容を自動的に読み込み直します。
(global-auto-revert-mode 1)

;; リージョンを kill-ring に入れないで削除できるようにします。
(delete-selection-mode t)

;;; Macros:
;; @see http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro add-hook-lambda (name &rest body)
  "lambda を書かずに、/'.*/ の次の引数に関数をズラズラ書けます。"
  `(add-hook ,name #'(lambda () ,@body)))


(defmacro global-set-key-lambda (key args &rest body)
  "lambda を書かずに関数をそのまま書くことができる global-set-key です。"
  `(global-set-key ,key (lambda ,args ,@body)))

(defmacro append-to-list (to list)
  "append して setq します。"
  `(setq ,to (append ,list ,to)))

(defmacro require-if-exists (library &rest body)
  "ライブラリがあったら require します。"
  `(when (locate-library ,(symbol-name library))
     (require ',library) ,@body))

(defmacro eval-safe (&rest body)
  "安全な評価です。評価に失敗してもそこで止まったりしません。"
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(defmacro lazyload (func library-name &rest body)
  "遅延ロードします。"
  `(when (locate-library ,library-name)
     ,@(mapcar (lambda (f) `(autoload ',f ,library-name nil t)) func)
     (eval-after-load ,library-name
                      '(progn
                        ,@body))))

(defun load-safe (load-lib)
  "安全な load です。読み込みに失敗してもそこで止まったりしません。"
  (let ((load-status (load load-lib t)))
    (or load-status
        (message (format "[load-safe] failed %s" load-lib)))
    load-status))

;; via: http://www.sodan.org/~knagano/emacs/dotemacs.html
;; locate-library してから autoload します。
(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))

;; 現在選択中のバッファがファイルからできているかどうか判別します。
(defun selected-buffer-from-file-p ()
  "現在選択中のバッファがファイルからできているかどうか判別します。"
  (let ((selected-buffer-filename (buffer-file-name))
        (selected-buffer-name (buffer-name)))
    (if selected-buffer-filename t nil)))

(when *meadow-p*
  ;; タイトルキャプションを更新します。
  (defun update-title-caption ()
    "タイトルキャプションを更新します。"
    (setq about-meadow (let* ((meadow-about-text (car (split-string (Meadow-version) " ")))
                              (first-hyphen (string-match "-" meadow-about-text)))
                         (store-substring meadow-about-text first-hyphen " ")))
    (setq frame-title-format
          (list (if (selected-buffer-from-file-p) "%f" "%b") " - " about-meadow "@" (system-name))))
  ;; とりあえずタイトル更新。
  (update-title-caption))

(when (not *meadow-p*)
  (defun update-title-caption ()
    "タイトルキャプションを更新します。"
    (setq frame-title-format (let ((file-name (buffer-file-name))
                                   (name (buffer-name)))
                               (if file-name
                                   (concat "%f - " invocation-name " " emacs-version "@" system-name)
                                 (concat "%b - " invocation-name " " emacs-version "@" system-name)))))
  (update-title-caption))
;;; %f だと、フルパス名。 %b ならバッファの名前。

;; 現在は meadow 用に update-title-caption 関数を定義していますが、
;; 他の Emacen では定義していないので、ガード句でくるんでいます。
;; meadow 以外でも同じようにしたい場合は 同じ名前の関数を定義してください。
(if (fboundp 'update-title-caption)
    ;; switch-to-buffer の後に frame-title-format の値を更新します。
    (defadvice switch-to-buffer
               (after switch-to-buffer-after-update-the-title-captions first () activate)
               (message (buffer-name))
               (update-title-caption)))

;; ファイルを保存した時にもタイトルの更新を行うようにします。
(add-hook 'after-save-hook 'update-title-caption)

;; ファイルを開いた時にもタイトルの更新を行うようにします。
(add-hook 'find-file-hook 'update-title-caption)

;;; 自動改行関連:
;; 74 文字目くらいで自動的に改行されないようにします。
(setq-default fill-column 300)
(set-fill-column fill-column)

(defun progression (start interval n)
  "初項 start、公差 interval の長さ n の等差数列を返します。"
  (cond ( (zerop n) nil)
        (t (cons start
                 (progression (+ start interval)
                              interval (1- n))))))

;; タブ文字による空白を 4 つにします。
(setq-default *default-tab-width* 4
              tab-width *default-tab-width*
              tab-stop-list (progression 4 4 120))

;; 通常のインデントで半角スペースを使います。
(setq-default indent-tabs-mode nil)


;;; Useful Functions:
(if *meadow1-p*
    (progn
      ;; Meadow 1.99 なら以下のようにすると同じことができるようです。
      (defun set-buffer-end-mark1()
        "At the end of the buffer [EOF] padding. This string can not be edited to be reflected in the file."
        (let ((overlay (make-overlay (point-max) (point-max))))
          (overlay-put overlay 'before-string #("[EOF]" 0 5 (face highlight)))
          (overlay-put overlay 'insert-behind-hooks
                       '((lambda (overlay after beg end &optional len)
                           (when after
                             (move-overlay overlay (point-max) (point-max))))))))
      (add-hook 'find-file-hooks 'set-buffer-end-mark1))
  ;; else
  (progn
    ;; あるいは
    (defun set-buffer-end-mark2()
      "At the end of the buffer [EOF] padding. This string can not be edited to be reflected in the file."
      (let ((overlay (make-overlay (point-max) (point-max))))
        (overlay-put overlay 'before-string #("[EOF]" 0 5 (face highlight)))
        (overlay-put overlay 'insert-behind-hooks
                     '((lambda (overlay after beg end &optional len)
                         (when after
                           (move-overlay overlay (point-max) (point-max))))))))
    (add-hook 'find-file-hooks 'set-buffer-end-mark2)))
;; でもいい。

;; ** スクリプトを保存する時，自動的に chmod +x を行なうようにする
;;
;; 次のようなコードを ~/.emacs に加えておくと、
;; + ファイルの先頭に #! で始まる行が含まれている
;; + ファイル名の先頭がピリオド以外
;; の場合，実行用のスクリプトファイルであると見なして、保存時に実行許可属性を自動的に設定します。
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)


;; 日付を挿入します。
(defun insert-iso8601format-datetime ()
  "Insert the date the current cursor location."
  (interactive)
  (insert (let ((time-zone (format-time-string "%Z"))
                (iso8601-text (format-time-string "%Y-%m-%dT%H:%M:%S%Z")))
            (if (equal time-zone "")
                (concat iso8601-text (car (cdr (current-time-zone))))
              iso8601-text))))


;; 現在選択中のバッファのファイル名、あるいはバッファ名を返します。
(defun get-selected-buffer-name ()
  "現在選択中のバッファのファイル名、あるいはバッファ名を返します。"
  (interactive)
  (let ((selected-buffer-filename (buffer-file-name ))
        (selected-buffer-name (buffer-name)))
    (if (not selected-buffer-filename)
        selected-buffer-name
      ;; else
      selected-buffer-filename)))



;; テンポラリバッファを作成し、それをウィンドウに表示します。
(defun create-temporary-buffer ()
  "テンポラリバッファを作成し、それをウィンドウに表示します。"
  (interactive)
  ;; *temp* なバッファを作成し、それをウィンドウに表示します。
  (switch-to-buffer (generate-new-buffer "*temp*"))
  ;; セーブが必要ないことを指定します？
  (setq buffer-offer-save nil))

;; *scratch* バッファは簡単な処理に便利なバッファです。
;; しかし，そのバッファの内容を 別名で保存したり、kill したりすると，*scratch* バッファが消えてしまい，また作らないといけません。
;; 面倒です。 
;; そこで，以下のような設定が便利です。これを入れておくと、*scratch*バッファを C-x C-s で保存時には *scratch* バッファを作成してくれます。
;; また，C-x k で kill すると，*scratch*バッファの内容をすべて消してくれます。 非常に便利です。
(defun bookshelf-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun bookshelf-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (bookshelf-make-scratch 0) nil)
                        t))))
(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (bookshelf-buffer-name-list))
                        (bookshelf-make-scratch 1)))))


;; カーソル位置のフェースを調べる関数です。
;; (via: http://d.hatena.ne.jp/whitypig/20090401/1238553652)
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))


(provide 'init-global)
;; init-global.el ends here
