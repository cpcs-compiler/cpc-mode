(defvar cpc-mode-hook nil)

(defvar cpc-mode-map
  (let ((map (make-keymap)))
    map))

(defvar cpc-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?' "< b" table)
    (modify-syntax-entry ?/ ". 12b" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?= "." table)
    (modify-syntax-entry ?+ "." table)
    (modify-syntax-entry ?- "." table)
    (modify-syntax-entry ?* "." table)
    (modify-syntax-entry ?& "." table)
    (modify-syntax-entry ?| "." table)
    (modify-syntax-entry ?> "." table)
    (modify-syntax-entry ?< "." table)
    table))

(defconst cpc-mode-keywords
  (mapconcat (function (lambda (x) (concat (symbol-name x) "/")))
	     '(button bouton
		      ccp
		      checkbox
		      client
		      close fermer
		      cls
		      cmd
		      colorf couleurc
		      colorb couleurf
		      copy copier
		      create creer
		      declare declarer
		      delete supprimer
		      dir rep
		      end fin
		      exe
		      fix
		      folder dossier
		      function fonction
		      goto aller
		      gui iug
		      help aide
		      if si
		      loc pos
		      msgbox message
		      open ouvrir
		      picturebox imagebox
		      ping
		      progressbar barreprogression
		      rename renommer
		      return retour
		      server serveur
		      set
		      start demarrer
		      stop
		      stopk
		      sys
		      textblock textebloc
		      textbox textebox
		      txt
		      window fenetre
		      write ecrire)
	     "\\|"))

(defconst cpc-mode-keyword-function-name
  (concat "\\(?:"
	  (mapconcat 'symbol-name
		     '(button bouton
			      checkbox
			      function fonction
			      msgbox message
			      picturebox imagebox
			      progressbar barreprogression
			      textblock textebloc
			      textbox textebox
			      window fenetre)
		     "\\|")
	  "\\)/[ \t]+\\([a-z_][a-z0-9_\.]+\\)"))

(defconst cpc-mode-keyword-end
  (concat "\\(?:end\\|fin\\)/[ \t]+\\("
	  (mapconcat 'symbol-name
		     '(button bouton
			      checkbox
			      if si
			      function fonction
			      msgbox message
			      picturebox imagebox
			      progressbar barreprogression
			      textblock textebloc
			      textbox textebox
			      window fenetre)
		     "\\|")
	  "\\)"))

(defconst cpc-mode-builtins
  (mapconcat (function (lambda (x) (concat "CPC\." (symbol-name x))))
	     '(INSTR INSTRRE MID MIDA LEN TAILLE MAJ MIN SIGNE SIGN
		     ENTIER INTEGER INT FRAC VAL CHR CAR CARACTERE
		     ASC ASCII HEX HEXA HEXADECIMAL HEXADECIMALE
		     ABS LOG EXP SQR RAC COS SIN TAN ACOS ASIN ATAN
		     ATANR NET.PING FICHIER_EXISTE FILE_EXIST
		     TAILLE_FICHIER FILE_SIZE LIRE_FICHIER READ_FILE
		     )
	     "\\|"))

(defconst cpc-mode-constants
  (mapconcat (function (lambda (x) (concat "%" (symbol-name x) "%")))
	     '(_EXE_PATH_ _EXE_PATH_F_ _EXE_PID_ _EXE_TID_ _EXE_DATE_
			  CPC.CRLF CPC.LFCR CPC.CR CPC.LF CPC.RND CPC.DIR CPC.REP
			  CPC.DIR.KRNL CPC.REP.KRNL CPC.DIR.KRNL.INIT CPC.REP.KRNL.INIT
			  CPC.HOUR CPC.HEURE CPC.MIN
			  CPC.DATE CPC.TIME CPC.TIMER CPC.TEMPS)
	     "\\|"))

(defvar cpc-mode-highlight nil)
(setq cpc-mode-highlight
      `(

	("\\(rem/.*\\)" . (1 font-lock-comment-face))
	
	(,cpc-mode-keywords . font-lock-keyword-face)
	(,cpc-mode-keyword-end . (1 font-lock-keyword-face))
	(,cpc-mode-keyword-function-name . (1 font-lock-function-name-face))
	(,cpc-mode-builtins . font-lock-builtin-face)
 	(,cpc-mode-constants . font-lock-constant-face)

	("\\(?:if\\|si\\)/.*\\(then:\\|alors:\\)" . (1 font-lock-keyword-face))
	("else:\\|sinon:" . font-lock-keyword-face)
	("fix/[ \t]+[a-z_][a-z0-9_\.]+\[[0-9]+[ \t]+\\(to\\|a\\)" . (1 font-lock-keyword-face))
	("\\(%[a-z_][a-z_\.0-9]+%\\)" . (1 font-lock-variable-name-face))
	("\\(@#[a-z_][a-z0-9_\.]+\\)" . (1 font-lock-variable-name-face))
	))

(define-derived-mode cpc-mode fundamental-mode
  "CpcdosC+ mode"
  "Major mode for CpcdosC+"
  (setq font-lock-defaults '(cpc-mode-highlight nil t))
  
  (setq-local comment-start "REM/")
  (setq-local comment-start-skip "REM/[ \t]*"))

(provide 'cpc-mode)

(add-to-list 'auto-mode-alist '("\\.cpc\\'" . cpc-mode))
