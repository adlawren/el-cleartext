;; TODO
;; - It will break if not run in a file which is the same directory as common_words.txt
;; - Should be more efficient
;;   - Right now, it's iterating over each word in the buffer, and (potentially) doing a regex search for the word
;;     - It would be better if the text properties of each word could be updated without needing to do a regex search

(defun highlight-uncommon-words ()
  (interactive)
  (setq common-words-hash (make-hash-table))
  (mapcar
   (lambda (word)
     (puthash (intern word) "t" common-words-hash))
   (split-string
    (with-temp-buffer
      (insert-file-contents "common_words.txt")
      (buffer-substring-no-properties (point-min) (point-max)))))
  (mapcar
   (lambda (word)
     (if (not (gethash (intern (downcase word)) common-words-hash))
         (highlight-regexp word)))
   (split-string
    (buffer-substring-no-properties (point-min) (point-max)))))
