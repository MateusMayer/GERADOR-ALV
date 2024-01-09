*&---------------------------------------------------------------------*
*&  Include           ZR_GERADOR_DE_ALV_CL1
*&---------------------------------------------------------------------*

************************TOP DO PROGRAMA GERADO**************************************
FORM z_gera_cl_salv_table.
  CLEAR lt_line.
  IF rb_cl1 IS NOT INITIAL.
    CONCATENATE 'REPORT' p_prog INTO DATA(lv_report) SEPARATED BY space.
    CONCATENATE lv_report '.' INTO DATA(lv_report1).
    APPEND lv_report1 TO lt_line.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
    APPEND '*-----------------------------INÍCIO DO TOP-------------------------------------*' TO lt_line.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
    APPEND 'TABLES: mara.' TO lt_line.
    APPEND space TO lt_line.
*    IF cb_click IS NOT INITIAL.
      APPEND 'CLASS lcl_handle_events DEFINITION DEFERRED. "classe de eventos do mouse.' TO lt_line.
*    ENDIF.
    APPEND 'TYPES: BEGIN OF ty_alv,' TO lt_line.

*    IF cb_check IS NOT INITIAL.
      APPEND 'checkbox(1) TYPE C, "Checkbox' TO lt_line.
*    ENDIF.

    DATA: lv_campo TYPE c LENGTH 50.
    DATA: lv_contador TYPE c LENGTH 1 VALUE 0.

    IF p_alv > 0.
      DO p_alv TIMES.
      lv_contador = lv_contador + 1.
      CONCATENATE: 'campo' lv_contador '(20) TYPE C,' INTO lv_campo.
      APPEND lv_campo TO lt_line.
      ENDDO.
    ENDIF.

    APPEND 'END OF ty_alv.' TO lt_line.
    APPEND space TO lt_line.

    APPEND 'DATA: gt_alv TYPE TABLE OF ty_alv.' TO lt_line.
    APPEND 'DATA: gs_alv TYPE ty_alv.' TO lt_line.

    APPEND '*-- Variaveis de apresentação do ALV' TO lt_line.
    APPEND 'DATA: gr_table TYPE REF TO cl_salv_table.' TO lt_line.
    APPEND 'DATA: gr_container TYPE REF TO cl_gui_custom_container.' TO lt_line.
*    IF cb_click IS NOT INITIAL.
      APPEND 'DATA: gr_events    TYPE REF TO lcl_handle_events.' TO lt_line.
*    ENDIF.

    APPEND 'DATA: lr_column    TYPE REF TO cl_salv_column_list.' TO lt_line.
    APPEND 'DATA: lr_selections TYPE REF TO cl_salv_selections.' TO lt_line.
    APPEND space TO lt_line.

    APPEND '*---------------------------------------------------------------------*' TO lt_line.
    APPEND '*       CLASS lcl_process DEFINITION                            INICIO' TO lt_line.
    APPEND '*---------------------------------------------------------------------*' TO lt_line.
    APPEND 'CLASS lcl_main DEFINITION.' TO lt_line.
    APPEND 'PUBLIC SECTION.' TO lt_line.
    APPEND '    METHODS:' TO lt_line.
    APPEND '      constructor,' TO lt_line.
    APPEND '      z_select_data,"seleciona dados' TO lt_line.
    APPEND '      z_processes_data,"Processa dados' TO lt_line.
    APPEND '      z_show_data."mostra dados' TO lt_line.
    APPEND 'ENDCLASS."lcl_process DEFINITION' TO lt_line.
    DO 3 TIMES.
      APPEND space TO lt_line.
    ENDDO.
*    IF cb_click IS NOT INITIAL.
      APPEND '*---------------------------------------------------------------------*' TO lt_line.
      APPEND '*       CLASS lcl_handle_events DEFINITION                       INICIO' TO lt_line.
      APPEND '*---------------------------------------------------------------------*' TO lt_line.
      APPEND 'CLASS lcl_handle_events DEFINITION.' TO lt_line.
      APPEND 'PUBLIC SECTION.' TO lt_line.
      APPEND '    METHODS:' TO lt_line.
      APPEND 'on_user_command FOR EVENT added_function OF cl_salv_events "aciona ao clicar em botão' TO lt_line.
      APPEND 'IMPORTING e_salv_function,' TO lt_line.
      APPEND space TO lt_line.
      APPEND 'on_double_click FOR EVENT double_click OF cl_salv_events_table "aciona ao clicar duas vezes' TO lt_line.
      APPEND 'IMPORTING row column, "importa linha e coluna.' TO lt_line.
      APPEND space TO lt_line.
      APPEND 'on_link_click FOR EVENT link_click OF cl_salv_events_table "aciona ao clicar uma vez.' TO lt_line.
      APPEND 'IMPORTING row column. "importa linha e coluna.' TO lt_line.
      APPEND 'ENDCLASS."lcl_handle_events DEFINITION' TO lt_line.
      DO 3 TIMES.
        APPEND space TO lt_line.
      ENDDO.
*    ENDIF.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
    APPEND '*-----------------------------FIM DO TOP----------------------------------------*' TO lt_line.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
*************************TELA DE SELEÇÃO PROGRAMA GERADO*****************************
    APPEND space TO lt_line.
    APPEND '*---------------------------------------------------------------------*' TO lt_line.
    APPEND '*                    INÍCIO TELA DE SELEÇÃO                      INÍCIO' TO lt_line.
    APPEND '*---------------------------------------------------------------------*' TO lt_line.
    APPEND 'SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE titulo.' TO lt_line.
    APPEND 'SELECT-OPTIONS: s_matnr FOR mara-matnr.' TO lt_line.
    APPEND 'SELECTION-SCREEN END OF BLOCK b1.' TO lt_line.
    APPEND space TO lt_line.
    APPEND '*---------------------------------------------------------------------*' TO lt_line.
    APPEND '*                    FIM TELA DE SELEÇÃO                            FIM' TO lt_line.
    APPEND '*---------------------------------------------------------------------*' TO lt_line.
    DO 3 TIMES.
      APPEND space TO lt_line.
    ENDDO.
*************************************************************************************
    APPEND '**---------------------------------------------------------------------*' TO lt_line.
    APPEND '**               EXECUÇÃO PRINCIPAL DO PROGRAMA                   INÍCIO' TO lt_line.
    APPEND '**---------------------------------------------------------------------*' TO lt_line.
    APPEND space TO lt_line.
    APPEND 'START-OF-SELECTION.' TO lt_line.
    APPEND space TO lt_line.
    APPEND '*-->Cria uma instância da classe principal do programa.' TO lt_line.
    APPEND 'DATA(lo_main) = NEW lcl_main( ).' TO lt_line.
    APPEND space TO lt_line.
    APPEND '*-->Seleciona os dados.' TO lt_line.
    APPEND 'lo_main->z_select_data( ).' TO lt_line.
    APPEND space TO lt_line.
    APPEND 'IF gt_alv[] IS NOT INITIAL.' TO lt_line.
    APPEND '*-->Mostra os dados.' TO lt_line.
    APPEND 'lo_main->z_show_data( ).' TO lt_line.
    APPEND 'ENDIF.' TO lt_line.
    APPEND space TO lt_line.
    APPEND '**---------------------------------------------------------------------*' TO lt_line.
    APPEND '**               EXECUÇÃO PRINCIPAL DO PROGRAMA                      FIM' TO lt_line.
    APPEND '**---------------------------------------------------------------------*' TO lt_line.
***********************INÍCIO PROCESSAMETO F01 PROGRAMA GERADO***************************
    APPEND space TO lt_line.

    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
    APPEND '*-----------------------------INÍCIO DO F01-------------------------------------*' TO lt_line.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
    IF rb_cl1 IS NOT INITIAL.
*      IF cb_click IS NOT INITIAL.
        APPEND '*---------------------------------------------------------------------*' TO lt_line.
        APPEND '*       CLASS lcl_handle_events IMPLEMENTATION                  INICIO"' TO lt_line.
        APPEND '*---------------------------------------------------------------------*' TO lt_line.
        APPEND 'CLASS lcl_handle_events IMPLEMENTATION.' TO lt_line.
        APPEND 'METHOD on_user_command.' TO lt_line.
        APPEND '"Chama FORM com processamento dos botões.' TO lt_line.
        APPEND 'PERFORM handle_user_command USING e_salv_function.' TO lt_line.
        APPEND 'ENDMETHOD.' TO lt_line.

        APPEND space TO lt_line.

        APPEND 'METHOD on_double_click.' TO lt_line.
        APPEND 'ENDMETHOD.' TO lt_line.

        APPEND space TO lt_line.

        APPEND 'METHOD on_link_click.' TO lt_line.
        APPEND 'ENDMETHOD.' TO lt_line.
        APPEND 'ENDCLASS.' TO lt_line.

        APPEND '*---------------------------------------------------------------------*' TO lt_line.
        APPEND '*       CLASS lcl_handle_events IMPLEMENTATION                     FIM ' TO lt_line.
        APPEND '*---------------------------------------------------------------------*' TO lt_line.
*      ENDIF.


      APPEND '*---------------------------------------------------------------------*' TO lt_line.
      APPEND '*       CLASS lcl_process IMPLEMENTATION                        INICIO"' TO lt_line.
      APPEND '*---------------------------------------------------------------------*' TO lt_line.
      APPEND 'CLASS lcl_main IMPLEMENTATION.' TO lt_line.
      APPEND 'METHOD constructor.' TO lt_line.
      APPEND 'ENDMETHOD.' TO lt_line.

      APPEND space TO lt_line.
      APPEND 'METHOD z_select_data.' TO lt_line.
      APPEND 'APPEND INITIAL LINE TO gt_alv.' TO lt_line.
      APPEND 'ENDMETHOD.' TO lt_line.

      APPEND space TO lt_line.

      APPEND 'METHOD z_processes_data.' TO lt_line.
      APPEND '' TO lt_line.
      APPEND 'ENDMETHOD.' TO lt_line.

      APPEND space TO lt_line.

      APPEND 'METHOD z_show_data.' TO lt_line.
      APPEND 'TRY.' TO lt_line.
      APPEND 'cl_salv_table=>factory(' TO lt_line.
      APPEND 'IMPORTING' TO lt_line.
      APPEND 'r_salv_table = gr_table' TO lt_line.
      APPEND 'CHANGING' TO lt_line.
      APPEND 't_table = gt_alv ).' TO lt_line.
      APPEND 'CATCH cx_salv_msg.' TO lt_line.
      APPEND 'ENDTRY.' TO lt_line.

      APPEND space TO lt_line.

*      IF cb_gui IS NOT INITIAL.
*        APPEND 'DATA(lr_func) = gr_table->get_functions( ).' TO lt_line.
*        APPEND 'lr_func->set_all( ).' TO lt_line.
*      ENDIF.

      APPEND space TO lt_line.

      APPEND '*-- Colunas' TO lt_line.
      APPEND 'DATA(lr_columns) = gr_table->get_columns( ).' TO lt_line.
      APPEND 'lr_columns->set_optimize( abap_true )."Comando para otimizar a largura das colunas.' TO lt_line.
      APPEND 'PERFORM zf_change_columns USING lr_columns.' TO lt_line.
      APPEND 'DATA: lr_events TYPE REF TO cl_salv_events_table.' TO lt_line.
      APPEND 'lr_events = gr_table->get_event( ).' TO lt_line.

      APPEND space TO lt_line.
*      IF cb_click IS NOT INITIAL.
        APPEND 'CREATE OBJECT gr_events.' TO lt_line.
        APPEND 'SET HANDLER gr_events->on_user_command FOR lr_events.' TO lt_line.

        APPEND space TO lt_line.

        APPEND 'SET HANDLER gr_events->on_double_click FOR lr_events.' TO lt_line.

        APPEND space TO lt_line.

        APPEND 'SET HANDLER gr_events->on_link_click FOR lr_events.' TO lt_line.

        APPEND space TO lt_line.
*      ENDIF.

      APPEND 'gr_table->display( ).' TO lt_line.
      APPEND 'ENDMETHOD.' TO lt_line.

      APPEND space TO lt_line.

      APPEND 'ENDCLASS.' TO lt_line.
      APPEND '*---------------------------------------------------------------------*' TO lt_line.
      APPEND '*       CLASS lcl_process IMPLEMENTATION                           FIM"' TO lt_line.
      APPEND '*---------------------------------------------------------------------*' TO lt_line.
    ENDIF.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
    APPEND '*------------------------------FIM-DO-F01---------------------------------------*' TO lt_line.
    APPEND '*-------------------------------------------------------------------------------*' TO lt_line.
  ENDIF.
ENDFORM.
*************************************************************************************