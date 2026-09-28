# GstarCAD WBLOCK Tools

Write any selection out to a fresh DWG with a base point, and export every block definition to a folder.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Sometimes the fastest way to reuse part of a drawing is to write it out as its own DWG. These commands export any selection to a new drawing file with a base point, and dump every block definition from the block table out to a folder of DWG files in one run.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/wblock-selection.lsp` | ;; wblock-selection.lsp - Write selected objects to a new DWG
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
 |
| `scripts/export-block-defs.lsp` | ;; export-block-defs.lsp - Write every block definition out as a DWG
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
