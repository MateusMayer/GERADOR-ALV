*&---------------------------------------------------------------------*
*&  Include           ZR_GERADOR_DE_ALV_SCR
*&---------------------------------------------------------------------*
* Vamos controlar a mudança de tela através de dois radiobuttons
*---------------------------------------------------------------
**-------------------------------------------------------------------------------*
** TELA DE SELEÇÃO                                                         INICIO
**-------------------------------------------------------------------------------*
**********************************************************************************
**********************************************************************************
**********************************************************************************
SELECTION-SCREEN BEGIN OF SCREEN 110.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE titulo."ESCOLHE CLASSE
PARAMETERS: p_prog(25) TYPE c.
SELECTION-SCREEN SKIP.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(63) text-001.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb_cl1 RADIOBUTTON GROUP rb1 USER-COMMAND muda_tela. "cl_salv_table
SELECTION-SCREEN COMMENT 5(14) p_campo1.
PARAMETERS: rb_cl2  RADIOBUTTON GROUP rb1 DEFAULT 'X'. "cl_gui_grid_alv
SELECTION-SCREEN COMMENT 24(16) p_campo2.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN SKIP.
PARAMETER: p_alv(10) TYPE c.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF SCREEN 110.
**********************************************************************************
**********************************************************************************
**********************************************************************************
*SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN.
*SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE titulo1."ESCOLHE CLASSE
*PARAMETERS: p_pro1(25) TYPE c.
*SELECTION-SCREEN SKIP.
*SELECTION-SCREEN BEGIN OF LINE.
*SELECTION-SCREEN COMMENT 1(63) text-001.
*SELECTION-SCREEN END OF LINE.
*SELECTION-SCREEN BEGIN OF LINE.
*PARAMETERS: rb_cla1 RADIOBUTTON GROUP rb2 USER-COMMAND muda_tela. "cl_salv_table
*SELECTION-SCREEN COMMENT 5(14) p_campo3.
*PARAMETERS: rb_cla2  RADIOBUTTON GROUP rb2 DEFAULT 'X'. "cl_gui_grid_alv
*SELECTION-SCREEN COMMENT 24(16) p_campo4.
*SELECTION-SCREEN END OF LINE.
*SELECTION-SCREEN SKIP.
*PARAMETER: p_alv1(10) TYPE c.
*SELECTION-SCREEN END OF BLOCK b4.
*SELECTION-SCREEN END OF SCREEN 120.
**********************************************************************************
**********************************************************************************
**********************************************************************************
* Tela Principal
*SELECTION-SCREEN BEGIN OF TABBED BLOCK tab FOR 8 LINES.
*SELECTION-SCREEN TAB (20) tab1 USER-COMMAND comm1 DEFAULT SCREEN 110.
*SELECTION-SCREEN TAB (20) tab2 USER-COMMAND comm2 DEFAULT SCREEN 120.
*SELECTION-SCREEN END OF BLOCK tab.
* O MODIF ID deve ser o MESMO para todos os elementos da tela
*------------------------------------------------------------
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
*
**PARAMETERS: cb_head AS CHECKBOX MODIF ID t1."cabeçalho.
**PARAMETERS: cb_click AS CHECKBOX MODIF ID t1."eventos do mouse(click).
***PARAMETERS: cb_gui AS CHECKBOX MODIF ID t1."status gui standard
**PARAMETERS: cb_check AS CHECKBOX MODIF ID t1."linhas selecionaveis
**PARAMETERS: cb_semaf AS CHECKBOX MODIF ID t1."Adicionar Semáforo
**PARAMETERS: cb_fixed AS CHECKBOX MODIF ID t1."Fixar checkbox
*
*SELECTION-SCREEN END OF BLOCK b2.

* Tela com Parameters.
* O MODIF ID deve ser o MESMO para todos os elementos da tela
*------------------------------------------------------------
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

*PARAMETERS: cb_head1 AS CHECKBOX MODIF ID t2."Cabeçalho.
PARAMETERS: cb_clic1 AS CHECKBOX MODIF ID t3."Eventos do mouse(click).
*PARAMETERS: cb_gui1 AS CHECKBOX MODIF ID t2."Status gui standard
PARAMETERS: cb_chec1 AS CHECKBOX USER-COMMAND muda_tela MODIF ID t2."Linhas selecionaveis
PARAMETERS: cb_sema1 AS CHECKBOX MODIF ID t2."Adicionar Semáforo
PARAMETERS: cb_fixe1 AS CHECKBOX MODIF ID t2."Fixar checkbox

SELECTION-SCREEN END OF BLOCK b3.

INITIALIZATION.
*  PERFORM zf_abas."Nomeia abas e decide qual mostrar primeiro.


* Evento que irá controlar a mudança da tela. Lembre-se que
* é necessário o USER-COMMAND nos RadioButtons para o Report passar
* por aqui!
*------------------------------------------------------------------
**----------------------------------------------------------------------*
** TELA DE SELEÇÃO                                                   FIM
**----------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.
  p_campo1 = 'CL_SALV_TABLE'.
  p_campo2 = 'CL_GUI_GRID_ALV'.

*  PERFORM zmodifica_tela.

*AT SELECTION-SCREEN ON cb_chec1.