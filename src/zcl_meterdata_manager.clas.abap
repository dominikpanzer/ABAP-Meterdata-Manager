*&---------------------------------------------------------------------*
*& Beschreibung:                                                       *
*& METERDATA MANAGER                                                   *
*&---------------------------------------------------------------------*
*& Geändert     Autor      Grund
*& Neu          XXXXXXXX   Ersterstellung
*& 20120605     XXXXXXXX   nervige Sprachausgabe hinzugefügt
*&                          - XXXXXXXX _2012060500
*& 20131001     XXXXXXXX   LG zu TL
*& 20140320     XXXXXXXX   Versionierung und das Gewirr  hier AUFRÄUMEN!
*& 20140804     XXXXXXXX   TICKETNUMMER -> Korrektur
*& 20150803     XXXXXXXX   TICKETNUMMER Versand in Hintergrundjob
*& 20161012     XXXXXXXX   TICKETNUMMER Integration Befüllungsjob
*& 20180821     XXXXXXXX   TICKETNUMMER Sperrkonzept
*& 20191219     XXXXXXXX   neue Variante
*&                         Blöden 72 Zeichen Feldkatalog rausgeworfen!!
*& 20200427     XXXXXXXX   Jobabrüche, Konvertierung TIMESTAMP
*&---------------------------------------------------------------------*
CLASS zcl_meterdata_manager DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS manage IMPORTING meterreadingvalue TYPE int4
                             date              TYPE dats
                             vks               TYPE int4
                             contract          TYPE char20
                   RETURNING VALUE(success)    TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_meterdata_manager IMPLEMENTATION.


  METHOD manage.
    DATA: customer          TYPE char20,
          mrvalue_as_number TYPE string.
    DATA counter TYPE int4.
    DATA: zeabl TYPE TABLE OF zeabl.


    DATA eabl_old TYPE zeabl.
    DATA allright TYPE abap_Bool.

    mrvalue_as_number = meterreadingvalue.
    CONDENSE mrvalue_as_number.

* check if customer is valid
    IF meterreadingvalue IS NOT INITIAL.
      IF contract IS INITIAL.
        success = ''.
        EXIT.
      ELSE.
        IF meterreadingvalue > 0 AND strlen( mrvalue_as_number ) <= vks.
* Alle Ablesungen ermitteln
          SELECT * FROM zeabl WHERE vertrag = @contract INTO CORRESPONDING FIELDS OF TABLE @zeabl.

          " hier noch appenden und sotieren
          Zeabl = VALUE #( BASE zeabl ( ablbelnr = '' adat = date vertrag = contract zaehlerstand = meterreadingvalue ) ).
          SORT zeabl BY adat ASCENDING.
* allright
          allright = 'X'.
          LOOP AT zeabl ASSIGNING FIELD-SYMBOL(<eabl_line>).
            IF eabl_old-zaehlerstand > <eabl_line>-zaehlerstand OR lines( zeabl ) <> 12.
              allright = ''.
            ENDIF.
            Eabl_old = <eabl_line>.
          ENDLOOP.
          IF allright = ''.
            EXIT.
          ENDIF.
* calculate usage
          DATA(usg) = zeabl[ lines( zeabl ) ]-zaehlerstand - zeabl[ 1 ]-zaehlerstand.

          IF usg > 0.

*          CALL FUNCTION 'ZBILLIT'
*            EXPORTING
*              billdate = '99991231'
*              usage    = usg_text
*              contract = '0593053'.
*              success = 'X'.
            CALL FUNCTION 'ZBILLIT'
              EXPORTING
                billdate = sy-datum
                usage    = usg
                contract = contract.
            success = 'X'.
          ELSE.
            success = ''.
          ENDIF.
        ELSE.
          success = ''.
          IF usg IS INITIAL.
            success = ''.
          ENDIF.
        ENDIF.
      ENDIF.
    ELSE.
      success = ''.
    ENDIF.
  ENDMETHOD.
ENDCLASS.



