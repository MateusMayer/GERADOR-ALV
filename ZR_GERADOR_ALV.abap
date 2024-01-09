*&---------------------------------------------------------------------*
*&
*&               GERADOR DE ALV COM CL_SALV_TABLE
*&
*&---------------------------------------------------------------------*
REPORT zr_gerador_de_alv.

INCLUDE: zr_gerador_de_alv_top."Variáveis
INCLUDE: zr_gerador_de_alv_scr."Telas de seleção.
**----------------------------------------------------------------------*
** EXECUÇÃO PRINCIPAL DO PROGRAMA                                 INÍCIO
**----------------------------------------------------------------------*
START-OF-SELECTION.

*-->Cria uma instância da classe principal do programa.
  DATA(lo_main) = NEW lcl_main( ).

*-->Seleciona os dados.
  lo_main->z_select_data( ).

  lo_main->z_call_screen( ).

  INCLUDE: zr_gerador_de_alv_cl1."cl_salv_table
  INCLUDE: zr_gerador_de_alv_cl2."cl_gui_grid_alv
  INCLUDE: zr_gerador_de_alv_f01."processamento gerador parte 1
  INCLUDE: zr_gerador_de_alv_f02."processamento gerador parte 2