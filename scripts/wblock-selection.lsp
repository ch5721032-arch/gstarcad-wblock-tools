;; wblock-selection.lsp - Write selected objects to a new DWG
;; Command: WBLOCKSEL
;; Usage: select objects, choose a file, then pick the base point
(defun c:WBLOCKSEL ( / ss file pt )
  (setq ss (ssget "\nSelect objects for the new drawing: "))
  (if ss
    (progn
      (setq file (getfiled "Save new drawing as" "" "dwg" 1))
      (if file
        (progn
          (setvar "FILEDIA" 0)
          (setq pt (getpoint "\nBase point: "))
          (if pt
            (command "_.-WBLOCK" file "" pt ss "")
          )
          (setvar "FILEDIA" 1)
          (princ (strcat "\nWritten to: " file))
        )
      )
    )
  )
  (princ)
)
