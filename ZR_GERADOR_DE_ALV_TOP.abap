*&---------------------------------------------------------------------*
*&  Include           ZR_GERADOR_DE_ALV_TOP
*&---------------------------------------------------------------------*
DATA: lt_line   TYPE STANDARD TABLE OF char200.
TABLES: mara.

TYPES: BEGIN OF ty_alv,
         nome_campo(18)  TYPE c, "Nome do campo:
         tab_ref(18)     TYPE c, "Tabela Referência:
         campo_ref(18)   TYPE c, "Campo Referência:
         text_colunm(18) TYPE c, "Texto da Coluna:
         fixed(1)        TYPE c, "Coluna fixa no ALV: 1 = sim 0 = não
         edit(1)         TYPE c, "Coluna editável: 1 = sim 0 = não
         link_click(1)   TYPE c, "Coluna com link clicável: 1 = sim 0 = não
         order_up(1)     TYPE c, "Ordena
         order_down(1)   TYPE c, "Ordena
       END OF ty_alv.

*-----------------------------------------------------------------------
*                         TABELAS INTERNAS
*-----------------------------------------------------------------------
DATA:
  gt_alv      TYPE TABLE OF ty_alv,
  gt_sort     TYPE lvc_t_sort,
  gt_fieldcat TYPE lvc_t_fcat.

*-----------------------------------------------------------------------
*                       ESTRUTURAS INTERNAS
*-----------------------------------------------------------------------
DATA:
*** Estrutura para Saída
  gs_alv      TYPE ty_alv,
*** Estrutura de Layout
  gs_layout   TYPE lvc_s_layo,
*** Estrutura de Ordenação
  gs_sort     TYPE lvc_s_sort,
*** Estrutura da Fieldcat
  gs_fieldcat TYPE lvc_s_fcat.

*-----------------------------------------------------------------------
*                      FIELD-SYMBOLS GLOBAIS
*-----------------------------------------------------------------------
FIELD-SYMBOLS:
<gs_alv>  TYPE ty_alv.

*-----------------------------------------------------------------------
*                       DEFINIÇÃO DE CLASSES
*-----------------------------------------------------------------------
CLASS lcl_main DEFINITION.
  PUBLIC SECTION.

    METHODS:
      constructor,
      z_select_data,
      z_call_screen.

ENDCLASS. "CLASS lcl_main

CLASS lcl_alv DEFINITION.
  PUBLIC SECTION.

    METHODS:
      constructor,
      z_layout,
*      z_sort,
      z_fieldcat,
      z_show_alv.

ENDCLASS. "CLASS lcl_alv

CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    METHODS:
*--To add new functional buttons to the ALV toolbar
      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,

      handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm,

      handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id e_column_id es_row_no.

ENDCLASS. "lcl_event_handler DEFINITION

*-----------------------------------------------------------------------
*                        DEFINIÇÃO DE OBJETOS
*-----------------------------------------------------------------------
DATA:

*** Objeto para ALV
  go_alv       TYPE REF TO cl_gui_alv_grid,
*** Container
  go_container TYPE REF TO cl_gui_container.
*-----------------------------------------------------------------------