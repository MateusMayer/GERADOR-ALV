*&---------------------------------------------------------------------*
*&  Include           ZR_GERADOR_DE_ALV_F01
*&---------------------------------------------------------------------*

FORM zmodifica_tela.

* O MODIF ID deixa o objeto "Modificavel" na tela de seleção.
* Vamos usar um Loop at Screen para modificá-la.
*------------------------------------------------------------
  LOOP AT SCREEN.
*   Se o user quiser telas com parametros
*------------------------------------------------------------------
    IF cb_chec1 = 'X'.
      IF screen-group1 = 'T3'.
        cb_clic1 = 'X'.
        screen-invisible = 0.
        screen-input     = 0.
        screen-active    = 1.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.
    ENDIF.

    IF rb_cl1 = 'X'.

*     Dentro do campo GROUP1 vai ficar o valor do MODIF ID.
*     Daí é só tratar os atributos do elemento como necessário


      IF screen-group1 = 'T3'.
        cb_clic1 = 'X'.
        screen-invisible = 1.
        screen-input     = 0.
        screen-active    = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.

*     Esconde Tela com Parameters
*--------------------------------
      IF screen-group1 = 'T2'.
        screen-invisible = 1.
        screen-input     = 0.
        screen-active    = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.

*     Mostra tela com Select Options
*-----------------------------------
      IF screen-group1 = 'T1'.
        screen-invisible = 0.
        screen-input     = 1.
        screen-active    = 1.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.

    ELSE.

*     Esconde tela com Select Options
*-------------------------------------
      IF screen-group1 = 'T1'.
        screen-invisible = 1.
        screen-input     = 0.
        screen-active    = 0.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.

*     Mostra tela com Parameters
*--------------------------------
      IF screen-group1 = 'T2'.
        screen-invisible = 0.
        screen-input     = 1.
        screen-active    = 1.
        MODIFY SCREEN.
        CONTINUE.
      ENDIF.

    ENDIF.
  ENDLOOP.

ENDFORM.                    " ZMODIFICA_TELA

FORM zdownload_from_tab_txt.
  DATA: ld_target TYPE string.

  IF p_prog IS INITIAL.
    p_prog = sy-datum.
  ENDIF.
  CONCATENATE 'C:\temp\' p_prog '.txt' INTO ld_target.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename                = ld_target
      filetype                = 'ASC' " ASC = Texto, BIN = Binário
    TABLES
      data_tab                = lt_line
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.

  IF sy-subrc = 0.
    DATA: lv_arquivo_salvo(100) TYPE c.
    CONCATENATE 'Arquivo foi salvo com sucesso no caminho:'space ld_target INTO lv_arquivo_salvo.
    MESSAGE lv_arquivo_salvo TYPE 'S'.
  ELSE.
    MESSAGE |Erro ao salvar arquivo [{ sy-subrc }]| TYPE 'E'.
  ENDIF.
ENDFORM. "zdownload_from_tab_txt.

*FORM zf_abas.
*  " Títulos das Abas
*  tab1 = 'Mateus Mayer'.
*  tab2 = 'Karla Johann'.
*
*  " Opção de Vir Selecionado!
*  IF sy-uname = 'FUS_KJOHAN'.
*    tab-activetab = 'COMM2'.
*    tab-dynnr     = 120.
*  ELSE.
*    tab-activetab = 'COMM1'.
*    tab-dynnr     = 110.
*  ENDIF.
*ENDFORM.