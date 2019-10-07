;; TODO:
;; - Make it highlight words which are NOT in the list
;; - Rewrite; it's too slow
;;   - It's currently linear with respect to the number of words in the common_words file
;;   - Make it linear with respect to the number of words in the buffer

(defun highlight-common-words ()
  (interactive)
  (mapcar
   (lambda (word) (highlight-regexp word))
   (split-string
    (with-temp-buffer
      (insert-file-contents "common_words.txt")
      (buffer-substring-no-properties (point-min) (point-max)))
    "\n")))
