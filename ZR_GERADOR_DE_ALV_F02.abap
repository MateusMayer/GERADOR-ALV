*&---------------------------------------------------------------------*
*&  Include           ZR_GERADOR_DE_ALV_F02
*&---------------------------------------------------------------------*
*-----------------------------------------------------------------------
*                           PROCESSAMENTO
*-----------------------------------------------------------------------
*-----------------------------------------------------------------------
*                          EVENTOS DE TELA
*-----------------------------------------------------------------------
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'ZPF0100'.
  SET TITLEBAR 'ZTB0100'.

* Monta o ALV
*-->Cria uma instância da classe do ALV.
  DATA(lo_alv) = NEW lcl_alv( ).

  lo_alv->z_layout( ) .
*  lo_alv->z_sort( ).
  lo_alv->z_fieldcat( ).
  lo_alv->z_show_alv( ).

ENDMODULE.                 " STATUS_0100  OUTPUT

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK'.
      SET SCREEN 0.
    WHEN 'EXIT' .
      SET SCREEN 0.
    WHEN 'CANCEL' .
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE. " USER_COMMAND_0100  INPUT
*-----------------------------------------------------------------------
*                           PROCESSAMENTO
*-----------------------------------------------------------------------
*-----------------------------------------------------------------------
*                     IMPLEMENTAÇÃO DAS CLASSES
*-----------------------------------------------------------------------
CLASS lcl_main IMPLEMENTATION.
  METHOD constructor.
  ENDMETHOD.

  METHOD z_select_data.
    DO p_alv TIMES.
      APPEND gs_alv TO gt_alv.
    ENDDO.
  ENDMETHOD. "METHOD z_select_data.

  METHOD z_call_screen.

    IF gt_alv IS NOT INITIAL.
      CALL SCREEN '0100'."Chama a tela para mostrar o ALV
    ELSE.
      MESSAGE i398(00) WITH text-002. "Não há dados para exibição
    ENDIF.

  ENDMETHOD. "METHOD z_call_screen.

ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.

  METHOD constructor.
  ENDMETHOD.

  METHOD z_layout.
    " Estruturas de Layout
    gs_layout-zebra       = 'X'.   "Linhas do relatório zebradas
    gs_layout-cwidth_opt  = 'X'.   "Otimização do tamanho das colunas
  ENDMETHOD. "METHOD z_layout.
*
*  METHOD z_sort.
*    gs_sort-spos = 1.
*    gs_sort-fieldname = 'CAMPO1'.
*    gs_sort-up = 'X'.
*    APPEND gs_sort TO gt_sort .
*  ENDMETHOD. "METHOD z_sort.

  METHOD z_fieldcat.

    gs_fieldcat-coltext   = 'Nome do Campo'.
    gs_fieldcat-tabname   = 'GT_ALV'.
    gs_fieldcat-fieldname = 'NOME_CAMPO'.
    gs_fieldcat-ref_table = 'MARA'.
    gs_fieldcat-ref_field  = 'MATNR'.
    gs_fieldcat-edit = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Tabela Referência'.
    gs_fieldcat-fieldname = 'tab_ref'.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'MARA'.
    gs_fieldcat-ref_field  = 'MATNR'.
    gs_fieldcat-edit = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Campo Referência'.
    gs_fieldcat-fieldname = 'campo_ref'.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'MARA'.
    gs_fieldcat-ref_field  = 'MATNR'.
    gs_fieldcat-edit = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Texto Coluna'.
    gs_fieldcat-fieldname = 'text_colunm'.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'MARA'.
    gs_fieldcat-ref_field  = 'MATNR'.
    gs_fieldcat-edit = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Fixar Coluna'.
    gs_fieldcat-fieldname = 'fixed'.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'OTR_BVOC'.
    gs_fieldcat-ref_field  = 'FLAG1'.
    gs_fieldcat-edit = abap_true.
    gs_fieldcat-checkbox = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Editável'.
    gs_fieldcat-fieldname = 'edit'.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'OTR_BVOC'.
    gs_fieldcat-ref_field  = 'FLAG1'.
    gs_fieldcat-edit = abap_true.
    gs_fieldcat-checkbox = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Link Click'.
    gs_fieldcat-fieldname = 'link_click'. "Nome do campo.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'OTR_BVOC'.
    gs_fieldcat-ref_field  = 'FLAG1'.
    gs_fieldcat-edit = abap_true.
    gs_fieldcat-checkbox = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Ordena ASC'.
    gs_fieldcat-fieldname = 'order_up'. "Nome do campo.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'OTR_BVOC'.
    gs_fieldcat-ref_field  = 'FLAG1'.
    gs_fieldcat-edit = abap_true.
    gs_fieldcat-checkbox = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

    gs_fieldcat-coltext   = 'Ordena DESC'.
    gs_fieldcat-fieldname = 'order_down'. "Nome do campo.
    gs_fieldcat-tabname = 'GT_ALV'.
    gs_fieldcat-ref_table = 'OTR_BVOC'.
    gs_fieldcat-ref_field  = 'FLAG1'.
    gs_fieldcat-edit = abap_true.
    gs_fieldcat-checkbox = abap_true.
    APPEND gs_fieldcat TO gt_fieldcat.
    CLEAR gs_fieldcat.

  ENDMETHOD. "METHOD z_fieldcat.

  METHOD z_show_alv.

*** Cria o objeto para adicionar o ALV
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.

* Define o ALV no objeto go-grid
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        i_save                        = 'A'
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_alv
        it_fieldcatalog               = gt_fieldcat
*       it_sort                       = gt_sort
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.

* Define os handlers para o ALV
    DATA gr_event_handler TYPE REF TO lcl_event_handler.
    CREATE OBJECT gr_event_handler.

    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.

* Registrando os eventos
    SET HANDLER gr_event_handler->handle_hotspot_click FOR go_alv.
    SET HANDLER gr_event_handler->handle_toolbar FOR go_alv.
    SET HANDLER gr_event_handler->handle_user_command FOR go_alv.

    CALL METHOD go_alv->set_toolbar_interactive.

  ENDMETHOD. "METHOD z_show_alv.

ENDCLASS. "CLASS lcl_main

CLASS lcl_event_handler IMPLEMENTATION .

*--Handle Toolbar
  METHOD handle_toolbar.
    PERFORM handle_toolbar USING e_object.
  ENDMETHOD .                    "handle_toolbar

*--Handle User Command
  METHOD handle_user_command .
    PERFORM handle_user_command USING e_ucomm.
  ENDMETHOD.                    "handle_user_command

*--Handle Hotspot Click
  METHOD handle_hotspot_click .
    PERFORM handle_hotspot_click USING e_row_id e_column_id es_row_no .
  ENDMETHOD .

ENDCLASS .                    "lcl_event_handler IMPLEMENTATION

*-----------------------------------------------------------------------
*                           PROCESSAMENTO
*-----------------------------------------------------------------------
*-----------------------------------------------------------------------
*                    IMPLEMENTAÇÃO DE SUB-ROTINAS
*-----------------------------------------------------------------------

FORM handle_hotspot_click USING i_row_id    TYPE lvc_s_row
                                i_column_id TYPE lvc_s_col
                                is_row_no   TYPE lvc_s_roid.
  FIELD-SYMBOLS: <ls_alv> LIKE LINE OF gt_alv.

  READ TABLE gt_alv ASSIGNING <ls_alv> INDEX is_row_no-row_id.
  CHECK sy-subrc = 0.

  CASE i_column_id.
    WHEN ''.

    WHEN OTHERS.
  ENDCASE.
  CALL METHOD go_alv->refresh_table_display.
ENDFORM.                                     "handle_hotspot_click

FORM handle_toolbar USING i_object TYPE REF TO cl_alv_event_toolbar_set.

  DATA: ls_toolbar TYPE stb_button.
  CLEAR ls_toolbar.
  MOVE 3 TO ls_toolbar-butn_type.
  APPEND ls_toolbar TO i_object->mt_toolbar.

  CLEAR ls_toolbar.
  MOVE 'F01' TO ls_toolbar-function.
  MOVE icon_execute_object TO ls_toolbar-icon.
  MOVE 'Gerar relatório' TO ls_toolbar-quickinfo.
*  MOVE 'Gerar ALV' TO ls_toolbar-text.
  MOVE space TO ls_toolbar-disabled.
  APPEND ls_toolbar TO i_object->mt_toolbar.

ENDFORM.                    "handle_toolbar

FORM handle_user_command USING i_ucomm TYPE syucomm.
  DATA: da_repid LIKE sy-repid.
  DATA: lv_aux TYPE char1.

  CASE i_ucomm.

    WHEN 'F01'.

      IF p_alv > 0.
        IF rb_cl1 IS NOT INITIAL.
          PERFORM z_gera_cl_salv_table.

        ELSEIF rb_cl2 IS NOT INITIAL.
          PERFORM z_gera_cl_gui_alv_grid.
        ENDIF.
      ELSE.
        MESSAGE 'Quantidade de colunas inválida.' TYPE 'S' DISPLAY LIKE 'E'.
        LEAVE LIST-PROCESSING.
      ENDIF.

      CLEAR gs_alv.
      LOOP AT gt_alv INTO gs_alv.
        IF gs_alv-nome_campo IS NOT INITIAL
          AND gs_alv-text_colunm IS NOT INITIAL
          AND gs_alv-campo_ref IS NOT INITIAL
          AND gs_alv-tab_ref IS NOT INITIAL.

          IF lt_line IS NOT INITIAL.
            PERFORM zdownload_from_tab_txt.
          ENDIF.
        ELSE.
          MESSAGE 'Preencha corretamente todos os campos de texto.' TYPE 'S' DISPLAY LIKE 'E'.
          LEAVE LIST-PROCESSING.
        ENDIF.
      ENDLOOP.
    WHEN OTHERS.

  ENDCASE.

ENDFORM.                    " handle_user_command