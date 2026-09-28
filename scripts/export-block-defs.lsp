;; export-block-defs.lsp - Write every block definition out as a DWG
;; Command: WBLOCKALL
;; Usage: enter a folder; each block definition is saved as its own DWG file
(defun c:WBLOCKALL ( / folder tbl name n )
  (setq folder (getstring T "\nOutput folder (e.g. C:/blocks): "))
  (if (/= folder "")
    (progn
      (setvar "FILEDIA" 0)
      (setq tbl (tblnext "BLOCK" T) n 0)
      (while tbl
        (setq name (cdr (assoc 2 tbl)))
        (if (/= (substr name 1 1) "*")
          (progn
            (command "_.-WBLOCK" (strcat folder "/" name ".dwg") name)
            (setq n (1+ n))
          )
        )
        (setq tbl (tblnext "BLOCK"))
      )
      (setvar "FILEDIA" 1)
      (princ (strcat "\nExported " (itoa n) " block definitions."))
    )
  )
  (princ)
)
