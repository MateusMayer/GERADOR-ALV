*&---------------------------------------------------------------------*
*&  Include           ZR_GERADOR_DE_ALV_CL2
*&---------------------------------------------------------------------*

FORM z_gera_cl_gui_alv_grid.
  CLEAR lt_line.
  IF rb_cl2 IS NOT INITIAL.
    CONCATENATE 'REPORT' p_prog INTO DATA(lv_report) SEPARATED BY space.
    CONCATENATE lv_report '.' INTO DATA(lv_report1).
    APPEND lv_report1                                                                 TO lt_line.
    APPEND '*----------------------------------------------------------------------*' TO lt_line.
    APPEND '*----------------------------INCLUDE-TOP-------------------------------*' TO lt_line.
    APPEND '*----------------------------------------------------------------------*' TO lt_line.

**************************************************************************************************************
    APPEND 'TABLES: mara.' TO lt_line.
**************************************************************************************************************

    APPEND 'TYPES: BEGIN OF ty_alv,'                                                  TO lt_line.
    IF cb_chec1 IS NOT INITIAL.
      APPEND '         check(1)   TYPE c, "Checkbox'                                    TO lt_line.
    ENDIF.
    IF cb_sema1 IS NOT INITIAL.
      APPEND '         semaforo(8) TYPE c, "Semáforo'                                   TO lt_line.
    ENDIF.
    LOOP AT gt_alv INTO gs_alv.
      TRANSLATE gs_alv-nome_campo TO LOWER CASE.
      TRANSLATE gs_alv-tab_ref TO LOWER CASE.
      TRANSLATE gs_alv-campo_ref TO LOWER CASE.
      CONCATENATE gs_alv-nome_campo 'TYPE' gs_alv-tab_ref INTO DATA(lv_type) SEPARATED BY space.
      CONCATENATE lv_type '-' gs_alv-campo_ref',' INTO DATA(lv_type1).
      APPEND lv_type1                                                                 TO lt_line.
    ENDLOOP.
    APPEND '       END OF ty_alv.'                                                    TO lt_line.
    APPEND ''                                                                         TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                         TABELAS INTERNAS                              ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'DATA:                                                                   ' TO lt_line.
    APPEND '  gt_alv      TYPE TABLE OF ty_alv,                                     ' TO lt_line.
    APPEND '  gt_sort     TYPE lvc_t_sort,                                          ' TO lt_line.
    APPEND '  gt_fieldcat TYPE lvc_t_fcat.                                          ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                       ESTRUTURAS INTERNAS                             ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'DATA:                                                                   ' TO lt_line.
    APPEND '*** Estrutura para Saída                                                ' TO lt_line.
    APPEND '  gs_alv      TYPE ty_alv,                                              ' TO lt_line.
    APPEND '*** Estrutura de Layout                                                 ' TO lt_line.
    APPEND '  gs_layout   TYPE lvc_s_layo,                                          ' TO lt_line.
    APPEND '*** Estrutura de Ordenação                                              ' TO lt_line.
    APPEND '  gs_sort     TYPE lvc_s_sort,                                          ' TO lt_line.
    APPEND '*** Estrutura da Fieldcat                                               ' TO lt_line.
    APPEND '  gs_fieldcat TYPE lvc_s_fcat.                                          ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                      FIELD-SYMBOLS GLOBAIS                            ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'FIELD-SYMBOLS:                                                          ' TO lt_line.
    APPEND '<gs_alv>  TYPE ty_alv.                                                  ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                       DEFINIÇÃO DE CLASSES                            ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'CLASS lcl_main DEFINITION.                                              ' TO lt_line.
    APPEND '  PUBLIC SECTION.                                                       ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '    METHODS:                                                            ' TO lt_line.
    APPEND '      constructor,                                                      ' TO lt_line.
    APPEND '      z_select_data,                                                    ' TO lt_line.
    APPEND '      z_call_screen.                                                    ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'ENDCLASS. "CLASS lcl_main                                               ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'CLASS lcl_alv DEFINITION.                                               ' TO lt_line.
    APPEND '  PUBLIC SECTION.                                                       ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '    METHODS:                                                            ' TO lt_line.
    APPEND '      constructor,                                                      ' TO lt_line.
    APPEND '      z_layout,                                                         ' TO lt_line.
    APPEND '      z_sort,                                                           ' TO lt_line.
    APPEND '      z_fieldcat,                                                       ' TO lt_line.
    APPEND '      z_show_alv.                                                       ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'ENDCLASS. "CLASS lcl_alv                                                ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    IF cb_clic1 IS NOT INITIAL.
      APPEND 'CLASS lcl_event_handler DEFINITION.                                     ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  PUBLIC SECTION.                                                       ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '    METHODS:                                                            ' TO lt_line.
      APPEND '*--To add new functional buttons to the ALV toolbar                     ' TO lt_line.
      APPEND '      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid               ' TO lt_line.
      APPEND '        IMPORTING e_object e_interactive,                               ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '      handle_user_command FOR EVENT user_command OF cl_gui_alv_grid     ' TO lt_line.
      APPEND '        IMPORTING e_ucomm,                                              ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '      handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid   ' TO lt_line.
      APPEND '        IMPORTING e_row_id e_column_id es_row_no.                       ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'ENDCLASS. "lcl_event_handler DEFINITION                                 ' TO lt_line.
    ENDIF.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                        DEFINIÇÃO DE OBJETOS                           ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'DATA:                                                                   ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*** Objeto para ALV                                                     ' TO lt_line.
    APPEND '  go_alv       TYPE REF TO cl_gui_alv_grid,                             ' TO lt_line.
    APPEND '*** Container                                                           ' TO lt_line.
    APPEND '  go_container TYPE REF TO cl_gui_container.                            ' TO lt_line.
    APPEND ''                                                                         TO lt_line.
    APPEND ''                                                                         TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                          TELA DE SELEÇÃO                              ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'SELECTION-SCREEN BEGIN OF BLOCK 1 WITH FRAME TITLE text-001.            ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'SELECT-OPTIONS: so_matnr FOR mara-matnr.                                ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'SELECTION-SCREEN END OF BLOCK 1.                                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'START-OF-SELECTION.                                                     ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*-->Cria uma instância da classe principal do programa.                 ' TO lt_line.
    APPEND '  DATA(lo_main) = NEW lcl_main( ).                                      ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*-->Seleciona os dados.                                                 ' TO lt_line.
    APPEND '  lo_main->z_select_data( ).                                            ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'END-OF-SELECTION.                                                       ' TO lt_line.
    APPEND '  lo_main->z_call_screen( ).                                            ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                           PROCESSAMENTO                               ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                          EVENTOS DE TELA                              ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND ' MODULE status_0100 OUTPUT.                                             ' TO lt_line.
    APPEND '  SET PF-STATUS ''ZPF0100''.                                            ' TO lt_line.
    APPEND '  SET TITLEBAR ''ZTB0100''.                                             ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '* Monta o ALV                                                           ' TO lt_line.
    APPEND '*-->Cria uma instância da classe do ALV.                                ' TO lt_line.
    APPEND '  DATA(lo_alv) = NEW lcl_alv( ).                                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  lo_alv->z_layout( ) .                                                 ' TO lt_line.
    APPEND '  lo_alv->z_sort( ).                                                    ' TO lt_line.
    APPEND '  lo_alv->z_fieldcat( ).                                                ' TO lt_line.
    APPEND '  lo_alv->z_show_alv( ).                                                ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'ENDMODULE.                 " STATUS_0100  OUTPUT                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'MODULE user_command_0100 INPUT.                                         ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  CASE sy-ucomm.                                                        ' TO lt_line.
    APPEND '    WHEN ''BACK''.                                                      ' TO lt_line.
    APPEND '      SET SCREEN 0.                                                     ' TO lt_line.
    APPEND '    WHEN ''EXIT'' .                                                     ' TO lt_line.
    APPEND '      SET SCREEN 0.                                                     ' TO lt_line.
    APPEND '    WHEN ''CANCEL'' .                                                   ' TO lt_line.
    APPEND '      LEAVE PROGRAM.                                                    ' TO lt_line.
    APPEND '  ENDCASE.                                                              ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'ENDMODULE. " USER_COMMAND_0100  INPUT'                                    TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                           PROCESSAMENTO                               ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND '*                     IMPLEMENTAÇÃO DAS CLASSES                         ' TO lt_line.
    APPEND '*-----------------------------------------------------------------------' TO lt_line.
    APPEND 'CLASS lcl_main IMPLEMENTATION.                                          ' TO lt_line.
    APPEND '  METHOD constructor.                                                   ' TO lt_line.
    APPEND '  ENDMETHOD.                                                            ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD z_select_data.                                                 ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '    DO 10 TIMES.                                                        ' TO lt_line.
    IF cb_sema1 IS NOT INITIAL.
      APPEND '  WRITE icon_green_light TO gs_alv-semaforo.'                             TO lt_line.
    ENDIF.
    APPEND '    APPEND gs_alv TO gt_alv.                                            ' TO lt_line.
    APPEND '    ENDDO.                                                              ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  ENDMETHOD. "METHOD z_select_data.                                     ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD z_call_screen.                                                 ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '    IF gt_alv IS NOT INITIAL.                                           ' TO lt_line.
    APPEND '      CALL SCREEN ''0100''."Chama a tela para mostrar o ALV             ' TO lt_line.
    APPEND '    ELSE.                                                               ' TO lt_line.
    APPEND '      MESSAGE i398(00) WITH text-002. "Não há dados para exibição       ' TO lt_line.
    APPEND '    ENDIF.                                                              ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  ENDMETHOD. "METHOD z_call_screen.                                     ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'ENDCLASS.                                                               ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'CLASS lcl_alv IMPLEMENTATION.                                           ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD constructor.                                                   ' TO lt_line.
    APPEND '  ENDMETHOD.                                                            ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD z_layout.                                                      ' TO lt_line.
    APPEND '    " Estruturas de Layout                                              ' TO lt_line.
    APPEND '    gs_layout-zebra       = ''X''.   "Linhas do relatório zebradas      ' TO lt_line.
    APPEND '    gs_layout-cwidth_opt  = ''X''.   "Otimização do tamanho das colunas ' TO lt_line.
    APPEND '  ENDMETHOD. "METHOD z_layout.                                          ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD z_sort.                                                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.

    LOOP AT gt_alv INTO gs_alv WHERE order_down IS NOT INITIAL OR order_up IS NOT INITIAL.

      DATA: lv_spos(2) TYPE c VALUE 0.
      lv_spos = lv_spos + 1.
      CONCATENATE: '    gs_sort-spos = '''  lv_spos '''.' INTO DATA(lv_concatenate).
      APPEND lv_concatenate TO lt_line.
      CLEAR lv_concatenate.
      CONCATENATE: '    gs_sort-fieldname = '''  gs_alv-nome_campo '''.' INTO lv_concatenate.
      APPEND lv_concatenate TO lt_line.
      CLEAR lv_concatenate.

      IF gs_alv-order_up IS NOT INITIAL.
        APPEND '    gs_sort-up = ''X''.                                                 ' TO lt_line.
      ELSE.
        APPEND '    gs_sort-down = ''X''.                                               ' TO lt_line.
      ENDIF.

      APPEND '    APPEND gs_sort TO gt_sort .                                         ' TO lt_line.
      APPEND '    CLEAR: gs_sort.                                                     ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
    ENDLOOP.

    APPEND '  ENDMETHOD. "METHOD z_sort.                                            ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD z_fieldcat.                                                    ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    IF cb_chec1 IS NOT INITIAL.
      APPEND '    CLEAR gs_fieldcat.                                                  ' TO lt_line.
      APPEND '    gs_fieldcat-col_pos = 0.                                            ' TO lt_line.
      APPEND '    WRITE icon_select_all TO gs_fieldcat-coltext.                       ' TO lt_line.
      APPEND '    gs_fieldcat-fieldname = ''CHECK''.                                  ' TO lt_line.
      APPEND '    gs_fieldcat-seltext = ''Selecionar Todos''.                         ' TO lt_line.
      APPEND '    gs_fieldcat-ref_table = ''GT_ALV''.                                 ' TO lt_line.
      APPEND '    gs_fieldcat-ref_field = ''CHECK''.                                  ' TO lt_line.
      APPEND '    gs_fieldcat-hotspot   = abap_true.                                  ' TO lt_line.
      APPEND '    gs_fieldcat-checkbox  = abap_true.                                  ' TO lt_line.
      IF cb_fixe1 IS NOT INITIAL.
        APPEND '    gs_fieldcat-key  = abap_true.                                       ' TO lt_line.
      ENDIF.
      APPEND '    APPEND gs_fieldcat TO gt_fieldcat.                                  ' TO lt_line.
    ENDIF.
    APPEND '    CLEAR gs_fieldcat.                                                  ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    IF cb_sema1 IS NOT INITIAL.
      APPEND ' CLEAR gs_fieldcat.                                                      ' TO lt_line.
      APPEND '    gs_fieldcat-coltext   = ''STATUS''.                                      ' TO lt_line.
      APPEND '    gs_fieldcat-fieldname = ''SEMAFORO''.                                    ' TO lt_line.
      APPEND '    gs_fieldcat-ref_table = ''GT_ALV''.                                      ' TO lt_line.
      APPEND '    APPEND gs_fieldcat TO gt_fieldcat.                                       ' TO lt_line.
      APPEND '                                                                         ' TO lt_line.
    ENDIF.

    LOOP AT gt_alv INTO gs_alv.
      APPEND ' CLEAR gs_fieldcat.                                                      ' TO lt_line.

      TRANSLATE gs_alv-text_colunm+1(17) TO LOWER CASE.

      CONCATENATE: 'gs_fieldcat-coltext   = ''' gs_alv-text_colunm'''.' INTO DATA(lv_text_column).
      APPEND lv_text_column TO lt_line.

      CLEAR lv_text_column.
      CONCATENATE: 'gs_fieldcat-fieldname = ''' gs_alv-nome_campo'''.' INTO lv_text_column.
      APPEND lv_text_column TO lt_line.

      APPEND '    gs_fieldcat-ref_table = ''GT_ALV''.                                 ' TO lt_line.
      IF gs_alv-fixed IS NOT INITIAL.
        APPEND '    gs_fieldcat-key = abap_true.                                 ' TO lt_line.
      ENDIF.
      IF gs_alv-edit IS NOT INITIAL.
        APPEND '    gs_fieldcat-edit = abap_true.                                 ' TO lt_line.
        APPEND '    gs_fieldcat-tabname = abap_true.                                 ' TO lt_line.

      ENDIF.
      APPEND '    APPEND gs_fieldcat TO gt_fieldcat.                                  ' TO lt_line.
      APPEND '    CLEAR gs_fieldcat.                                                  ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
    ENDLOOP.

    APPEND '  ENDMETHOD. "METHOD z_fieldcat.                                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  METHOD z_show_alv.                                                    ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '*** Cria o objeto para adicionar o ALV                                  ' TO lt_line.
    APPEND '    CREATE OBJECT go_alv                                                ' TO lt_line.
    APPEND '      EXPORTING                                                         ' TO lt_line.
    APPEND '        i_parent = go_container.                                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '* Define o ALV no objeto go-grid                                        ' TO lt_line.
    APPEND '    CALL METHOD go_alv->set_table_for_first_display                     ' TO lt_line.
    APPEND '      EXPORTING                                                         ' TO lt_line.
    APPEND '        i_save                        = ''A''                           ' TO lt_line.
    APPEND '        is_layout                     = gs_layout                       ' TO lt_line.
    APPEND '      CHANGING                                                          ' TO lt_line.
    APPEND '        it_outtab                     = gt_alv                          ' TO lt_line.
    APPEND '        it_fieldcatalog               = gt_fieldcat                     ' TO lt_line.
    APPEND '        it_sort                       = gt_sort                         ' TO lt_line.
    APPEND '      EXCEPTIONS                                                        ' TO lt_line.
    APPEND '        invalid_parameter_combination = 1                               ' TO lt_line.
    APPEND '        program_error                 = 2                               ' TO lt_line.
    APPEND '        too_many_lines                = 3                               ' TO lt_line.
    APPEND '        OTHERS                        = 4.                              ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    IF cb_clic1 IS NOT INITIAL.
      APPEND '* Define os handlers para o ALV                                         ' TO lt_line.
      APPEND '    DATA gr_event_handler TYPE REF TO lcl_event_handler.                ' TO lt_line.
      APPEND '    CREATE OBJECT gr_event_handler.                                     ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '* Registrando os eventos                                                ' TO lt_line.
      APPEND '    SET HANDLER gr_event_handler->handle_hotspot_click FOR go_alv.      ' TO lt_line.
      APPEND '    SET HANDLER gr_event_handler->handle_toolbar FOR go_alv.            ' TO lt_line.
      APPEND '    SET HANDLER gr_event_handler->handle_user_command FOR go_alv.       ' TO lt_line.
    ENDIF.
    APPEND '                                                                        ' TO lt_line.
    APPEND '    CALL METHOD go_alv->set_toolbar_interactive.                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND '  ENDMETHOD. "METHOD z_show_alv.                                        ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    APPEND 'ENDCLASS. "CLASS lcl_main                                               ' TO lt_line.
    APPEND '                                                                        ' TO lt_line.
    IF cb_clic1 IS NOT INITIAL.
      APPEND 'CLASS lcl_event_handler IMPLEMENTATION .                                ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '*--Handle Toolbar                                                       ' TO lt_line.
      APPEND '  METHOD handle_toolbar.                                                ' TO lt_line.
      APPEND '    PERFORM handle_toolbar USING e_object.                              ' TO lt_line.
      APPEND '  ENDMETHOD .                    "handle_toolbar                        ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '*--Handle User Command                                                  ' TO lt_line.
      APPEND '  METHOD handle_user_command .                                          ' TO lt_line.
      APPEND '    PERFORM handle_user_command USING e_ucomm.                          ' TO lt_line.
      APPEND '  ENDMETHOD.                    "handle_user_command                    ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '*--Handle Hotspot Click                                                 ' TO lt_line.
      APPEND '  METHOD handle_hotspot_click .                                         ' TO lt_line.
      APPEND '    PERFORM handle_hotspot_click USING e_row_id e_column_id es_row_no . ' TO lt_line.
      APPEND '  ENDMETHOD .                                                           ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'ENDCLASS .                    "lcl_event_handler IMPLEMENTATION         ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '*-----------------------------------------------------------------------' TO lt_line.
      APPEND '*                           PROCESSAMENTO                               ' TO lt_line.
      APPEND '*-----------------------------------------------------------------------' TO lt_line.
      APPEND '*-----------------------------------------------------------------------' TO lt_line.
      APPEND '*                    IMPLEMENTAÇÃO DE SUB-ROTINAS                       ' TO lt_line.
      APPEND '*-----------------------------------------------------------------------' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'FORM handle_hotspot_click USING i_row_id    TYPE lvc_s_row              ' TO lt_line.
      APPEND '                                i_column_id TYPE lvc_s_col              ' TO lt_line.
      APPEND '                                is_row_no   TYPE lvc_s_roid.            ' TO lt_line.
      APPEND '  FIELD-SYMBOLS: <ls_alv> LIKE LINE OF gt_alv.                          ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  READ TABLE gt_alv ASSIGNING <ls_alv> INDEX is_row_no-row_id.          ' TO lt_line.
      APPEND '  CHECK sy-subrc = 0.                                                   ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  CASE i_column_id.                                                     ' TO lt_line.

      IF cb_chec1 IS NOT INITIAL.
        APPEND '    WHEN ''CHECK''.                                                     ' TO lt_line.
        APPEND '      IF <ls_alv>-check IS INITIAL."Se o checkbox não estiver selecionad' TO lt_line.
        APPEND '        <ls_alv>-check = ''X''."Marca checkbox em todas as linhas.      ' TO lt_line.
        APPEND '      ELSE.                                                             ' TO lt_line.
        APPEND '        <ls_alv>-check = ''''. "Desmarca checkbox em todas as linhas.   ' TO lt_line.
        APPEND '      ENDIF.                                                            ' TO lt_line.
      ENDIF.

      APPEND '  WHEN OTHERS.                                                          ' TO lt_line.
      APPEND '  ENDCASE.                                                              ' TO lt_line.
      APPEND '  CALL METHOD go_alv->refresh_table_display.                            ' TO lt_line.
      APPEND 'ENDFORM.                                     "handle_hotspot_click      ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'FORM handle_toolbar USING i_object TYPE REF TO cl_alv_event_toolbar_set.' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  DATA: ls_toolbar TYPE stb_button.                                     ' TO lt_line.
      APPEND '  CLEAR ls_toolbar.                                                     ' TO lt_line.
      APPEND '  MOVE 3 TO ls_toolbar-butn_type.                                       ' TO lt_line.
      APPEND '  APPEND ls_toolbar TO i_object->mt_toolbar.                            ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  CLEAR ls_toolbar.                                                     ' TO lt_line.
      APPEND '  MOVE ''F01'' TO ls_toolbar-function.                                  ' TO lt_line.
      APPEND '  MOVE icon_expand TO ls_toolbar-icon.                                  ' TO lt_line.
      APPEND '  MOVE ''Ver Requisição de Compras'' TO ls_toolbar-quickinfo.           ' TO lt_line.
      APPEND '  MOVE ''Req de Compras'' TO ls_toolbar-text.                           ' TO lt_line.
      APPEND '  MOVE space TO ls_toolbar-disabled.                                    ' TO lt_line.
      APPEND '  APPEND ls_toolbar TO i_object->mt_toolbar.                            ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'ENDFORM.                    "handle_toolbar                             ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'FORM handle_user_command USING i_ucomm TYPE syucomm.                    ' TO lt_line.
      APPEND '  DATA: da_repid LIKE sy-repid.                                         ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  CASE i_ucomm.                                                         ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '    WHEN ''''.                                                          ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '    WHEN OTHERS.                                                        ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND '  ENDCASE.                                                              ' TO lt_line.
      APPEND '                                                                        ' TO lt_line.
      APPEND 'ENDFORM.                    " handle_user_command                       ' TO lt_line.
    ENDIF.
  ENDIF.
ENDFORM.