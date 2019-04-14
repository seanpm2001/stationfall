

	.FUNCT	PICK-ONE,TBL,LENGTH,CNT,RND,MSG,RFROB
	GET	TBL,0 >LENGTH
	GET	TBL,1 >CNT
	DEC	'LENGTH
	ADD	TBL,2 >TBL
	MUL	CNT,2
	ADD	TBL,STACK >RFROB
	SUB	LENGTH,CNT
	RANDOM	STACK >RND
	GET	RFROB,RND >MSG
	GET	RFROB,1
	PUT	RFROB,RND,STACK
	PUT	RFROB,1,MSG
	INC	'CNT
	EQUAL?	CNT,LENGTH \?CND1
	SET	'CNT,0
?CND1:	PUT	TBL,0,CNT
	RETURN	MSG


	.FUNCT	APRINT,OBJ
	FSET?	OBJ,NARTICLEBIT \?CCL3
	PRINTC	32
	JUMP	?CND1
?CCL3:	FSET?	OBJ,VOWELBIT \?CCL5
	PRINTI	" an "
	JUMP	?CND1
?CCL5:	PRINTI	" a "
?CND1:	PRINTD	OBJ
	RTRUE	


	.FUNCT	TPRINT,OBJ
	FSET?	OBJ,NARTICLEBIT \?CCL3
	PRINTC	32
	JUMP	?CND1
?CCL3:	PRINTI	" the "
?CND1:	PRINTD	OBJ
	RTRUE	


	.FUNCT	TPRINT-PRSO
	CALL	TPRINT,PRSO
	RSTACK	


	.FUNCT	TPRINT-PRSI
	CALL	TPRINT,PRSI
	RSTACK	


	.FUNCT	ARPRINT,OBJ
	CALL	APRINT,OBJ
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	TRPRINT,OBJ
	CALL	TPRINT,OBJ
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	GO
START::

?FCN:	SET	'WINNER,PROTAGONIST
	SET	'HERE,DECK-TWELVE
	RANDOM	1220
	ADD	4430,STACK >INTERNAL-MOVES
	SET	'MOVES,INTERNAL-MOVES
	SUB	8100,INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,STACK
	CALL	QUEUE,I-HUNGER-WARNINGS,1330
	CALL	QUEUE,I-BLATHER,-1
	PRINTI	"It's been five years since your planetfall on Resida. Your heroics in saving that doomed world resulted in a big promotion, but your life of dull scrubwork has been replaced by a life of dull paperwork. Today you find yourself amidst the administrative maze of Deck Twelve on a typically exciting task: an emergency mission to Space Station Gamma Delta Gamma 777-G 59/59 Sector Alpha-Mu-79 to pick up a supply of "
	PRINT	FORM-NAME
	PRINT	ELLIPSIS
	CALL	V-VERSION
	USL	
	CRLF	
	CALL	V-LOOK
	CALL	MAIN-LOOP
	JUMP	?FCN


	.FUNCT	MAIN-LOOP,TRASH
?PRG1:	CALL	MAIN-LOOP-1 >TRASH
	JUMP	?PRG1


	.FUNCT	MAIN-LOOP-1,ICNT,OCNT,NUM,CNT,OBJ,TBL,V,PTBL,OBJ1,TMP,?TMP1
	SET	'CNT,0
	SET	'OBJ,FALSE-VALUE
	SET	'PTBL,TRUE-VALUE
	CALL	PARSER >P-WON
	ZERO?	P-WON /?CCL3
	GET	P-PRSI,P-MATCHLEN >ICNT
	GET	P-PRSO,P-MATCHLEN >OCNT
	EQUAL?	PRSA,V?WALK /?CND4
	ZERO?	P-IT-OBJECT /?CND4
	CALL	ACCESSIBLE?,P-IT-OBJECT
	ZERO?	STACK /?CND4
	SET	'TMP,FALSE-VALUE
?PRG9:	IGRTR?	'CNT,ICNT /?REP10
	GET	P-PRSI,CNT
	EQUAL?	STACK,IT \?PRG9
	PUT	P-PRSI,CNT,P-IT-OBJECT
	SET	'TMP,TRUE-VALUE
?REP10:	ZERO?	TMP \?CND16
	SET	'CNT,0
?PRG18:	IGRTR?	'CNT,OCNT /?CND16
	GET	P-PRSO,CNT
	EQUAL?	STACK,IT \?PRG18
	PUT	P-PRSO,CNT,P-IT-OBJECT
?CND16:	SET	'CNT,0
?CND4:	ZERO?	OCNT \?CCL27
	SET	'NUM,OCNT
	JUMP	?CND25
?CCL27:	GRTR?	OCNT,1 \?CCL29
	SET	'TBL,P-PRSO
	ZERO?	ICNT \?CCL32
	SET	'OBJ,FALSE-VALUE
	JUMP	?CND30
?CCL32:	GET	P-PRSI,1 >OBJ
?CND30:	SET	'NUM,OCNT
	JUMP	?CND25
?CCL29:	GRTR?	ICNT,1 \?CCL34
	SET	'PTBL,FALSE-VALUE
	SET	'TBL,P-PRSI
	GET	P-PRSO,1 >OBJ
	SET	'NUM,ICNT
	JUMP	?CND25
?CCL34:	GETB	P-SYNTAX,P-SBITS
	BAND	STACK,P-SONUMS
	EQUAL?	STACK,2 \?CCL36
	SET	'NUM,ICNT
	JUMP	?CND25
?CCL36:	SET	'NUM,1
?CND25:	ZERO?	OBJ \?CND37
	EQUAL?	ICNT,1 \?CND37
	GET	P-PRSI,1 >OBJ
?CND37:	EQUAL?	PRSA,V?WALK \?CCL43
	CALL	PERFORM,PRSA,PRSO >V
	JUMP	?CND41
?CCL43:	ZERO?	NUM \?CCL45
	GETB	P-SYNTAX,P-SBITS
	BAND	STACK,P-SONUMS
	ZERO?	STACK \?CCL48
	CALL	PERFORM,PRSA >V
	SET	'PRSO,FALSE-VALUE
	JUMP	?CND41
?CCL48:	ZERO?	LIT \?CCL50
	PRINT	TOO-DARK
	CRLF	
	CALL	STOP
	JUMP	?CND41
?CCL50:	PRINTI	"There isn't anything to "
	GET	P-ITBL,P-VERBN >TMP
	EQUAL?	PRSA,V?TELL \?CCL53
	PRINTI	"talk to"
	JUMP	?CND51
?CCL53:	ZERO?	P-OFLAG \?CTR54
	ZERO?	P-MERGED /?CCL55
?CTR54:	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND51
?CCL55:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND51:	PRINTC	33
	CRLF	
	SET	'V,FALSE-VALUE
	CALL	STOP
	JUMP	?CND41
?CCL45:	SET	'P-NOT-HERE,0
	SET	'P-MULT,FALSE-VALUE
	GRTR?	NUM,1 \?CND58
	SET	'P-MULT,TRUE-VALUE
?CND58:	SET	'TMP,FALSE-VALUE
?PRG60:	IGRTR?	'CNT,NUM \?CCL64
	GRTR?	P-NOT-HERE,0 \?CCL67
	PRINTI	"[The "
	EQUAL?	P-NOT-HERE,NUM /?CND68
	PRINTI	"other "
?CND68:	PRINTI	"object"
	EQUAL?	P-NOT-HERE,1 /?CND70
	PRINTC	115
?CND70:	PRINTI	" that you mentioned "
	EQUAL?	P-NOT-HERE,1 /?CCL74
	PRINTI	"are"
	JUMP	?CND72
?CCL74:	PRINTI	"is"
?CND72:	PRINTI	"n't here.]"
	CRLF	
	JUMP	?CND41
?CCL67:	ZERO?	TMP \?CND41
	CALL	REFERRING
	JUMP	?CND41
?CCL64:	ZERO?	PTBL /?CCL78
	GET	P-PRSO,CNT >OBJ1
	JUMP	?CND76
?CCL78:	GET	P-PRSI,CNT >OBJ1
?CND76:	ZERO?	PTBL /?CCL81
	SET	'PRSO,OBJ1
	JUMP	?CND79
?CCL81:	SET	'PRSO,OBJ
?CND79:	ZERO?	PTBL /?CCL84
	SET	'PRSI,OBJ
	JUMP	?CND82
?CCL84:	SET	'PRSI,OBJ1
?CND82:	GRTR?	NUM,1 /?CCL86
	GET	P-ITBL,P-NC1
	GET	STACK,0
	EQUAL?	STACK,W?ALL,W?BOTH,W?EVERYT \?CND85
?CCL86:	CALL	DONT-ALL,OBJ1
	ZERO?	STACK \?PRG60
	EQUAL?	OBJ1,IT \?CCL94
	PRINTD	P-IT-OBJECT
	JUMP	?CND92
?CCL94:	EQUAL?	OBJ1,HIM \?CCL96
	PRINTD	P-HIM-OBJECT
	JUMP	?CND92
?CCL96:	PRINTD	OBJ1
?CND92:	PRINTI	": "
?CND85:	SET	'TMP,TRUE-VALUE
	CALL	PERFORM,PRSA,PRSO,PRSI >V
	EQUAL?	V,M-FATAL \?PRG60
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
?CND41:	EQUAL?	V,M-FATAL \?CND99
	SET	'P-CONT,FALSE-VALUE
?CND99:	CALL	CLOCKER-VERB?
	ZERO?	STACK /?CCL103
	EQUAL?	PRSA,V?TELL /?CCL103
	ZERO?	P-WON /?CCL103
	CALL	RUNNING?,I-SPACETRUCK
	ZERO?	STACK /?CND107
	LESS?	SPACETRUCK-COUNTER,5 \?CND107
	SET	'C-ELAPSED,240
?CND107:	GETP	HERE,P?ACTION
	CALL	STACK,M-END >V
	JUMP	?CND1
?CCL103:	SET	'C-ELAPSED,0
	JUMP	?CND1
?CCL3:	SET	'P-CONT,FALSE-VALUE
?CND1:	ZERO?	P-WON /?CND111
	ADD	INTERNAL-MOVES,C-ELAPSED >INTERNAL-MOVES
	FSET?	CHRONOMETER,WORNBIT \?CCL115
	LESS?	DAY,3 \?CCL118
	SET	'MOVES,INTERNAL-MOVES
	JUMP	?CND113
?CCL118:	SET	'MOVES,9947
	JUMP	?CND113
?CCL115:	SET	'MOVES,0
?CND113:	ZERO?	C-ELAPSED /?CND119
	CALL	CLOCKER >V
?CND119:	SET	'POSTPONE-ATTACK,FALSE-VALUE
	SET	'FLOYD-TRYTAKEN,FALSE-VALUE
	SET	'P-PRSA-WORD,FALSE-VALUE
	SET	'P-NUMBER,0
	SET	'PRSA,FALSE-VALUE
	SET	'PRSO,FALSE-VALUE
	SET	'PRSI,FALSE-VALUE
?CND111:	SET	'C-ELAPSED,7
	RETURN	C-ELAPSED


	.FUNCT	DONT-ALL,OBJ1,L
	LOC	OBJ1 >L
	EQUAL?	OBJ1,NOT-HERE-OBJECT \?CCL3
	INC	'P-NOT-HERE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL5
	ZERO?	PRSI /?CCL5
	IN?	PRSO,PRSI \TRUE
?CCL5:	CALL	ACCESSIBLE?,OBJ1
	ZERO?	STACK /TRUE
	EQUAL?	P-GETFLAGS,P-ALL \FALSE
	ZERO?	PRSI /?CCL15
	EQUAL?	PRSO,PRSI /TRUE
?CCL15:	EQUAL?	PRSA,V?TAKE \?CCL19
	FSET?	OBJ1,TAKEBIT /?CCL22
	FSET?	OBJ1,TRYTAKEBIT \TRUE
?CCL22:	EQUAL?	L,WINNER,HERE,PRSI /?CCL26
	LOC	WINNER
	EQUAL?	L,STACK /?CCL26
	FSET?	L,SURFACEBIT \TRUE
	FSET?	L,TAKEBIT /TRUE
	RFALSE	
?CCL26:	ZERO?	PRSI \FALSE
	CALL	ULTIMATELY-IN?,PRSO
	ZERO?	STACK /FALSE
	RTRUE	
?CCL19:	EQUAL?	PRSA,V?PUT-ON,V?PUT,V?DROP /?PRD41
	EQUAL?	PRSA,V?SGIVE,V?GIVE \?CCL39
?PRD41:	IN?	OBJ1,WINNER \TRUE
?CCL39:	EQUAL?	PRSA,V?PUT-ON,V?PUT \FALSE
	IN?	PRSO,WINNER /FALSE
	CALL	ULTIMATELY-IN?,PRSO,PRSI
	ZERO?	STACK \TRUE
	RFALSE	


	.FUNCT	CLOCKER-VERB?
	EQUAL?	PROTAGONIST,WINNER \TRUE
	EQUAL?	PRSA,V?SCORE,V?HELP,V?VERSION /FALSE
	EQUAL?	PRSA,V?$COMMAND,V?$UNRECORD,V?$RECORD /FALSE
	EQUAL?	PRSA,V?RESTORE,V?SAVE,V?$RANDOM /FALSE
	EQUAL?	PRSA,V?SCRIPT,V?QUIT,V?RESTART /FALSE
	EQUAL?	PRSA,V?SUPER-BRIEF,V?BRIEF,V?UNSCRIPT /FALSE
	EQUAL?	PRSA,V?VERBOSE /FALSE
	RTRUE	


	.FUNCT	FAKE-ORPHAN,IT-WAS-USED=0,TMP,?TMP1
	CALL	ORPHAN,P-SYNTAX,FALSE-VALUE
	GET	P-OTBL,P-VERBN >TMP
	PRINTI	"[Be specific: Wh"
	ZERO?	IT-WAS-USED /?CCL3
	PRINTI	"at object"
	JUMP	?CND1
?CCL3:	PRINTC	111
?CND1:	PRINTI	" do you want to "
	ZERO?	TMP \?CCL6
	PRINTI	"tell"
	JUMP	?CND4
?CCL6:	GETB	P-VTBL,2
	ZERO?	STACK \?CCL8
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND4
?CCL8:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
?CND4:	SET	'P-OFLAG,TRUE-VALUE
	SET	'P-WON,FALSE-VALUE
	GETB	P-SYNTAX,P-SPREP1
	CALL	PREP-PRINT,STACK
	PRINTR	"?]"


	.FUNCT	PERFORM,A,O=0,I=0,V,OA,OO,OI
	SET	'OA,PRSA
	SET	'OO,PRSO
	SET	'OI,PRSI
	SET	'PRSA,A
	ZERO?	P-WALK-DIR \?CND1
	EQUAL?	IT,O,I \?CND1
	CALL	VISIBLE?,P-IT-OBJECT
	ZERO?	STACK /?CCL7
	EQUAL?	IT,O \?CCL10
	SET	'O,P-IT-OBJECT
	JUMP	?CND1
?CCL10:	SET	'I,P-IT-OBJECT
?CND1:	ZERO?	P-WALK-DIR \?CND16
	EQUAL?	HIM,O,I \?CND16
	CALL	VISIBLE?,P-HIM-OBJECT
	ZERO?	STACK /?CCL22
	EQUAL?	HIM,O \?CCL25
	SET	'O,P-HIM-OBJECT
	JUMP	?CND16
?CCL7:	ZERO?	I \?CCL13
	CALL	FAKE-ORPHAN,TRUE-VALUE
	RETURN	8
?CCL13:	CALL	REFERRING
	RETURN	8
?CCL25:	SET	'I,P-HIM-OBJECT
?CND16:	SET	'PRSO,O
	SET	'PRSI,I
	EQUAL?	A,V?WALK /?CCL33
	EQUAL?	NOT-HERE-OBJECT,PRSO,PRSI \?CCL33
	CALL	D-APPLY,STR?1,NOT-HERE-OBJECT-F >V
	ZERO?	V /?CCL33
	SET	'P-WON,FALSE-VALUE
	JUMP	?CND31
?CCL22:	ZERO?	I \?CCL28
	CALL	FAKE-ORPHAN
	RETURN	8
?CCL28:	CALL	REFERRING,TRUE-VALUE
	RETURN	8
?CCL33:	SET	'O,PRSO
	SET	'I,PRSI
	CALL	THIS-IS-IT,PRSI
	CALL	THIS-IS-IT,PRSO
	GETP	WINNER,P?ACTION
	CALL	D-APPLY,STR?2,STACK >V
	ZERO?	V \?CND31
	GET	PREACTIONS,A
	CALL	D-APPLY,STR?3,STACK >V
	ZERO?	V \?CND31
	ZERO?	I /?CCL43
	GETP	I,P?ACTION
	CALL	D-APPLY,STR?4,STACK >V
	ZERO?	V \?CND31
?CCL43:	ZERO?	O /?CCL47
	EQUAL?	A,V?WALK /?CCL47
	GETP	O,P?ACTION
	CALL	D-APPLY,STR?5,STACK >V
	ZERO?	V \?CND31
?CCL47:	GET	ACTIONS,A
	CALL	D-APPLY,FALSE-VALUE,STACK >V
	ZERO?	V /?CND31
?CND31:	SET	'PRSA,OA
	SET	'PRSO,OO
	SET	'PRSI,OI
	RETURN	V


	.FUNCT	D-APPLY,STR,FCN,FOO=0,RES
	ZERO?	FCN /FALSE
	ZERO?	FOO /?CCL6
	CALL	FCN,FOO >RES
	RETURN	RES
?CCL6:	CALL	FCN >RES
	RETURN	RES


	.FUNCT	DEQUEUE,RTN
	CALL	QUEUED?,RTN >RTN
	ZERO?	RTN /FALSE
	PUT	RTN,C-RTN,0
	RTRUE	


	.FUNCT	QUEUED?,RTN,C,E
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E /FALSE
	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	GET	C,C-TICK
	ZERO?	STACK /FALSE
	RETURN	C
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	RUNNING?,RTN,C,E
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E /FALSE
	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	GET	C,C-TICK
	ZERO?	STACK /FALSE
	GET	C,C-TICK
	GRTR?	STACK,1 /FALSE
	RTRUE	
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	QUEUE,RTN,TICK,C,E,INT=0
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E \?CCL5
	ZERO?	INT /?CCL8
	SET	'C,INT
	JUMP	?CND6
?CCL8:	LESS?	C-INTS,C-INTLEN \?CND9
	PRINTI	"Bug2"
	CRLF	
?CND9:	SUB	C-INTS,C-INTLEN >C-INTS
	LESS?	C-INTS,C-MAXINTS \?CND11
	SET	'C-MAXINTS,C-INTS
?CND11:	ADD	C-TABLE,C-INTS >INT
?CND6:	PUT	INT,C-RTN,RTN
	JUMP	?REP2
?CCL5:	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CCL14
	SET	'INT,C
?REP2:	GRTR?	INT,CLOCK-HAND \?CND16
	ADD	TICK,3
	SUB	0,STACK >TICK
?CND16:	PUT	INT,C-TICK,TICK
	RETURN	INT
?CCL14:	GET	C,C-RTN
	ZERO?	STACK \?CND3
	SET	'INT,C
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	CLOCKER,E,TICK,RTN,FLG=0,Q?=0,OWINNER,X
	ADD	C-TABLE,C-INTS >CLOCK-HAND
	ADD	C-TABLE,C-TABLELEN >E
	SET	'OWINNER,WINNER
	SET	'WINNER,PROTAGONIST
?PRG1:	EQUAL?	CLOCK-HAND,E \?CCL5
	SET	'CLOCK-HAND,E
	SET	'WINNER,OWINNER
	RETURN	FLG
?CCL5:	GET	CLOCK-HAND,C-RTN
	ZERO?	STACK /?CND3
	GET	CLOCK-HAND,C-TICK >TICK
	LESS?	TICK,-1 \?CCL9
	SUB	0,TICK
	SUB	STACK,3
	PUT	CLOCK-HAND,C-TICK,STACK
	SET	'Q?,CLOCK-HAND
	JUMP	?CND3
?CCL9:	ZERO?	TICK /?CND3
	GRTR?	TICK,0 \?CND11
	SUB	TICK,C-ELAPSED >TICK
	LESS?	TICK,0 \?CND13
	SET	'TICK,0
?CND13:	PUT	CLOCK-HAND,C-TICK,TICK
?CND11:	ZERO?	TICK /?CND15
	SET	'Q?,CLOCK-HAND
?CND15:	GRTR?	TICK,0 /?CND3
	GET	CLOCK-HAND,C-RTN >RTN
	ZERO?	TICK \?CND19
	PUT	CLOCK-HAND,C-RTN,0
?CND19:	CALL	RTN >X
	ZERO?	X /?CND21
	SET	'FLG,TRUE-VALUE
?CND21:	ZERO?	Q? \?CND3
	GET	CLOCK-HAND,C-RTN
	ZERO?	STACK /?CND3
	SET	'Q?,TRUE-VALUE
?CND3:	ADD	CLOCK-HAND,C-INTLEN >CLOCK-HAND
	ZERO?	Q? \?PRG1
	ADD	C-INTS,C-INTLEN >C-INTS
	JUMP	?PRG1

	.ENDI
